=================================
Dashboard configuration options
=================================

The following options are available to configure and customize the
behavior of your Dashboard installation.

Dashboard settings
~~~~~~~~~~~~~~~~~~

The following options are included in the ``HORIZON_CONFIG`` dictionary.

.. note ::

   Dashboards are automatically discovered in two ways:

   #. By adding a configuration file to the
      ``openstack_dashboard/local/enabled`` directory. This is the default
      way.

   #. By traversing Django’s list of ``INSTALLED_APPS`` and importing
      any files that have the name ``dashboard.py`` and include code to
      register themselves as a Dashboard.

.. warning::

   In Dashboard configuration, we suggest that you do not use the
   ``dashboards`` and ``default_dashboard`` settings. If you plan on having
   more than one dashboard, please specify their order using the
   `Pluggable settings`_.

.. list-table:: Description of standard Dashboard configuration options
   :header-rows: 1

   * - Configuration option = Default value
     - Description
   * - ``ajax_queue_limit`` = ``10``
     - The maximum number of simultaneous AJAX connections the dashboard
       may try to make.
   * - ``ajax_poll_interval`` = ``2500``
     - How frequently resources in transition states should be polled for
       updates. Expressed in milliseconds.
   * - ``angular_modules`` = ``[]``
     - A list of AngularJS modules to be loaded when Angular bootstraps.
   * - ``auto_fade_alerts`` = ``{'delay': [3000], 'fade_duration': [1500],
       'types': []}``
     - If provided, will auto-fade the alert types specified. Valid alert
       types include ``alert-default``, ``alert-success``, ``alert-info``,
       ``alert-warning``, ``alert-danger``. Can also define the delay before
       the alert fades and the fade out duration.
   * - ``bug_url`` = ``None``
     - Displays a “Report Bug” link in the site header which links to the
       value of this setting, ideally a URL containing information on how to
       report issues.
   * - ``dashboards`` = ``None``
     - If a list of ``dashboard`` slugs is provided in this setting, the
       supplied ordering is applied to the list of discovered dashboards.
   * - ``default_dashboard`` = ``None``
     - The slug of the dashboard which should act as the fallback dashboard
       whenever a user logs in or is otherwise redirected to an ambiguous
       location.
   * - ``disable_password_reveal`` = ``False``
     - Setting this to ``True`` will disable the reveal button for password
       fields, including on the login form.
   * - ``exceptions`` = ``{'unauthorized': [], 'not_found': [],
       'recoverable': []}``
     - Classes of exceptions which the Dashboard’s centralized exception
       handling should be aware of.
   * - ``help_url`` = ``None``
     - Displays a “Help” link in the site header which links to the
       value of this setting, ideally a URL containing help information.
   * - ``js_files`` = ``[]``
     - A list of javascript source files to be included in the compressed
       set of files that are loaded on every page.
   * - ``js_spec_files`` = ``[]``
     - A list of JavaScript spec files to include for integration with the
       Jasmine spec runner.
   * - ``modal_backdrop`` = ``static``
     - Controls how bootstrap backdrop element outside of modals looks
       and feels. Valid values are ``true``, ``false`` and ``static``.
   * - ``password_autocomplete`` = ``off``
     - Controls whether browser autocompletion should be enabled on the
       login form. Valid values are ``on`` and ``off``.
   * - ``password_validator`` = ``{'regex': '.*',
       'help_text': _("Password is not accepted")}``
     - A dictionary, containing a regular expression used for
       password validation and help text, which will be displayed if
       the password does not pass validation. The help text should describe
       the password requirements if there are any.
   * - ``simple_ip_management`` = ``True``
     - Enable or disable simplified floating IP address management.
   * - ``user_home`` = ``settings.LOGIN_REDIRECT_URL``
     - Either a literal URL path, such as the default, or Python’s dotted
       string notation representing a function which evaluates the URL the
       user should be redirected to based on the attributes of the user.

Django settings
~~~~~~~~~~~~~~~

The following table shows a few key Django settings you should be aware of for
the most basic of deployments.

.. warning::

   This is not meant to be anywhere near a complete list of settings for
   Django. You should always consult the
   `main Django documentation <https://docs.djangoproject.com/en/1.9/>`_,
   especially with regards to deployment considerations and security
   best-practices.

