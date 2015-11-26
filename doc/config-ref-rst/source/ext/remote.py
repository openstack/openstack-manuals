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

import requests
from sphinx.directives import code


class RemoteCodeBlock(code.CodeBlock):
    def run(self):

        r = requests.get(self.content[0])
        if r.status_code != 200:
            raise Exception

        self.content = [r.text]

        return super(RemoteCodeBlock, self).run()


def setup(app):
    app.add_directive('remote-code-block', RemoteCodeBlock)
    return {'parallel_read_safe': True}
