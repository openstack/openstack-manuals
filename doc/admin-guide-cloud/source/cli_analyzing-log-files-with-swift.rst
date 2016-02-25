=================
Analyze log files
=================

Use the swift command-line client for Object Storage to analyze log files.

The swift client is simple to use, scalable, and flexible.

Use the swift client :option:`-o` or :option:`-output` option to get
short answers to questions about logs.

You can use the :option:`-o` or :option:`--output` option with a single object
download to redirect the command output to a specific file or to STDOUT
(``-``). The ability to redirect the output to STDOUT enables you to
pipe (``|``) data without saving it to disk first.

Upload and analyze log files
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. This example assumes that ``logtest`` directory contains the
   following log files.

   .. code-block:: console

      2010-11-16-21_access.log
      2010-11-16-22_access.log
      2010-11-15-21_access.log
      2010-11-15-22_access.log


   Each file uses the following line format.

   .. code-block:: console

      Nov 15 21:53:52 lucid64 proxy-server - 127.0.0.1 15/Nov/2010/22/53/52 DELETE /v1/AUTH_cd4f57824deb4248a533f2c28bf156d3/2eefc05599d44df38a7f18b0b42ffedd HTTP/1.0 204 - \
       - test%3Atester%2CAUTH_tkcdab3c6296e249d7b7e2454ee57266ff - - - txaba5984c-aac7-460e-b04b-afc43f0c6571 - 0.0432


#. Change into the ``logtest`` directory:

   .. code-block:: console

      $ cd logtest

#. Upload the log files into the ``logtest`` container:

   .. code-block:: console

      $ swift -A http://swift-auth.com:11000/v1.0 -U test:tester -K testing upload logtest *.log

   .. code-block:: console

      2010-11-16-21_access.log
      2010-11-16-22_access.log
      2010-11-15-21_access.log
      2010-11-15-22_access.log

#. Get statistics for the account:

   .. code-block:: console

      $ swift -A http://swift-auth.com:11000/v1.0 -U test:tester -K testing \
      -q stat

   .. code-block:: console

      Account: AUTH_cd4f57824deb4248a533f2c28bf156d3
      Containers: 1
      Objects: 4
      Bytes: 5888268

#. Get statistics for the ``logtest`` container:

   .. code-block:: console

      $ swift -A http://swift-auth.com:11000/v1.0 -U test:tester -K testing \
      stat logtest

   .. code-block:: console

      Account: AUTH_cd4f57824deb4248a533f2c28bf156d3
      Container: logtest
      Objects: 4
      Bytes: 5864468
      Read ACL:
      Write ACL:

#. List all objects in the logtest container:

   .. code-block:: console

      $ swift -A http:///swift-auth.com:11000/v1.0 -U test:tester -K testing \
      list logtest

   .. code-block:: console

      2010-11-15-21_access.log
      2010-11-15-22_access.log
      2010-11-16-21_access.log
      2010-11-16-22_access.log

Download and analyze an object
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This example uses the :option:`-o` option and a hyphen (``-``) to get
information about an object.

Use the :command:`swift download` command to download the object. On this
command, stream the output to ``awk`` to break down requests by return
code and the date ``2200 on November 16th, 2010``.

Using the log line format, find the request type in column 9 and the
return code in column 12.

After ``awk`` processes the output, it pipes it to ``sort`` and ``uniq
-c`` to sum up the number of occurrences for each request type and
return code combination.

#. Download an object:

   .. code-block:: console

      $ swift -A http://swift-auth.com:11000/v1.0 -U test:tester -K testing \
           download -o - logtest 2010-11-16-22_access.log | awk '{ print \
           $9"-"$12}' | sort | uniq -c

   .. code-block:: console

       805 DELETE-204
       12 DELETE-404
       2 DELETE-409
       723 GET-200
       142 GET-204
       74 GET-206
       80 GET-304
       34 GET-401
       5 GET-403
       18 GET-404
       166 GET-412
       2 GET-416
       50 HEAD-200
       17 HEAD-204
       20 HEAD-401
       8 HEAD-404
       30 POST-202
       25 POST-204
       22 POST-400
       6 POST-404
       842 PUT-201
       2 PUT-202
       32 PUT-400
       4 PUT-403
       4 PUT-404
       2 PUT-411
       6 PUT-412
       6 PUT-413
       2 PUT-422
       8 PUT-499

#. Discover how many PUT requests are in each log file.

   Use a bash for loop with awk and swift with the :option:`-o` or
   :option:`--output` option and a hyphen (``-``) to discover how many
   PUT requests are in each log file.

   Run the :command:`swift list` command to list objects in the logtest
   container. Then, for each item in the list, run the
   :command:`swift download -o -` command. Pipe the output into grep to
   filter the PUT requests. Finally, pipe into ``wc -l`` to count the lines.

   .. code-block:: console

       $ for f in `swift -A http://swift-auth.com:11000/v1.0 -U test:tester \
        -K testing list logtest` ; \
               do  echo -ne "PUTS - " ; swift -A \
               http://swift-auth.com:11000/v1.0 -U test:tester \
               -K testing download -o -  logtest $f | grep PUT | wc -l ; \
           done

   .. code-block:: console

       2010-11-15-21_access.log - PUTS - 402
       2010-11-15-22_access.log - PUTS - 1091
       2010-11-16-21_access.log - PUTS - 892
       2010-11-16-22_access.log - PUTS - 910

#. List the object names that begin with a specified string.

#. Run the :command:`swift list -p 2010-11-15` command to list objects
   in the logtest container that begin with the ``2010-11-15`` string.

#. For each item in the list, run the :command:`swift download -o -` command.

#. Pipe the output to :command:`grep` and :command:`wc`.
   Use the :command:`echo` command to display the object name.

   .. code-block:: console

       $ for f in `swift -A http://swift-auth.com:11000/v1.0 -U test:tester \
        -K testing list -p 2010-11-15 logtest` ; \
               do  echo -ne "$f - PUTS - " ; swift -A \
               http://127.0.0.1:11000/v1.0 -U test:tester \
               -K testing download -o - logtest $f | grep PUT | wc -l ; \
             done

   .. code-block:: console

      2010-11-15-21_access.log - PUTS - 402
      2010-11-15-22_access.log - PUTS - 910