.. list-table:: Description of the Dashboard's Django configuration options
   :header-rows: 1

   * - Configuration option = Default value
     - Description
   * - ``ALLOWED_HOSTS`` = ``['localhost']``
     - List of names or IP addresses of the hosts running the dashboard.
   * - ``DEBUG`` and ``TEMPLATE_DEBUG`` = ``True``
     - Controls whether unhandled exceptions should generate a generic
       ``500`` response or present the user with a pretty-formatted debug
       information page.
   * - ``SECRET_KEY``
     - A unique and secret value for your deployment. Unless you are running
       a load-balancer with multiple Dashboard installations behind it,
       each Dashboard instance should have a unique secret key.
   * - ``SECURE_PROXY_SSL_HEADER``, ``CSRF_COOKIE_SECURE``
       and ``SESSION_COOKIE_SECURE``
     - These three should be configured if you are deploying the Dashboard
       with SSL. The values indicated in the default
       ``openstack_dashboard/local/local_settings.py.example`` file
       are generally safe to use. When ``CSRF_COOKIE_SECURE`` or
       ``SESSION_COOKIE_SECURE`` are set to ``True``, these attributes help
       protect the session cookies from cross-site scripting.
   * - ``ADD_INSTALLED_APPS``
     - A list of Django applications to be prepended to the
       ``INSTALLED_APPS`` setting. Allows extending the list of installed
       applications without having to override it completely.

OpenStack settings (partial)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following settings inform the Dashboard of information about the other
OpenStack projects which are part of the same cloud and control the behavior
of specific dashboards, panels, API calls, and so on.

