#
# A collection of shared functions for managing help flag mapping files.
#

import os
import string
import sys
import pkgutil
import glob

from collections import defaultdict
from xml.sax.saxutils import escape
from oslo.config import cfg

# gettext internationalisation function requisite:
import __builtin__
__builtin__.__dict__['_'] = lambda x: x


def git_check(repo_path):
    from git import Repo
    """
    Check a passed directory to verify it is a valid git repository.
    """
    try:
        repo = Repo(repo_path)
        assert repo.bare is False
        package_name = os.path.basename(repo.remotes.origin.url).rstrip('.git')
    except:
        print "\nThere is a problem verifying that the directory passed in"
        print "is a valid git repository.  Please try again.\n"
        sys.exit(1)
    return package_name


def populate_groups(filepath):
    """
    Takes a file formatted with lines of config option and group
    separated by a space and constructs a dictionary indexed by
    group, which is returned..
    """
    groups = defaultdict(list)
    groups_file = open(os.path.expanduser(filepath), 'r')
    for line in groups_file:
        try:
            option, group = line.split(None, 1)
        except ValueError:
            print "Couldn't read groups file line:%s" % line
            print "Check for formatting errors - did you add the group?"
            sys.exit(1)
        groups[group.strip()].append(option)
    return groups


def extract_flags(repo_location, module_name, verbose=0, names_only=True):
    """
    Loops through the repository, importing module by module to
    populate the configuration object (cfg.CONF) created from Oslo.
    """
    usable_dirs = []
    module_location = os.path.dirname(repo_location + '/' + module_name)
    for root, dirs, files in os.walk(module_location + '/' + module_name):
        for name in dirs:
            abs_path = os.path.join(root.split(module_location)[1][1:], name)
            if ('/tests' not in abs_path and '/locale' not in abs_path and
                '/cmd' not in abs_path and '/db/migration' not in abs_path and
                '/transfer' not in abs_path):
                usable_dirs.append(os.path.join(root.split(module_location)[1][1:], name))

    for directory in usable_dirs:
        for python_file in glob.glob(module_location + '/' + directory + "/*.py"):
            if '__init__' not in python_file:
                usable_dirs.append(os.path.splitext(python_file)[0][len(module_location) + 1:])

        package_name = directory.replace('/', '.')
        try:
            __import__(package_name)
            if verbose >= 1:
                print "imported %s" % package_name

        except ImportError as e:
            """
            work around modules that don't like being imported in this way
            FIXME This could probably be better, but does not affect the
            configuration options found at this stage
            """
            if verbose >= 2:
                print str(e)
                print "Failed to import: %s (%s)" % (package_name, e)

            continue

    flags = cfg.CONF._opts.items()

    #extract group information
    for group in cfg.CONF._groups.keys():
        flags = flags + cfg.CONF._groups[group]._opts.items()
    flags.sort()

    return flags


def extract_flags_test(repo_loc, module, verbose=0):
    """
    TEST TEST TEST TEST TEST TEST
    TEST TEST TEST TEST TEST TEST
    Loops through the repository, importing module by module to
    populate the configuration object (cfg.CONF) created from Oslo.
    TEST TEST TEST TEST TEST TEST
    TEST TEST TEST TEST TEST TEST
    """
    flag_data = {}
    flag_files = []
    usable_dirs = []
    module_location = os.path.dirname(repo_loc + '/' + module)
    for root, dirs, files in os.walk(module_location + '/' + module):
        for name in dirs:
            abs_path = os.path.join(root.split(module_location)[1][1:], name)
            if ('/tests' not in abs_path and '/locale' not in abs_path and
                '/cmd' not in abs_path and '/db/migration' not in abs_path):
                usable_dirs.append(os.path.join(root.split(module_location)[1][1:], name))

    for directory in usable_dirs:
        for python_file in glob.glob(module_location + '/' + directory + "/*.py"):
            if '__init__' not in python_file:
                usable_dirs.append(os.path.splitext(python_file)[0][len(module_location) + 1:])

        package_name = directory.replace('/', '.')
        try:
            __import__(package_name)
            if verbose >= 1:
                print "imported %s" % package_name
            flag_data[str(package_name)] = sorted(cfg.CONF._opts.items())

        except ImportError as e:
            """
            work around modules that don't like being imported in this way
            FIXME This could probably be better, but does not affect the
            configuration options found at this stage
            """
            if verbose >= 2:
                print str(e)
                print "Failed to import: %s (%s)" % (package_name, e)

            continue

    return flag_data


