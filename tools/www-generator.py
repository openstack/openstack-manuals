#!/usr/bin/env python

# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.

import argparse
import collections
import glob
import logging
import multiprocessing
import multiprocessing.pool
import os
import os.path
import re
import sys

from bs4 import BeautifulSoup
import jinja2
import jsonschema
import os_service_types
import requests
import yaml


SeriesInfo = collections.namedtuple('SeriesInfo', 'date status')
# The 'date' should be a string containing the month name and 4 digit year.
#
# The 'status' field should be one of:
#   'obsolete'    -- the release existed, but we have no more artifacts for it
#   'EOL'         -- the release is closed but we have docs for it
#   'maintained'  -- the release still has an open branch
#   'development' -- the current release being developed

SERIES_INFO = {
    'austin': SeriesInfo(date='October 2010', status='obsolete'),
    'bexar': SeriesInfo(date='February 2011', status='obsolete'),
    'cactus': SeriesInfo(date='April 2011', status='obsolete'),
    'diablo': SeriesInfo(date='September 2011', status='obsolete'),
    'essex': SeriesInfo(date='April 2012', status='obsolete'),
    'folsom': SeriesInfo(date='September 2012', status='obsolete'),
    'grizzly': SeriesInfo(date='April 2013', status='obsolete'),
    'havana': SeriesInfo(date='October 2013', status='obsolete'),
    'icehouse': SeriesInfo(date='April 2014', status='EOL'),
    'juno': SeriesInfo(date='October 2014', status='EOL'),
    'kilo': SeriesInfo(date='April 2015', status='EOL'),
    'liberty': SeriesInfo(date='October 2015', status='EOL'),
    'mitaka': SeriesInfo(date='April 2016', status='EOL'),
    'newton': SeriesInfo(date='October 2016', status='EOL'),
    'ocata': SeriesInfo(date='February 2017', status='maintained'),
    'pike': SeriesInfo(date='August 2017', status='maintained'),
    'queens': SeriesInfo(date='March 2018', status='maintained'),
    'rocky': SeriesInfo(date='August 2018', status='maintained'),
    'stein': SeriesInfo(date='April 2019', status='development'),
}

# Build a list of the series that are not the current series being
# developed.
PAST_SERIES = [
    name
    for name, info in sorted(SERIES_INFO.items())
    if info.status != 'development'
]

# Find the currently maintained series.
MAINTAINED_SERIES = [
    name
    for name, info in sorted(SERIES_INFO.items())
    if info.status == 'maintained'
]

# Find the most recently released series.
RELEASED_SERIES = MAINTAINED_SERIES[-1]

# Find the series being developed.
SERIES_IN_DEVELOPMENT = [
    name
    for name, info in sorted(SERIES_INFO.items())
    if info.status == 'development'
][0]

# Do not modify this variable.
ALL_SERIES = list(sorted(SERIES_INFO.keys()))

SERIES_PAT = re.compile('^(' + '|'.join(ALL_SERIES) + ')/')


def initialize_logging(debug, verbose):
    """Initialize the Logger."""

    logger = logging.getLogger()
    formatter = logging.Formatter('%(asctime)s %(levelname)-8s %(message)s')
    handler = logging.StreamHandler()
    handler.setFormatter(formatter)
    logger.addHandler(handler)

    if verbose:
        logger.setLevel(logging.INFO)

    if debug:
        logger.setLevel(logging.DEBUG)

    return logger


def parse_command_line_arguments():
    """Parse the command line arguments."""
    parser = argparse.ArgumentParser()
    parser.add_argument("--debug", help="Print debugging messages.",
                        action="store_true", default=False)
    parser.add_argument("--verbose", help="Be more verbose.",
                        action="store_true", default=False)
    parser.add_argument("--source-directory", type=str,
                        default='www', help='Set source directory.')
    parser.add_argument("--output-directory", type=str,
                        default='publish-docs/www',
                        help='Set output directory.')
    parser.add_argument("--check-all-links", action="store_true",
                        default=False,
                        help='Check for links with flags set false.')
    parser.add_argument("--skip-links", action="store_true",
                        default=False,
                        help='Skip link checks')
    parser.add_argument('--series',
                        default=[],
                        action='append',
                        help='series to update/test',
                        )
    parser.add_argument('--skip-render',
                        default=False,
                        action='store_true',
                        help='only test links, do not render templates',
                        )
    parser.add_argument('--strict',
                        default=False,
                        action='store_true',
                        help='treat warnings as errors',
                        )
    parser.add_argument('--project',
                        default=[],
                        action='append',
                        help='project to check (defaults to all)',
                        )
    return parser.parse_args()


