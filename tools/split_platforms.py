#!/usr/bin/env python3
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
import os


def do_one(base, out_dir, filename, tag):
    outname = filename[:-4] + '-' + tag + '.rst'
    print(outname, tag)

    inside_only = None
    prefix_len = None
    output = []
    num_only_blocks = 0

    with open(filename, 'r', encoding='utf-8') as inf:
        for line in inf:
            if '.. only::' in line:
                print(line.rstrip())
                inside_only = line
                num_only_blocks += 1
                prefix_len = None
                continue
            elif '.. endonly' in line:
                inside_only = None
                prefix_len = None
                continue
            elif inside_only:
                if line.lstrip() == line and line.strip():
                    # The line has content and is flush left, so the
                    # existing inside block was not closed with the
                    # comment.
                    inside_only = None
                    prefix_len = None
                    print('copying %r' % line)
                    output.append(line)
                elif tag in inside_only:
                    if not line.strip():
                        # blank line, include it but do not use it to find
                        # the prefix len
                        output.append('\n')
                        continue
                    if prefix_len is None:
                        # Determine how much this block is indented.
                        prefix_len = len(line) - len(line.lstrip())
                        print('prefix length:', prefix_len)
                    output.append(line[prefix_len:])
                    print('ONLY:', repr(line[prefix_len:]))
                else:
                    print('IGNORE:', repr(line))
            else:
                print('copying %r' % line)
                output.append(line)
        if inside_only:
            raise RuntimeError('unclosed only block in %s' % filename)
        if num_only_blocks:
            with open(outname, 'w', encoding='utf-8') as outf:
                outf.writelines(output)


parser = argparse.ArgumentParser()
parser.add_argument('base')
parser.add_argument('outdir')
parser.add_argument('tag', nargs='+')
args = parser.parse_args()

base = args.base.rstrip('/') + '/'

for dir_name, sub_dirs, files in os.walk(base):
    for f in files:
        if not f.endswith('.rst'):
            continue
        for tag in args.tag:
            do_one(base, args.outdir, os.path.join(dir_name, f), tag)
