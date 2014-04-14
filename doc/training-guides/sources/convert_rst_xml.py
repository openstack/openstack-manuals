# Copyright 2013 Yahoo! Inc. All Rights Reserved
# Copyright 2013 OpenStack Foundation
# Copyright 2010 United States Government as represented by the
# Administrator of the National Aeronautics and Space Administration.
# All Rights Reserved.
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.


'''
The code must executed within ./openstack-manuals/doc/training-manuals/sources/.
The code will automagically create the 7 'core' openstack repositories and convert the
rst docs to xml.
'''


import os
import re
import sys

def create_repo(directory):
    #clone remote to local repo root, ignore error if exist
    for x in directory:
        os.system("git clone https://git.openstack.org/openstack/" + x + ".git")


def pull_repo_updates(directory):
    #pull remote repo updates
    for x in directory:
        os.chdir("./" + x)
        os.system("git pull origin master")
        os.chdir("../")


def patternmatch(directory, docs_location, rstfile):
    #simple pattern matching source rst to output docbook5.0 xml
    good_file = {"addmethod.openstackapi", "architecture",
                 "development.environment", "drivers", "threading", "unit_tests"}
    try:
        #open the file to convert
        infile = open(directory + docs_location + rstfile)
    except IOError:
        #if file is a directory then recurse
        print("patternmatch:in IOError:directory:" + directory + ", docs_location: " + docs_location + ", rstfile: " + rstfile)
        os.mkdir(os.path.expanduser("./openstack-manuals/doc/training-guides/sources/" + directory + rstfile))
        walkdirectories(directory + docs_location, rstfile +"/")
        #docs_location and rstfile are both directories in this case
        return
    outfilenamepart = infile.name.split(".rst")
    outfilename = outfilenamepart[0].split("/")
    matchslash = re.search(r'(.*/.*/.*/.*)', directory)
    if matchslash:
        #if recursion match is good
        print("patternmatch:matchslash:directory:" + directory + ", docs_location: " + docs_location + ", rstfile: " + rstfile)
        try:
            if outfilenamepart[-1]:
                #TODO if not rst file, then copy image files
                return
        except:
            pass
        directory = directory.split("/")
        good_file_found = "false"
        for filename in good_file:
            #check for good file name, else skip to next file
            if filename == outfilename[-1]:
                good_file_found = "true"
                continue
        if good_file_found == "false":
            #jump out of called routine
            return
        outfile = open("./openstack-manuals/doc/training-guides/sources/" +
                       directory[0] + "/" + docs_location + outfilename[-1] + ".xml", "w+")
        print(directory[0] + "/" + docs_location + outfilename[-1] + ".xml")
    else:
        print("patternmatch:not matchslash:directory:" + directory + ", docs_location: " + docs_location + ", rstfile: " + rstfile)
        try:
            if outfilenamepart[-1]:
                #TODO if not rst file, then copy image files
                #createfile(directory, docs_location, outfilename)
                return
        except:
            pass
        good_file_found = "false"
        for filename in good_file:
            #check for good file name, else skip to next file
            if filename == outfilename[-1]:
                good_file_found = "true"
                continue
        if good_file_found == "false":
            #jump out of called routine
            return
        outfile = open("./openstack-manuals/doc/training-guides/sources/" +
                       directory + outfilename[-1] + ".xml", "w+")
        print(directory + outfilename[-1] + ".xml")
    #header of new xml file
    outfile.write("<?xml version=\"1.0\" encoding=\"utf-8\"?>\n")
    outfile.write("  <section xmlns=\"http://docbook.org/ns/docbook\"\n")
    outfile.write("  xmlns:xi=\"http://www.w3.org/2001/XInclude\"\n")
    outfile.write("  xmlns:xlink=\"http://www.w3.org/1999/xlink\"\n")
    outfile.write("  version=\"5.0\"\n")
    #xml_section_name = outfilename.replace(" ", "-")
    outfile.write("  xml:id=\"" + outfilename[-1] + "\">\n")
    outfile.write("<title>" + outfilename[-1].title() + "</title>\n")
    #start header
    xml_section_name = "header"
    outfile.write("<section xml:id=\"" + xml_section_name.strip() + "\">\n")
    outfile.write("<title>" + xml_section_name.title() + "</title>\n")
    outfile.write("<para>\n")
    #always read two lines at a time, once pattern match on multiple char, previous line is section id and title
    prevline = "empty"
    startitemizedlist = 0
    for line in infile:
        #match single line ahead for section titles
        match1 = re.search(r'(.*)(=======)(.*)', line)
        match2 = re.search(r'(.*)(-------)(.*)', line)
        match3 = re.search(r'(.*)(~~~~~~~)(.*)', line)
        match4 = re.search(r'(\s*)(\*\s)(.*)', prevline)
        match5 = re.search(r'(\s*)(\*\s)(.*)', line)
        #ignoring orderedlists for now
        #match6 = re.search(r'(\s*)([0-9]\.\s)(.*)', prevline)
        #match7 = re.search(r'(\s*)([0-9]\.\s)(.*)', line)
        if match1 or match2 or match3:
                #close previous para and section
                outfile.write("</para>\n")
                outfile.write("</section>\n")
                #start new section and para
                xml_section_name = prevline.replace(" ", "-")
                xml_section_name = xml_section_name.replace("\'", "-")
                xml_section_name = xml_section_name.replace("`", "-")
                xml_section_name = xml_section_name.replace("\"", "-")
                xml_section_name = xml_section_name.replace(":", "-")
                xml_section_name = xml_section_name.replace(",", "-")
                xml_section_name = xml_section_name.replace("(", "-")
                xml_section_name = xml_section_name.replace(")", "-")
                outfile.write("<section xml:id=\"" + xml_section_name.strip() + "\">\n")
                outfile.write("<title>" + xml_section_name.strip().title() + "</title>\n")
                outfile.write("<para>\n")
        elif not match4 and match5:
            #start itemizedlist
            startitemizedlist = 1
            outfile.write("<itemizedlist>\n")
            listitem = match5.group(3).replace("<","[")
            listitem = listitem.replace(">","]")
            listitem = listitem.replace("&","-")
            outfile.write("<listitem><para>" + listitem + "</para></listitem>\n")
        elif match4 and match5:
            #continue itemizedlist
            listitem = match5.group(3).replace("<","[")
            listitem = listitem.replace(">","]")
            listitem = listitem.replace("&","-")
            outfile.write("<listitem><para>" + listitem + "</para></listitem>\n")
        elif match4 and not match5:
            #close itemizedlist
            startitemizedlist = 0
            outfile.write("</itemizedlist>\n")
        elif prevline != "empty" and not prevline.isspace():
            #no match, so inside section and para
            prevline = prevline.replace("<","[")
            prevline = prevline.replace(">","]")
            prevline = prevline.replace("&","-")
            outfile.write(prevline)
        #save previous line for pattern matching
        prevline = line
    #catch end of file, missing close itemized list
    if startitemizedlist == 1:
        outfile.write("</itemizedlist>\n")
    #close last para and section
    outfile.write("</para>\n")
    outfile.write("</section>\n")
    outfile.write("</section>")