def _check_url(args):
    "Return True if the URL exists, False otherwise."
    url, project_name, flag, flag_val = args
    try:
        resp = requests.head(url)
    except requests.exceptions.TooManyRedirects:
        return False, 301
    return (url,
            project_name,
            flag,
            flag_val,
            (resp.status_code // 100) == 2,
            resp.status_code)


# NOTE(dhellmann): List of tuple of flag name and URL template. None
# for the flag name means always apply the URL, otherwise look for a
# True value associated with the flag in the project data.
#
# NOTE(dhellmann): We use URLs with explicit index.html to ensure that
# a real page is published to the location, and we are not retrieving
# a file list generated by the web server.
URLSettings = collections.namedtuple(
    'URLSettings',
    ['flag_name', 'types', 'template'],
)
_URLS = [
    URLSettings(
        flag_name=None,
        types=[],
        template='https://docs.openstack.org/{name}/{series}/index.html',
    ),
    URLSettings(
        flag_name='has_install_guide',
        types=['service'],
        template='https://docs.openstack.org/{name}/{series}/install/index.html',  # noqa
    ),
    URLSettings(
        flag_name='has_admin_guide',
        types=['service'],
        template='https://docs.openstack.org/{name}/{series}/admin/index.html',
    ),
    URLSettings(
        flag_name='has_config_ref',
        types=['service', 'library'],
        template='https://docs.openstack.org/{name}/{series}/configuration/index.html',  # noqa
    ),
    URLSettings(
        flag_name='has_in_tree_api_docs',
        types=['service'],
        template='https://docs.openstack.org/{name}/{series}/api/index.html',
    ),
    URLSettings(
        flag_name='has_user_guide',
        types=['service'],
        template='https://docs.openstack.org/{name}/{series}/user/index.html',
    ),
    URLSettings(
        flag_name='has_api_ref',
        types=['service'],
        template='https://developer.openstack.org/api-ref/{service_type}/index.html',  # noqa
    ),
    URLSettings(
        flag_name='has_api_guide',
        types=['service'],
        template='https://developer.openstack.org/api-guide/{service_type}/index.html',  # noqa
    ),
    URLSettings(
        flag_name='has_deployment_guide',
        types=['deployment'],
        template='https://docs.openstack.org/project-deploy-guide/{name}/{series}/index.html',  # noqa
    ),
]


def load_project_data(source_directory,
                      check_all_links=False,
                      skip_links=False,
                      series_to_load=None,
                      governed_deliverables=[],
                      strict=False,
                      projects_to_check=[]):
    "Return a dict with project data grouped by series."
    logger = logging.getLogger()
    series_to_load = series_to_load or []
    project_data = {}
    fail = False
    service_types = os_service_types.ServiceTypes(
        session=requests.Session(), only_remote=True)
    # Set up a schema validator so we can quickly check that the input
    # data conforms.
    project_schema_filename = os.path.join(
        source_directory,
        'project-data',
        'schema.yaml',
    )
    with open(project_schema_filename, 'r') as f:
        project_schema = yaml.safe_load(f.read())
        validator = jsonschema.Draft4Validator(project_schema)
    # Load the data files, using the file basename as the release
    # series name.
    for filename in glob.glob(
            os.path.join(source_directory, 'project-data', '*.yaml')):
        if filename.endswith('schema.yaml'):
            continue
        series, _ = os.path.splitext(os.path.basename(filename))
        if series_to_load and series not in series_to_load:
            continue

        logger.info('loading %s project data from %s', series, filename)
        with open(filename, 'r') as f:
            raw_data = yaml.safe_load(f.read())
        for error in validator.iter_errors(raw_data):
            logger.error(str(error))
            fail = True

        links_to_check = []
        data = []
        for project in raw_data:
            deliverable_name = project.get('deliverable-name', project['name'])

            if (series == 'latest' and
                    deliverable_name not in governed_deliverables):
                msg = ('{} is no longer part of an official project, '
                       '{} in {}').format(
                           deliverable_name,
                           'error' if strict else 'ignoring',
                           filename)
                logger.warning(msg)
                if strict:
                    logger.info('Known deliverables: %s',
                                sorted(governed_deliverables))
                    raise RuntimeError(msg)
                continue
            logger.info('including %s', deliverable_name)
            data.append(project)

            # If the project has a service-type set, ensure it matches
            # the value in the service-type-authority data.base.
            st = project.get('service_type')
            if st is not None:
                st_data = service_types.get_service_data_for_project(
                    project['name'])
                if not st_data:
                    # It's possible this is a project listed by its
                    # service-type
                    st_data = service_types.get_service_data(st)
                if not st_data:
                    logger.error(
                        'did not find %s in Service Types Authority',
                        project['name'],
                    )
                    fail = True
                elif st != st_data['service_type']:
                    logger.error(
                        'expected service_type %r for %s but got %r',
                        st_data['service_type'], project['name'], st,
                    )
                    fail = True

            # client projects must have a description
            project_type = project.get('type')
            if (project_type in ['cloud-client', 'service-client'] and
                    not project.get('description')):
                logger.error(
                    'client project %s has no description',
                    project['name'],
                )
                fail = True

            # If the project claims to have a separately published guide
            # of some sort, look for it before allowing the flag to stand.
            check_links_this_project = (
                deliverable_name in projects_to_check
                or not projects_to_check
            )
            if check_links_this_project and not skip_links:
                for url_info in _URLS:
                    if url_info.flag_name is None:
                        flag_val = True
                    else:
                        flag_val = project.get(url_info.flag_name, False)
                    if ((not flag_val) and
                            url_info.types and
                            project_type not in url_info.types):
                        # This type of project isn't expected to have
                        # this type of link, so if we are not
                        # explicitly told to check for it don't.
                        continue
                    try:
                        url = url_info.template.format(
                            series=series, **project)
                    except KeyError:
                        # The project data does not include a field needed
                        # to build the URL (typically the
                        # service_type). Ignore this URL, unless the flag
                        # is set.
                        if flag_val:
                            raise
                        continue

                    # Only try to fetch the URL if we're going to do
                    # something with the result.
                    if flag_val or check_all_links:
                        logger.info('%s:%s looking for %s',
                                    series, project['name'], url)
                        links_to_check.append(
                            (url, project['name'],
                             url_info.flag_name,
                             flag_val)
                        )

        if links_to_check:
            logger.info('checking %s links from %s...',
                        len(links_to_check), filename)
            pool = multiprocessing.pool.ThreadPool()
            results = pool.map(_check_url, links_to_check)

            for url, project_name, flag, flag_val, exists, status in results:
                if flag_val and not exists:
                    logger.error(
                        '%s set for %s but %s does not exist (%s)',
                        flag, project_name, url, status,
                    )
                    fail = True
                elif (not flag_val) and check_all_links and exists:
                    msg = '{} not set for {} but {} does exist'.format(
                        flag, project_name, url)
                    logger.warning(msg)
                    if strict:
                        raise RuntimeError(msg)

        if fail:
            raise ValueError('invalid input in %s' % filename)
        project_data[series] = data
    return project_data


_GOVERNANCE_URL = 'http://git.openstack.org/cgit/openstack/governance/plain/reference/projects.yaml'  # noqa
_GOVERNANCE_SIGS_URL = 'http://git.openstack.org/cgit/openstack/governance/plain/reference/sigs-repos.yaml'  # noqa
_IGNORED_REPOS = [
    'openstack/releases',
    'openstack-infra/releasestatus',
    'openstack/contributor-guide',
    'openstack/operations-guide',
]

# List of infra repos that publish to the normal location (/REPO/) and
# not to /infra/REPO.
_INFRA_REPOS_EXCEPTION = [
    'openstack-infra/pynotedb',
    'openstack-infra/subunit2sql',
    'openstack/diskimage-builder',
]


def _get_official_repos():
    """Return a tuple containing lists of all official repos.

    The first member is the list of regular project repos. The second
    member is the list of infra repos.

    """
    seen_repos = set()
    regular_repos = []
    infra_repos = []
    deliverables = []

    # Project team repositories are organized as
    #
    #   team:
    #     deliverables:
    #       name:
    #         repos:
    #           - name
    #
    raw = requests.get(_GOVERNANCE_URL)
    data = yaml.safe_load(raw.text)
    for t_name, team in data.items():
        for d_name, d_data in team.get('deliverables', {}).items():
            deliverables.append(d_name)
            if t_name == 'Infrastructure':
                add = infra_repos.append
            else:
                add = regular_repos.append
            for repo in d_data.get('repos', []):
                if repo in seen_repos:
                    # Sometimes the governance data ends up with
                    # duplicates, but we don't want duplicate rules to
                    # be generated.
                    continue
                seen_repos.add(repo)
                # Overwrite infra list for a few repositories
                if repo in _INFRA_REPOS_EXCEPTION:
                    regular_repos.append({'name': repo,
                                          'base': repo.rsplit('/')[-1]})
                elif repo not in _IGNORED_REPOS:
                    add({'name': repo, 'base': repo.rsplit('/')[-1]})

    # SIG repositories are organized as
    #
    #   name:
    #     - repo: name
    #
    raw = requests.get(_GOVERNANCE_SIGS_URL)
    data = yaml.safe_load(raw.text)
    for sig_name, sig_data in data.items():
        for repo in sig_data:
            name = repo['repo']
            base = name.rsplit('/')[-1]
            if name in seen_repos:
                continue
            if name in _IGNORED_REPOS:
                continue
            regular_repos.append({
                'name': name,
                'base': base,
            })
            seen_repos.add(name)
            # Treat sig repos as deliverables so they do not trigger
            # a warning for not appearing to be official.
            deliverables.append(base)

    return (regular_repos, infra_repos, deliverables)


def render_template(environment, project_data, regular_repos, infra_repos,
                    template_file, output_directory, extra={}):
    logger = logging.getLogger()
    logger.info("generating %s", template_file)

    # Determine the relative path to a few common directories so
    # we don't need to set them in the templates.
    topdir = os.path.relpath(
        '.', os.path.dirname(template_file),
    ).rstrip('/') + '/'
    scriptdir = os.path.join(topdir, 'common', 'js').rstrip('/') + '/'
    cssdir = os.path.join(topdir, 'common', 'css').rstrip('/') + '/'
    imagedir = os.path.join(topdir, 'common', 'images').rstrip('/') + '/'

    series_match = SERIES_PAT.match(template_file)
    if series_match:
        series = series_match.groups()[0]
        series_title = series.title()
        series_info = SERIES_INFO[series]
        if series == SERIES_IN_DEVELOPMENT:
            series = 'latest'
    else:
        series = None
        series_title = ''
        series_info = SeriesInfo('', '')
    logger.info('series = %s', series)

    try:
        template = environment.get_template(template_file)
    except Exception as e:
        logger.error("parsing template %s failed: %s" %
                     (template_file, e))
        raise

    try:
        output = template.render(
            PROJECT_DATA=project_data,
            TEMPLATE_FILE=template_file,
            REGULAR_REPOS=regular_repos,
            INFRA_REPOS=infra_repos,
            ALL_SERIES=ALL_SERIES,
            PAST_SERIES=PAST_SERIES,
            RELEASED_SERIES=RELEASED_SERIES,
            MAINTAINED_SERIES=MAINTAINED_SERIES,
            SERIES_IN_DEVELOPMENT=SERIES_IN_DEVELOPMENT,
            TOPDIR=topdir,
            SCRIPTDIR=scriptdir,
            CSSDIR=cssdir,
            IMAGEDIR=imagedir,
            SERIES=series,
            SERIES_TITLE=series_title,
            SERIES_INFO=series_info,
            **extra
        )
        if template_file.endswith('.html'):
            soup = BeautifulSoup(output, "lxml")
            output = soup.prettify()
    except Exception as e:
        logger.error("rendering template %s failed: %s" %
                     (template_file, e))
        raise

    try:
        target_directory = os.path.join(output_directory,
                                        os.path.dirname(template_file))
        target_file = os.path.join(output_directory, template_file)
        if not os.path.isdir(target_directory):
            logger.debug("creating target directory %s" %
                         target_directory)
            os.makedirs(target_directory)
        logger.debug("writing %s" % target_file)
        with open(os.path.join(target_file), 'wb') as fh:
            fh.write(output.encode('utf8'))
    except (IOError, OSError, UnicodeEncodeError) as e:
        logger.error("writing %s failed: %s" % (target_file, e))
        raise


def main():
    """Entry point for this script."""

    args = parse_command_line_arguments()
    logger = initialize_logging(args.debug, args.verbose)

    regular_repos, infra_repos, deliverables = _get_official_repos()
    project_data = load_project_data(
        source_directory=args.source_directory,
        check_all_links=args.check_all_links,
        skip_links=args.skip_links,
        series_to_load=args.series,
        governed_deliverables=deliverables,
        strict=args.strict,
        projects_to_check=args.project,
    )

    # Set up jinja to discover the templates.
    try:
        logger.info('looking for templates in %s', args.source_directory)
        loader = jinja2.FileSystemLoader(args.source_directory)
        environment = jinja2.Environment(loader=loader)
    except Exception as e:
        logger.error("initialising template environment failed: %s" % e)
        raise

    if args.skip_render:
        return 0

    # Render the templates.
    output_pages = []
    page_list_template = None
    for template_file in environment.list_templates():
        if (template_file.startswith('static/') or
                template_file.startswith('templates/')):
            logger.info('ignoring %s', template_file)
            continue
        if template_file.endswith('www-index.html'):
            # Process this one at the end, so we have the full list of
            # other output files.
            page_list_template = template_file
            continue
        render_template(
            environment,
            project_data,
            regular_repos,
            infra_repos,
            template_file,
            args.output_directory,
        )
        output_pages.append(template_file)

    if page_list_template is not None:
        output_pages.sort()
        render_template(
            environment,
            project_data,
            regular_repos,
            infra_repos,
            page_list_template,
            args.output_directory,
            extra={
                'file_list': output_pages,
            },
        )

    return 0


if __name__ == '__main__':
    sys.exit(main())
