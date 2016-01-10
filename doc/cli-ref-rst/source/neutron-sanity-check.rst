.. This file is manually generated, unlike many of the other chapters.

========================================
neutron-sanity-check command-line client
========================================

The :command:`neutron-sanity-check` client is a tool that checks various
sanity about the Networking service.

This chapter documents :command:`neutron-sanity-check` version ``7.0.2``.

neutron-sanity-check usage
~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

   usage: neutron-sanity-check [-h] [--arp_header_match] [--arp_responder]
                               [--config-dir DIR] [--config-file PATH] [--debug]
                               [--dibbler_version] [--dnsmasq_version]
                               [--ebtables_installed] [--icmpv6_header_match]
                               [--iproute2_vxlan] [--keepalived_ipv6_support]
                               [--log-config-append PATH]
                               [--log-date-format DATE_FORMAT]
                               [--log-dir LOG_DIR] [--log-file PATH]
                               [--log-format FORMAT] [--noarp_header_match]
                               [--noarp_responder] [--nodebug]
                               [--nodibbler_version] [--nodnsmasq_version]
                               [--noebtables_installed] [--noicmpv6_header_match]
                               [--noiproute2_vxlan] [--nokeepalived_ipv6_support]
                               [--nonova_notify] [--noovs_geneve] [--noovs_patch]
                               [--noovs_vxlan] [--noovsdb_native]
                               [--noread_netns] [--nouse-syslog]
                               [--nouse-syslog-rfc-format] [--nova_notify]
                               [--noverbose] [--novf_management] [--ovs_geneve]
                               [--ovs_patch] [--ovs_vxlan] [--ovsdb_native]
                               [--read_netns] [--state_path STATE_PATH]
                               [--syslog-log-facility SYSLOG_LOG_FACILITY]
                               [--use-syslog] [--use-syslog-rfc-format]
                               [--verbose] [--version] [--vf_management]

neutron-sanity-check optional arguments
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

``-h, --help``
  show this help message and exit

``--arp_header_match``
  Check for ARP header match support

``--arp_responder``
  Check for ARP responder support

``--config-dir DIR``
  Path to a config directory to pull ``*.conf`` files from.
  This file set is sorted, so as to provide a predictable parse order
  if individual options are over-ridden. The set is parsed after the file(s)
  specified via previous :option:`--config-file`, arguments hence
  over-ridden options in the directory take precedence.

``--config-file PATH``
  Path to a config file to use. Multiple config files can be specified,
  with values in later files taking precedence.
  The default files used are: ``None``.

``--debug, -d``
  Print debugging output (set logging level to ``DEBUG`` instead of default
  ``INFO`` level).

``--dibbler_version``
  Check minimal dibbler version

``--dnsmasq_version``
  Check minimal dnsmasq version

``--ebtables_installed``
  Check ebtables installation

``--icmpv6_header_match``
  Check for ICMPv6 header match support

``--iproute2_vxlan``
  Check for iproute2 vxlan support

``--keepalived_ipv6_support``
  Check keepalived IPv6 support

``--log-config-append PATH, --log_config PATH``
  The name of a logging configuration file. This file is appended to any
  existing logging configuration files. For details about logging
  configuration files, see the Python logging module documentation.

``--log-date-format DATE_FORMAT``
  Format string for %(asctime)s in log records. Default: None.

``--log-dir LOG_DIR, --logdir LOG_DIR``
  (Optional) The base directory used for relative :option:`--log-file` paths.

``--log-file PATH, --logfile PATH``
  (Optional) Name of log file to output to.
  If no default is set, logging will go to stdout.

``--log-format FORMAT``
  **DEPRECATED**. A logging.Formatter log message format string which may
  use any of the available logging.LogRecord attributes. This option is
  deprecated. Please use ``logging_context_format_string`` and
  ``logging_default_format_string`` instead.

``--noarp_header_match``
  The inverse of :option:`--arp_header_match`

``--noarp_responder``
  The inverse of :option:`--arp_responder`

``--nodebug``
  The inverse of :option:`--debug`

``--nodibbler_version``
  The inverse of :option:`--dibbler_version`

``--nodnsmasq_version``
  The inverse of :option:`--dnsmasq_version`

``--noebtables_installed``
  The inverse of :option:`--ebtables_installed`

``--noicmpv6_header_match``
  The inverse of :option:`--icmpv6_header_match`

``--noiproute2_vxlan``
  The inverse of :option:`--iproute2_vxlan`

``--nokeepalived_ipv6_support``
  The inverse of :option:`--keepalived_ipv6_support`

``--nonova_notify``
  The inverse of :option:`--nova_notify`

``--noovs_geneve``
  The inverse of :option:`--ovs_geneve`

``--noovs_patch``
  The inverse of :option:`--ovs_patch`

``--noovs_vxlan``
  The inverse of :option:`--ovs_vxlan`

``--noovsdb_native``
  The inverse of :option:`--ovsdb_native`

``--noread_netns``
  The inverse of :option:`--read_netns`

``--nouse-syslog``
  The inverse of :option:`--use-syslog`

``--nouse-syslog-rfc-format``
  The inverse of :option:`--use-syslog-rfc-format`

``--nova_notify``
  Check for nova notification support

``--noverbose``
  The inverse of :option:`--verbose`

``--novf_management``
  The inverse of :option:`--vf_management`

``--ovs_geneve``
  Check for OVS Geneve support

``--ovs_patch``
  Check for patch port support

``--ovs_vxlan``
  Check for OVS vxlan support

``--ovsdb_native``
  Check ovsdb native interface support

``--read_netns``
  Check netns permission settings

``--state_path STATE_PATH``
  Where to store Neutron state files. This directory must be writable
  by the agent.

``--syslog-log-facility SYSLOG_LOG_FACILITY``
  Syslog facility to receive log lines.

``--use-syslog``
  Use syslog for logging. Existing syslog format is
  DEPRECATED and will be changed later to honor RFC5424.

``--use-syslog-rfc-format``
  (Optional) Enables or disables syslog rfc5424 format for logging.
  If enabled, prefixes the MSG part of the syslog message with APP-NAME
  (RFC5424). The format without the APP-NAME is deprecated in Kilo,
  and will be removed in Mitaka, along with this option.

``--verbose, -v``
  If set to false, will disable ``INFO`` logging level,
  making ``WARNING`` the default.

``--version``
  show program's version number and exit

``--vf_management``
  Check for VF management support
