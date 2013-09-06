#!/usr/bin/env python
import sys
from os import path
import glob
from xml.dom import minidom
from xml.sax.saxutils import escape

#Swift configuration example files live in
# swift/etc/*.conf-sample
# and contain sections enclosed in [], with
# options one per line containing =
# and generally only having a single entry
# after the equals (the default value)


def parse_line(line):
    """
    takes a line from a swift sample configuration file and attempts
    to separate the lines with actual configuration option and default
    value from the rest. Returns None if the line doesn't appear to
    contain a valid configuration option = default value pair, and
    a pair of the config and its default if it does.
    """
    if '=' not in line:
        return None
    temp_line = line.strip('#').strip()
    config, default = temp_line.split('=', 1)
    config = config.strip()
    if ' ' in config and config[0:3] != 'set':
        if len(default.split()) > 1 or config[0].isupper():
            return None
    if len(config) < 2 or '.' in config or '<' in config or '>' in config:
        return None
    return config, default.strip()


def get_existing_options(optfiles):
    """
    parses an existing XML table to compile a list of existing options
    """
    options = {}
    for optfile in optfiles:
        xmldoc = minidom.parse(optfile)
        tbody = xmldoc.getElementsByTagName('tbody')[0]
        trlist = tbody.getElementsByTagName('tr')
        for tr in trlist:
            try:
                optentry = tr.childNodes[1].childNodes[0]
                option, default = optentry.nodeValue.split('=', 1)
                helptext = tr.childNodes[2].childNodes[0].nodeValue
            except IndexError:
                continue
            if option not in options or 'No help text' in options[option]:
                #options[option.split('=',1)[0]] = helptext
                options[option] = helptext
    return options


def extract_descriptions_from_devref(repo, options):
    """
    loop through the devref RST files, looking for lines formatted
    such that they might contain a description of a particular
    option
    """
    option_descs = {}
    rsts = glob.glob(repo + '/doc/source/*.rst')
    for rst in rsts:
        rst_file = open(rst, 'r')
        in_option_block = False
        prev_option = None
        for line in rst_file:
            if 'Option    ' in line:
                in_option_block = True
            if in_option_block:
                if '========' in line:
                    in_option_block = False
                    continue
                if line[0] == ' ' and prev_option is not None:
                    option_descs[prev_option] = (option_descs[prev_option]
                                                 + ' ' + line.strip())
                for option in options:
                    line_parts = line.strip().split(None, 2)
                    if ('   ' in line and len(line_parts) == 3
                        and option == line_parts[0]
                        and line_parts[1] != '=' and option != 'use'
                        and (option not in option_descs or
                             len(option_descs[option]) < len(line_parts[2]))):
                          option_descs[option] = line_parts[2]
                          prev_option = option
    return option_descs


def new_section_file(sample, current_section):
     section_filename = ('swift-' +
           path.basename(sample).split('.conf')[0]
           + '-'
           + current_section.replace('[', '').replace(']', '').replace(':', '-')
           + '.xml')
     section_file = open(section_filename, 'w')
     section_file.write('<?xml version="1.0" encoding="UTF-8"?>\n\
     <!-- The tool that generated this table lives in the\n\
          tools directory of this repository. As it was a one-time\n\
          generation, you can edit this file. -->\n\
     <para xmlns="http://docbook.org/ns/docbook" version="5.0">\n\
     <table rules="all">\n\
     <caption>Description of configuration options for <literal>'
     + current_section + '</literal> in <literal>' + path.basename(sample) +
     '</literal></caption>\n\
     <col width="50%"/>\n\
     <col width="50%"/>\n\
     <thead>\n\
        <tr>\n\
             <td>Configuration option=Default value</td>\n\
             <td>Description</td>\n\
        </tr>\n\
     </thead>\n\
     <tbody>')
     return section_file


def create_new_tables(repo, verbose):
    """
    writes a set of docbook-formatted tables, one per section in swift
    configuration files. Uses existing tables and swift devref as a source
    of truth in that order to determine helptext for options found in
    sample config files
    """
    existing_tables = glob.glob('../../doc/src/docbkx/common/tables/swift*xml')
    options = {}
    #use the existing tables to get a list of option names
    options = get_existing_options(existing_tables)
    option_descs = extract_descriptions_from_devref(repo, options)
    conf_samples = glob.glob(repo + '/etc/*conf-sample')
    for sample in conf_samples:
        current_section = None
        section_file = None
        sample_file = open(sample, 'r')
        for line in sample_file:
            if '[' in line and ']\n' in line and '=' not in line:
                """
                it's a header line in the conf file, open a new table file
                for this section and close any existing one
                """
                if current_section != line.strip('#').strip():
                    if section_file is not None:
                        section_file.write('\n             </tbody>\n\
                        </table>\n\
                        </para>')
                        section_file.close()
                    current_section = line.strip('#').strip()
                    section_file = new_section_file(sample, current_section)
            elif section_file is not None:
                """
                it's a config option line in the conf file, find out the
                help text and write to the table file.
                """
                parsed_line = parse_line(line)
                if parsed_line is not None:
                    if (parsed_line[0] in options.keys()
                       and 'No help text' not in options[parsed_line[0]]):
                        # use the help text from existing tables
                        option_desc = options[parsed_line[0]].replace(u'\xa0', u' ')
                    elif parsed_line[0] in option_descs:
                        # use the help text from the devref
                        option_desc = option_descs[parsed_line[0]].replace(u'\xa0', u' ')
                    else:
                        option_desc = 'No help text available for this option'
                        if verbose > 0:
                            print parsed_line[0] + "has no help text"
                    section_file.write('\n                    <tr>\n\
                        <td>' + parsed_line[0] + '=' +
                                       escape(str(parsed_line[1])) +
                                       '</td><td>' + option_desc + '</td>\n' +
                                       '              </tr>')
        if section_file is not None:
            section_file.write('\n             </tbody>\n\
                        </table>\n\
                        </para>')
            section_file.close()


def main(repo, verbose=0):
    """
    writes a set of docbook-formatted files, based on configuration sections
    in swift sample configuration files
    """

    create_new_tables(repo, verbose)

if  __name__ == "__main__":
    main(sys.argv[1])