.. list-table:: Description of the Dashboard's OpenStack configuration options
   :header-rows: 1

   * - Configuration option = Default
     - Description
   * - ``AUTHENTICATION_URLS`` = ``['openstack_auth.urls']``
     - A list of modules from which to collate authentication URLs from.
   * - ``API_RESULT_LIMIT`` = ``1000``
     - The maximum number of objects, for example Glance images to display
       on a single page before providing a paging element to paginate the
       results.
   * - ``API_RESULT_PAGE_SIZE`` = ``20``
     - Similar to ``API_RESULT_LIMIT``. This setting controls the number
       of items to be shown per page if API pagination support for this
       exists.
   * - ``AVAILABLE_REGIONS`` = ``None``
     - A list of tuples which defines multiple regions.
   * - ``AVAILABLE_THEMES`` = ``[ ('default', 'Default',
       'themes/default'), ('material', 'Material',
       'themes/material') ]``
     - Configure this setting to tell horizon which theme to use. Horizon
       contains two pre-configured themes. These themes are ``'default'`` and
       ``'material'``. Horizon uses three tuples in a list to define multiple
       themes. The tuple format is
       ``('{{ theme_name }}', '{{ theme_label }}', '{{ theme_path }}')``.
       Configure ``theme_name`` to define the directory
       that customized themes are collected into. The ``theme-label``
       is a user-facing label shown in the theme picker. Horizon uses
       ``theme path`` as the static root of the theme. If you
       want to include content other than static files in a theme
       directory, but do not wish the content served up at
       ``/{{ THEME_COLLECTION_DIR }}/{{ theme_name }}``, create a subdirectory
       named ``static``. If your theme folder contains a subdirectory named
       ``static``, then horizon uses ``static/custom/static`` as the root
       for content served at ``/static/custom``. The static root of the theme
       folder must always contain a ``_variables.scss`` file and
       ``a _styles.scss`` file. These two files must contain or import
       all the styles, bootstrap, and horizon-specific variables used in
       the GUI.
   * - ``CONSOLE_TYPE`` = ``AUTO``
     - The type of in-browser console used to access the virtual machines.
       Valid values are ``AUTO``, ``VNC``, ``SPICE``, ``RDP``, ``SERIAL``,
       and ``None``. ``None`` deactivates the in-browser console
       and is available in Juno. ``SERIAL`` is available since Kilo.
   * - ``SWIFT_FILE_TRANSFER_CHUNK_SIZE`` = ``512 * 1024``
     - The size of the chunk, in bytes, for downloading objects from
       the Object Storage service.
   * - ``INSTANCE_LOG_LENGTH`` = ``35``
     - The number of lines displayed for the log of an instance. Valid
       value must be a positive integer.
   * - ``CREATE_INSTANCE_FLAVOR_SORT`` = ``{'key':'ram'}``
     - When launching a new instance the default flavor is sorted by
       RAM usage in ascending order. You can customize the sort order by
       ``id``, ``name``, ``ram``, ``disk`` and ``vcpus``. You can also
       insert any custom callback function and also provide a flag for
       reverse sort.
   * - ``DEFAULT_THEME`` = ``default``
     - This setting configures which theme horizon uses if a theme
       has not yet been selected in the theme picker. This also sets
       the cookie value. This value represents the `theme_name` key used
       when there are multiple themes available. Configure this setting
       inside ``AVAILABLE_THEMES`` to make use of this theme.
   * - ``DROPDOWN_MAX_ITEMS`` = ``30``
     -  The maximum number of items displayed in a dropdown.
   * - ``ENFORCE_PASSWORD_CHECK`` = ``False``
     - Displays an ``Admin Password`` field on the 'Change Password' form
       to verify that it is indeed the admin logged-in who wants to change
       the password.
   * - ``IMAGES_LIST_FILTER_TENANTS`` = ``None``
     - A list of dictionaries to add optional categories to the image fixed
       filters in the Images panel, based on project ownership.
   * - ``IMAGE_RESERVED_CUSTOM_PROPERTIES`` = ``[]``
     - A list of image custom property keys that should not be displayed in
       the Update Metadata tree.
   * - ``LAUNCH_INSTANCE_DEFAULTS`` = ``{"config_drive": False}``
     - A dictionary of settings which can be used to provide the default
       values for properties found in the Launch Instance modal.
   * - ``MESSAGES_PATH`` = ``None``
     - The absolute path to the directory where message files are collected.
   * - ``OPENSTACK_API_VERSIONS`` = ``{"data-processing": 1.1,
       "identity": 2.0, "volume": 2, "compute": 2}``
     -  Use this setting to force the dashboard to use a specific API
        version for a given service API.
   * - ``OPENSTACK_ENABLE_PASSWORD_RETRIEVE`` = ``False``
     - Enables or disables the instance action 'Retrieve password'
       allowing password retrieval from metadata service.
   * - ``OPENSTACK_ENDPOINT_TYPE`` = ``"publicURL"``
     - A string specifying the endpoint type to use for the endpoints in
       the Identity service catalog.
   * - ``OPENSTACK_HOST`` = ``"127.0.0.1"``
     - The hostname of the Identity service server used for authentication
       if you only have one region. This is often the only setting that
       needs to be set for a basic deployment.
   * - ``OPENSTACK_HYPERVISOR_FEATURES`` = ``{'can_set_mount_point': False,
       'can_set_password': False, 'requires_keypair': False,}``
     - A dictionary of settings identifying the capabilities of the
       hypervisor of Compute service.
   * - ``OPENSTACK_IMAGE_BACKEND`` = ``{'image_formats': [
       ('', _('Select format')),
       ('aki', _('AKI - Amazon Kernel Image')),
       ('ami', _('AMI - Amazon Machine Image')),
       ('ari', _('ARI - Amazon Ramdisk Image')),
       ('docker', _('Docker')),
       ('iso', _('ISO - Optical Disk Image')),
       ('qcow2', _('QCOW2 - QEMU Emulator')),
       ('raw', _('Raw')),
       ('vdi', _('VDI')),
       ('vhd', _('VHD')),
       ('vmdk', _('VMDK'))]}``
     - Customizes features related to the Image service, such as the
       list of supported image formats.
   * - ``IMAGE_CUSTOM_PROPERTY_TITLES`` = ``{
       "architecture": _("Architecture"),
       "kernel_id": _("Kernel ID"),
       "ramdisk_id": _("Ramdisk ID"),
       "image_state": _("Euca2ools state"),
       "project_id": _("Project ID"),
       "image_type": _("Image Type")}``
     - Customizes the titles for image custom property attributes that
       appear on image detail pages.
   * - ``HORIZON_IMAGES_ALLOW_UPLOAD`` = ``True``
     - Enables/Disables local uploads to prevent filling up the disk on the
       dashboard server.
   * - ``OPENSTACK_KEYSTONE_BACKEND`` = ``{'name': 'native',
       'can_edit_user': True, 'can_edit_project': True}``
     - A dictionary of settings identifying the capabilities of the auth
       backend for the Identity service.
   * - ``OPENSTACK_KEYSTONE_DEFAULT_DOMAIN`` = ``"Default"``
     - Overrides the default domain used when running on a single-domain
       model with version 3 of the Identity service. All entities will
       be created in the default domain.
   * - ``OPENSTACK_KEYSTONE_DEFAULT_ROLE`` = ``"_member_"``
     - The role to be assigned to a user when they are added to a project.
       The value must correspond to an existing role name in the
       Identity service. In general, the value should match the
       ``member_role_name`` defined in ``keystone.conf``.
   * - ``OPENSTACK_KEYSTONE_ADMIN_ROLES`` = ``["admin"]``
     - The list of roles that have administrator privileges in the
       OpenStack installation.  This check is very basic and essentially
       only works with versions 2 and 3 of the Identity service with the
       default policy file.
   * - ``OPENSTACK_KEYSTONE_MULTIDOMAIN_SUPPORT`` = ``False``
     - When enabled, a user will be required to enter the Domain name in
       addition to username for login. Enabled if running on a multi-domain
       model.
   * - ``OPENSTACK_KEYSTONE_URL`` = ``"http://%s:5000/v2.0" % OPENSTACK_HOST``
     - The full URL for the Identity service endpoint used for authentication.
   * - ``OPENSTACK_KEYSTONE_FEDERATION_MANAGEMENT`` = ``False``
     - Enables/Disables panels that provide the ability for users to manage
       Identity Providers (IdPs) and establish a set of rules to map
       federation protocol attributes to Identity API attributes. Requires
       version 3 and later of the Identity API.
   * - ``WEBSSO_ENABLED`` = ``False``
     - Enables/Disables Identity service web single-sign-on. Requires Identity
       service version 3and Django OpenStack Auth version 1.2.0 or later.
   * - ``WEBSSO_INITIAL_CHOICE`` = ``"credentials"``
     - Determines the default authentication mechanism. When a user lands
       on the login page, this is the first choice they will see.
   * - ``WEBSSO_CHOICES`` = ``(
       ("credentials", _("Keystone Credentials")),
       ("oidc", _("OpenID Connect")),
       ("saml2", _("Security Assertion Markup Language")))``
     - List of authentication mechanisms available to the user.
   * - ``WEBSSO_IDP_MAPPING`` = ``{}``
     - A dictionary of specific identity provider and federation
       protocol combinations.
   * - ``OPENSTACK_CINDER_FEATURES`` = ``{'enable_backup': False}``
     - A dictionary of settings which can be used to enable optional
       services provided by the Block storage service. Currently, only the
       backup service is available.
   * - ``OPENSTACK_HEAT_STACK`` = ``{'enable_user_pass': True}``
     - A dictionary of settings to use with heat stacks. Currently,
       the only setting available is ``enable_user_pass``, which can be
       used to disable the password field while launching the stack.
   * - ``OPENSTACK_NEUTRON_NETWORK`` = ``{
       'enable_router': True,
       'enable_distributed_router': False,
       'enable_ha_router': False,
       'enable_lb': True,
       'enable_quotas': False,
       'enable_firewall': True,
       'enable_vpn': True,
       'profile_support': None,
       'supported_provider_types': ["*"],
       'supported_vnic_types': ["*"],
       'segmentation_id_range': {},
       'enable_fip_topology_check': True,
       'default_ipv4_subnet_pool_label': None,
       'default_ipv6_subnet_pool_label': None,}``
     - A dictionary of settings which can be used to enable optional
       services provided by the Networking service and configure specific
       features.
   * - ``OPENSTACK_SSL_CACERT`` = ``None``
     -  The CA certificate to be used for SSL verification. When set to
        ``None``, the default certificate on the system is used.
   * - ``OPENSTACK_SSL_NO_VERIFY`` = ``False``
     - Enable/Disable SSL certificate checks in the OpenStack clients.
       Useful for self-signed certificates.
   * - ``OPENSTACK_TOKEN_HASH_ALGORITHM`` = ``"md5"``
     - The hash algorithm to use for authentication tokens.
   * - ``OPENSTACK_TOKEN_HASH_ENABLED`` = ``True``
     - Hashing tokens from the Identity service keep the Dashboard session
       data smaller, but it doesn’t work in some cases when using PKI tokens.
       Uncomment this value and set it to False if using PKI tokens and
       there are ``401`` errors due to token hashing.
   * - ``POLICY_FILES`` = ``{'identity': 'keystone_policy.json',
       'compute': 'nova_policy.json'}``
     - The mapping of the contents of ``POLICY_FILES_PATH`` to service
       types. When ``policy.json`` files are added to ``POLICY_FILES_PATH``,
       they should be included here too.
   * - ``POLICY_FILES_PATH`` = ``os.path.join(ROOT_PATH, "conf")``
     -  Where service based policy files are located.
   * - ``SESSION_TIMEOUT`` = ``3600``
     - A method to supersede the token timeout with a shorter dashboard
       session timeout in seconds. For example, if your token expires in
       60 minutes, a value of 1800 will log users out after 30 minutes.
   * - ``SAHARA_AUTO_IP_ALLOCATION_ENABLED`` = ``False``
     - Notifies the Data processing system whether or not automatic IP
       allocation is enabled. Set to ``True`` if you are running Compute
       Networking with ``auto_assign_floating_ip = True``.
   * - ``TROVE_ADD_USER_PERMS`` and ``TROVE_ADD_DATABASE_PERMS`` = ``[]``
     - Database service user and database extension support.
   * - ``WEBROOT`` = ``/``
     - The location where the access to the dashboard is configured in the
       web server.
   * - ``STATIC_ROOT`` = ``/static/``
     - URL pointing to files in ``STATIC_ROOT``. the value must end in ``"/"``.
   * - ``THEME_COLLECTION_DIR`` = ``themes``
     - Horizon collects the available themes into a static directory
       based on this variable setting. For example, the default theme
       is accessible from ``/{{ STATIC_URL }}/themes/default``.
   * - ``THEME_COOKIE_NAME`` = ``themes``
     -  This setting determines which cookie key horizon sets to store the
        current theme. Cookie keys expire after one year elapses.
   * - ``DISALLOW_IFRAME_EMBED`` = ``True``
     - This setting can be used to defend against Clickjacking and prevent
       the Dashboard from being embedded within an iframe.
   * - ``OPENSTACK_NOVA_EXTENSIONS_BLACKLIST`` = ``[]``
     - Ignore all listed Compute service extensions, and behave as if they
       were unsupported. Can be used to selectively disable certain costly
       extensions for performance reasons.