def write_test(file, repo_dir, pkg_name):
    """
    """
    file1 = file + ".test"
    flags = extract_flags_test(repo_dir, pkg_name)
    with open(file1, 'a+') as f:
        f.write("\n")
        for filename, flag_info in flags.iteritems():
            f.write("\n -- start file name area --\n")
            f.write(filename)
            f.write("\n -- end file name area --\n")
            print "\n -- start file name area --\n"
            print filename
            print "\n -- end file name area --\n"
            print len(flag_info)
            for name, value in flag_info:
                opt = value['opt']
                #print type(opt)
                #print opt
                #print name
                #print value
                f.write(name)
                f.write("\n")


def write_header(filepath, verbose=0):
    """
    Write header to output flag file.
    """
    pass


def write_buffer(file, flags, verbose=0):
    """
    Write flag data to file.  (The header is written with the write_header function.)
    """
    pass
    #with open(os.path.expanduser(filepath), 'wb') as f:


def write_flags(filepath, flags, name_only=True, verbose=0):
    """
    write out the list of flags in the cfg.CONF object to filepath
    if name_only is True - write only a list of names, one per line,
    otherwise use MediaWiki syntax to write out the full table with
    help text and default values.
    """
    with open(os.path.expanduser(filepath), 'wb') as f:
        if not name_only:
            f.write("{|\n")  # start table
            # print headers
            f.write("!")
            f.write("!!".join(["name", "default", "description"]))
            f.write("\n|-\n")

        for name, value in flags:
            opt = value['opt']
            if not opt.help:
                opt.help = "No help text available for this option"
            if not name_only:
                f.write("|")
                f.write("||".join([string.strip(name),
                                   string.strip(str(opt.default)),
                                   string.strip(opt.help.replace("\n", " "))]))
                f.write("\n|-\n")
            else:
                f.write(name + "\n")

        if not name_only:
            f.write("|}\n")  # end table


def write_docbook(directory, flags, groups, package_name, verbose=0):
    """
    Prints a docbook-formatted table for every group of options.
    """
    count = 0
    for group in groups.items():
        groups_file = open(package_name + '-' + group[0] + '.xml', 'w')
        groups_file.write('<?xml version="1.0" encoding="UTF-8"?>\n\
        <!-- Warning: Do not edit this file. It is automatically\n\
             generated and your changes will be overwritten.\n\
             The tool to do so lives in the tools directory of this\n\
             repository -->\n\
        <para xmlns="http://docbook.org/ns/docbook" version="5.0">\n\
        <table rules="all">\n\
          <caption>Description of configuration options for ' + group[0] +
                          '</caption>\n\
           <col width="50%"/>\n\
           <col width="50%"/>\n\
           <thead>\n\
              <tr>\n\
                  <td>Configuration option=Default value</td>\n\
                  <td>Description</td>\n\
              </tr>\n\
          </thead>\n\
          <tbody>')
        for flag_name in group[1]:
            for flag in flags:
                if flag[0] == flag_name:
                    count = count + 1
                    opt = flag[1]["opt"]
                    if not opt.help:
                        opt.help = "No help text available for this option"
                    if type(opt).__name__ == "ListOpt" and opt.default is not None:
                        opt.default = ",".join(opt.default)
                    groups_file.write('\n              <tr>\n\
                       <td>' + flag_name + '=' + str(opt.default) + '</td>\n\
                       <td>(' + type(opt).__name__ + ') '
                        + escape(opt.help) + '</td>\n\
              </tr>')
        groups_file.write('\n       </tbody>\n\
        </table>\n\
        </para>')
        groups_file.close()


