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
#
"""This module is used by the openstack-doc-tools autohelp.py script.

Hooks to handle configuration options not handled on module import or with a
call to _register_runtime_opts(). The HOOKS dict associates hook functions with
a module path."""


def aodh_config():
    # Aodh uses a local conf object, therefore we need to use the same method
    # here to populate the global cfg.CONF object used by the script.
    import aodh.opts as opts
    from oslo_config import cfg

    cfg.CONF = cfg.ConfigOpts()
    for group, options in opts.list_opts():
        cfg.CONF.register_opts(list(options),
                               group=None if group == "DEFAULT" else group)


def glance_store_config():
    try:
        import glance_store
        from oslo_config import cfg

        glance_store.backend.register_opts(cfg.CONF)
    except ImportError:
        # glance_store is not available before Juno
        pass


def keystone_config():
    from keystone.common import config

    config.configure()


def neutron_misc():
    try:
        # These imports are needed for kilo only
        import bsnstacklib.plugins.bigswitch.config
        import networking_cisco.plugins.cisco.cfg_agent.device_status  # noqa
        import networking_l2gw.services.l2gateway.common.config as l2gw
        import networking_vsphere.common.config
        from oslo_config import cfg
        import vmware_nsx.neutron.plugins.vmware.common.config  # noqa

        bsnstacklib.plugins.bigswitch.config.register_config()
        networking_vsphere.common.config.register_options()
        l2gw.register_l2gw_opts_helper()
        l2gw.register_ovsdb_opts_helper(cfg.CONF)
    except Exception:
        pass


def nova_spice():
    import os
    # nova.cmd.__init__ before kilo requires to be imported before eventlet is.
    # Since we can't make sure of that, we define this envvar to let nova know
    # that the import is OK (see nova/cmd/__init__.py)
    os.environ['EVENTLET_NO_GREENDNS'] = 'yes'
    import nova.cmd.spicehtml5proxy  # noqa


def zaqar_config():
    # Zaqar registers most of its options in lazy way
    # Let's find all these options and manually register them
    from oslo_config import cfg
    import pkg_resources

    zaqar_opts_sets = []
    for p in pkg_resources.iter_entry_points(group='oslo.config.opts'):
        if p.name.startswith('zaqar'):
            zaqar_opts_sets.append(p.load())

    for opts_set in zaqar_opts_sets:
        for group, options in opts_set():
            for opt in options:
                try:
                    cfg.CONF.register_opt(opt, group=group)
                except cfg.DuplicateOptError:
                    pass

    # Let's unregister options that were automatically registered from embedded
    # zaqar-bench tool during import of Zaqar's modules
    from zaqar.bench import config as bench_config
    cfg.CONF.unregister_opts(bench_config._CLI_OPTIONS)

HOOKS = {'aodh': aodh_config,
         'glance.common.config': glance_store_config,
         'keystone.common.config': keystone_config,
         'neutron': neutron_misc,
         'nova.spice': nova_spice,
         'zaqar': zaqar_config}