Pluggable settings
~~~~~~~~~~~~~~~~~~

The following keys can be used in any pluggable settings file.

.. list-table:: Description of the Dashboard's pluggable configuration options
   :header-rows: 1

   * - Configuration option
     - Description
   * - ``ADD_EXCEPTIONS``
     - A dictionary of exception classes to be added to
       ``HORIZON['exceptions']``.
   * - ``ADD_INSTALLED_APPS``
     - A list of applications to be prepended to ``INSTALLED_APPS``. This
       is needed to expose static files from a plugin.
   * - ``ADD_ANGULAR_MODULES``
     - A list of AngularJS modules to be loaded when Angular bootstraps.
   * - ``ADD_JS_FILES``
     - A list of javascript source files to be included in the compressed
       set of files that are loaded on every page.
   * - ``ADD_JS_SPEC_FILES``
     - A list of javascript spec files to include for integration with the
       Jasmine spec runner.
   * - ``ADD_SCSS_FILES``
     - A list of SCSS files to be included in the compressed set of files
       that are loaded on every page.
   * - ``AUTO_DISCOVER_STATIC_FILES``
     - If set to ``True``, JavaScript files and static angular HTML
       template files will be automatically discovered from the static
       folder in each apps listed in ``ADD_INSTALLED_APPS``.
   * - ``DISABLED``
     - If set to ``True``, this settings file will not be added to the
       settings.
   * - ``UPDATE_HORIZON_CONFIG``
     - A dictionary of values that will replace the values in
       ``HORIZON_CONFIG``.