def create(flag_file, repo_path):
    """
        Create new flag mappings file, containing help information for
        the project whose repo location has been passed in at the command line.
    """

    # flag_file testing.
    #try:
        # Test for successful creation of flag_file.
    #except:
        # If the test(s) fail, exit noting the problem(s).

    # repo_path git repo validity testing.
    #try:
        # Test to be sure the repo_path passed in is a valid directory
        # and that directory is a valid existing git repo.
    #except:
        # If the test(s) fail, exit noting the problem(s).

    # get as much help as possible, searching recursively through the
    # entire repo source directory tree.
    #help_data = get_help(repo_path)

    # Write this information to the file.
    #write_file(flag_file, help_data)


def update(filepath, flags, name_only=True, verbose=0):
    """
        Update flag mappings file, adding or removing entries as needed.
        This will update the file content, essentially overriding the data.
        The primary difference between create and update is that create will
        make a new file, and update will just work with the data that is
        data that is already there.
    """
    original_flags = []
    updated_flags = []
    write_flags(filepath + '.new', flags, name_only=True, verbose=0)
    original_flag_file = open(filepath)
    updated_flag_file = open(filepath + '.new', 'r')
    for line in original_flag_file:
        original_flags.append(line.split()[0])
    for line in updated_flag_file:
        updated_flags.append(line.rstrip())
    updated_flag_file.close()

    removed_flags = set(original_flags) - set(updated_flags)
    added_flags = set(updated_flags) - set(original_flags)

    print "\nRemoved Flags\n"
    for line in sorted(removed_flags):
        print line

    print "\nAdded Flags\n"
    for line in sorted(added_flags):
        print line

    updated_flag_file = open(filepath + '.new', 'wb')
    original_flag_file.seek(0)
    for line in original_flag_file:
        flag_name = line.split()[0]
        if flag_name not in removed_flags:
            for added_flag in added_flags:
                if flag_name > added_flag:
                    updated_flag_file.write(added_flag + ' Unknown\n')
                    added_flags.remove(added_flag)
                    break
            updated_flag_file.write(line)


def verify(flag_file):
    """
        Verify flag file contents.  No actions are taken.
    """
    pass


def usage():
        print "\nUsage: %s docbook <groups file> <source loc>" % sys.argv[0]
        print "\nGenerate a list of all flags for package in source loc and"\
              "\nwrites them in a docbook table format, grouped by the groups"\
              "\nin the groups file, one file per group.\n"
        print "\n       %s names <names file> <source loc>" % sys.argv[0]
        print "\nGenerate a list of all flags names for the package in"\
              "\nsource loc and writes them to names file, one per line \n"


def parse_me_args():
    import argparse
    parser = argparse.ArgumentParser(
        description='Manage flag files, to aid in updatingdocumentation.',
        epilog='Example: %(prog)s -a create -in ./nova.flagfile -fmt docbook\
 -p /nova',
        usage='%(prog)s [options]')
    parser.add_argument('-a', '--action',
                        choices=['create', 'update', 'verify'],
                        dest='action',
                        help='action (create, update, verify) [REQUIRED]',
                        required=True,
                        type=str,)
    # trying str data type... instead of file.
    parser.add_argument('-i', '-in', '--input',
                        dest='file',
                        help='flag file being worked with [REQUIRED]',
                        required=True,
                        type=str,)
    parser.add_argument('-f', '-fmt', '--format', '-o', '-out',
                        dest='format',
                        help='file output format (options: docbook, names)',
                        required=False,
                        type=str,)
    # ..tried having 'dir' here for the type, but the git.Repo function
    # requires a string is passed to it.. a directory won't work.
    parser.add_argument('-p', '--path',
                        dest='repo',
                        help='path to valid git repository [REQUIRED]',
                        required=True,
                        type=str,)
    parser.add_argument('-v', '--verbose',
                        action='count',
                        default=0,
                        dest='verbose',
                        required=False,)
    parser.add_argument('-no', '--name_only',
                        action='store_true',
                        dest='name',
                        help='whether output should contain names only',
                        required=False,)
    parser.add_argument('-test',
                        action='store_true',
                        dest='test',
                        help=argparse.SUPPRESS,
                        required=False,)
    args = vars(parser.parse_args())
    return args
