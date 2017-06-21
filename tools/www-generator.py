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
import logging
import os
import sys

from bs4 import BeautifulSoup
import jinja2
import jsonschema
import yaml


def initialize_logging(debug, verbose):
    """Initialize the Logger."""

    logger = logging.getLogger(name='logger')
    formatter = logging.Formatter('%(asctime)s %(levelname)-8s %(message)s')
    handler = logging.StreamHandler()
    handler.setFormatter(formatter)
    logger.addHandler(handler)

    if verbose:
        logger.setLevel(logging.INFO)

    if debug:
        logger.setLevel(logging.DEBUG)

    return logging.getLogger('logger')


def parse_command_line_arguments():
    """Parse the command line arguments."""
    parser = argparse.ArgumentParser()
    parser.add_argument("--debug", help="Print debugging messages.",
                        action="store_true", default=False)
    parser.add_argument("--verbose", help="Be more verbose.",
                        action="store_true", default=False)
    parser.add_argument("--source-directory", type=str,
                        default='www', help='')
    parser.add_argument("--output-directory", type=str,
                        default='publish-docs/www', help='')
    return parser.parse_args()


def main():
    """Entry point for this script."""

    args = parse_command_line_arguments()
    logger = initialize_logging(args.debug, args.verbose)

    # Load project data, if it is present.
    project_data = {}
    project_data_filename = os.path.join(
        args.source_directory,
        'projects.yaml'
    )
    logger.info('looking for project data in %s', project_data_filename)
    if os.path.exists(project_data_filename):
        with open(project_data_filename, 'r') as f:
            project_data = yaml.safe_load(f.read())
        project_schema_filename = os.path.join(
            args.source_directory,
            'schema.yaml',
        )
        with open(project_schema_filename, 'r') as f:
            project_schema = yaml.safe_load(f.read())
        validator = jsonschema.Draft4Validator(project_schema)
        fail = False
        for error in validator.iter_errors(project_data):
            logger.error(str(error))
            fail = True
        if fail:
            raise ValueError('invalid input in %s' % project_data_filename)
    try:
        loader = jinja2.FileSystemLoader(args.source_directory)
        environment = jinja2.Environment(loader=loader)
    except Exception as e:
        logger.error("initialising template environment failed: %s" % e)
        return 1

    for templateFile in environment.list_templates():
        if not (templateFile.endswith('.html')
                or templateFile.endswith('.htaccess')):
            logger.info('ignoring %s', templateFile)
            continue

        logger.info("generating %s" % templateFile)

        try:
            template = environment.get_template(templateFile)
        except Exception as e:
            logger.error("parsing template %s failed: %s" %
                         (templateFile, e))
            raise

        try:
            output = template.render(projects=project_data)
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