Pluggable settings for dashboards
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following keys are specific to register a dashboard.

.. list-table:: Description of the pluggable dashboards configuration options
   :header-rows: 1

   * - Configuration option
     - Description
   * - ``DASHBOARD``
     - Required. The slug of the dashboard to be added to
       ``HORIZON['dashboards']``.
   * - ``DEFAULT``
     - If set to ``True``, this dashboard will be set as the default
       dashboard.

Pluggable settings for panels
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following keys are specific to register or remove a panel.

.. list-table:: Description of the pluggable panels configuration options
   :header-rows: 1

   * - Configuration option
     - Description
   * - ``PANEL``
     - Required. The slug of the panel to be added to ``HORIZON_CONFIG``.
   * - ``PANEL_DASHBOARD``
     - Required. The slug of the dashboard the ``PANEL`` is associated with.
   * - ``PANEL_GROUP``
     - The slug of the panel group the ``PANEL`` is associated with. If
       you want the panel to show up without a panel group, use the panel
       group ``default``.
   * - ``DEFAULT_PANEL``
     - If set, it will update the default panel of the ``PANEL_DASHBOARD``.
   * - ``ADD_PANEL``
     - Python panel class of the ``PANEL`` to be added.
   * - ``REMOVE_PANEL``
     - If set to ``True``, the ``PANEL`` will be removed from
       ``PANEL_DASHBOARD``/``PANEL_GROUP``.

Pluggable settings for panel groups
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following keys are specific to register a panel group.

.. list-table:: Description of the pluggable panel groups configuration options
   :header-rows: 1

   * - Configuration option
     - Description
   * - ``PANEL_GROUP``
     - Required. The slug of the panel group to be added to
       ``HORIZON_CONFIG``.
   * - ``PANEL_GROUP_NAME``
     - Required. The display name of the ``PANEL_GROUP``.
   * - ``PANEL_GROUP_DASHBOARD``
     - Required. The slug of the dashboard the ``PANEL_GROUP`` associated
       with.