def walkdirectories(projectdirectory, sourcedirectory):
    #print("walkdirectories: " + projectdirectory + sourcedirectory)
    print("walkdirectories:current directory is ")
    os.system("pwd")
    for rstfile in os.listdir(projectdirectory + sourcedirectory):
        #walk files in the directory
        if rstfile.startswith('.'):
        #ignore hidden files
            continue
        patternmatch(projectdirectory, sourcedirectory, rstfile)


def convert_rst_docbook5(repository_hash):
    for item in repository_hash:
        print("convert_rst_docbook5:start convert rst: " + item + repository_hash[item])
        os.system("rm -R ./openstack-manuals/doc/training-guides/sources/" + item)
        try:
            #use try for when the remove directory fails
            os.mkdir("./openstack-manuals/doc/training-guides/sources/" + item)
        except OSError:
            pass
        walkdirectories(item, repository_hash[item])
        #os.chdir("../")
        print("convert_rst_docbook5:completed convert rst: " + item + repository_hash[item])


repository_hash = {'cinder/':"/doc/source/devref/"}
'''
                'nova/':"/doc/source/devref/",
                'glance/':"/doc/source/",
                'neutron/':"/doc/source/devref/",
                'swift/':"/doc/source/",
                'keystone/':"doc/source/",
                'horizon/':"/doc/source/"}'''
os.chdir("../../../../")#root of repository directories in relation to ./training-guides/sources
create_repo(repository_hash)
pull_repo_updates(repository_hash)
convert_rst_docbook5(repository_hash)
