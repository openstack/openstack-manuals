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
import glob
import logging
import os
import sys

from bs4 import BeautifulSoup
import jinja2
import jsonschema
import requests
import yaml


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
    return parser.parse_args()


def _check_url(url):
    "Return True if the URL exists, False otherwise."
    try:
        resp = requests.get(url)
    except requests.exceptions.TooManyRedirects:
        return False, 301
    return (resp.status_code // 100) == 2, resp.status_code


# NOTE(dhellmann): List of tuple of flag name and URL template. None
# for the flag name means always apply the URL, otherwise look for a
# True value associated with the flag in the project data.
_URLS = [
    (None,
     'https://docs.openstack.org/{name}/{series}/'),
    ('has_install_guide',
     'https://docs.openstack.org/{name}/{series}/install/'),
    ('has_admin_guide',
     'https://docs.openstack.org/{name}/{series}/admin/'),
    ('has_config_ref',
     'https://docs.openstack.org/{name}/{series}/configuration/'),
    ('has_in_tree_api_docs',
     'https://docs.openstack.org/{name}/{series}/api/'),
    ('has_user_guide',
     'https://docs.openstack.org/{name}/{series}/user/'),
    ('has_api_ref',
     'https://developer.openstack.org/api-ref/{service_type}/'),
    ('has_api_guide',
     'https://developer.openstack.org/api-guide/{service_type}/'),
]

_SERVICE_TYPES_URL = 'http://git.openstack.org/cgit/openstack/service-types-authority/plain/service-types.yaml'  # noqa


def _get_service_types():
    "Return a map between repo base name and service type"
    raw = requests.get(_SERVICE_TYPES_URL)  # noqa
    data = yaml.safe_load(raw.text)
    service_types = {
        d['project'].rsplit('/')[-1]: d['service_type']
        for d in data['services']
    }
    return service_types


def load_project_data(source_directory, check_all_links=False):
    "Return a dict with project data grouped by series."
    logger = logging.getLogger()
    project_data = {}
    fail = False
    service_types = _get_service_types()
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
        logger.info('loading %s project data from %s', series, filename)
        with open(filename, 'r') as f:
            data = yaml.safe_load(f.read())
        for error in validator.iter_errors(data):
            logger.error(str(error))
            fail = True
        for project in data:
            # If the project has a service-type set, ensure it matches
            # the value in the service-type-authority data.base.
            st = project.get('service_type')
            if st is not None:
                if project['name'] not in service_types:
                    logger.error(
                        'did not find %s in %s',
                        project['name'], _SERVICE_TYPES_URL,
                    )
                    fail = True
                elif project['service_type'] != service_types[project['name']]:
                    logger.error(
                        'expected service_type %r for %s but got %r',
                        service_types[project['name']], project['name'],
                        project['service_type'],
                    )
                    fail = True
            # client projects must have a description
            project_type = project.get('type')
            if project_type == 'client' and not project.get('description'):
                logger.error(
                    'client project %s has no description',
                    project['name'],
                )
                fail = True
            # If the project claims to have a separately published guide
            # of some sort, look for it before allowing the flag to stand.
            for flag, url_template in _URLS:
                if flag is None:
                    flag_val = True
                else:
                    flag_val = project.get(flag, False)
                try:
                    url = url_template.format(series=series, **project)
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
                    exists, status = _check_url(url)
                if flag_val and not exists:
                    logger.error(
                        '%s set for %s but %s does not exist (%s)',
                        flag or 'home page check', project['name'],
                        url, status,
                    )
                    fail = True
                elif (not flag_val) and check_all_links and exists:
                    logger.warning(
                        '%s not set for %s but %s does exist',
                        flag, project['name'], url,
                    )
        if fail:
            raise ValueError('invalid input in %s' % filename)
        project_data[series] = data
    return project_data


_GOVERNANCE_URL = 'http://git.openstack.org/cgit/openstack/governance/plain/reference/projects.yaml'  # noqa


def _get_official_repos():
    """Return a tuple containing lists of all official repos.

    The first member is the list of regular project repos. The second
    member is the list of infra repos.

    """
    raw = requests.get(_GOVERNANCE_URL)
    data = yaml.safe_load(raw.text)
    regular_repos = []
    infra_repos = []
    for t_name, team in data.items():
        for d_name, d_data in team.get('deliverables', {}).items():
            if t_name == 'Infrastructure':
                add = infra_repos.append
            else:
                add = regular_repos.append
            for repo in d_data.get('repos', []):
                add({'name': repo, 'base': repo.rsplit('/')[-1]})
    return (regular_repos, infra_repos)


def main():
    """Entry point for this script."""

    args = parse_command_line_arguments()
    logger = initialize_logging(args.debug, args.verbose)

    project_data = load_project_data(args.source_directory,
                                     args.check_all_links)
    regular_repos, infra_repos = _get_official_repos()

    # Set up jinja to discover the templates.
    try:
        loader = jinja2.FileSystemLoader(args.source_directory)
        environment = jinja2.Environment(loader=loader)
    except Exception as e:
        logger.error("initialising template environment failed: %s" % e)
        return 1

    # Render the templates.
    for templateFile in environment.list_templates():
        if not (templateFile.endswith('.html')
                or templateFile.endswith('.htaccess')):
            logger.info('ignoring %s', templateFile)
            continue

        logger.info("generating %s", templateFile)

        try:
            template = environment.get_template(templateFile)
        except Exception as e:
            logger.error("parsing template %s failed: %s" %
                         (templateFile, e))
            raise

        try:
            output = template.render(
                PROJECT_DATA=project_data,
                TEMPLATE_FILE=templateFile,
                REGULAR_REPOS=regular_repos,
                INFRA_REPOS=infra_repos,
            )
            if templateFile.endswith('.html'):
                soup = BeautifulSoup(output, "lxml")
                output = soup.prettify()
        except Exception as e:
            logger.error("rendering template %s failed: %s" %
                         (templateFile, e))
            raise

        try:
            target_directory = os.path.join(args.output_directory,
                                            os.path.dirname(templateFile))
            target_file = os.path.join(args.output_directory, templateFile)
            if not os.path.isdir(target_directory):
                logger.debug("creating target directory %s" %
                             target_directory)
                os.makedirs(target_directory)
            logger.debug("writing %s" % target_file)
            with open(os.path.join(target_file), 'wb') as fh:
                fh.write(output.encode('utf8'))
        except (IOError, OSError, UnicodeEncodeError) as e:
            logger.error("writing %s failed: %s" % (target_file, e))
            continue

    return 0


if __name__ == '__main__':
    sys.exit(main())
