.. _sysadmin.security.masterpwd:

Managing the master password
============================

The master password for GeoServer provides administrator access. It is used as the password to the GeoServer ``root`` account, which is a built-in administrator account. The ``root`` account is different from other GeoServer administrator accounts such as the default ``admin`` account, in that it is not possible to change the user name or roles of of the ``root`` account. The ``root`` account always has the role of ``ROLE_ADMINISTRATOR`` which provides access to all configuration options and functionality.

The master password also provides access to the keystore, the collection of reversible passwords that GeoServer saves for access to resources such as PostGIS datastores and other database connections.

Read more about the `master password <../../geoserver/security/passwd.html>`_ in the GeoServer reference.

Why to change the master password
---------------------------------

The master password is initially set in one of two ways depending on how the software was installed.

* In a clean installation, the master password will be a randomly generated collection of eight characters.
* In an upgrade from a version that didn't contain a master password, the master password will be set to be the password for the administrator account.

Both situations create an initial security risk. In a clean installation, the master password is stored in the GeoServer data directory at :file:`<data_dir>/security/masterpw.info`. This file should be deleted after verifying that this password works. In an upgrade, the older password information is stored in plain text at :file:`<data_dir>/security/users.properties.old`. This file should also be deleted.

In all cases, the master password should be changed after installation. As well, it is recommended to change the master password regularly.

Verifying the master password
-----------------------------

One should only need to log in to the GeoServer web admin interface as root for purposes of disaster recovery, such as when security configurations result in no administrative user being able to log in. An administrative user is defined as a user with the ``ROLE_ADMINISTRATOR`` role.

That said, one can log in to the GeoServer web admin interface as ``root`` to verify the master password. Use the following credentials:

* User name: ``root``
* Password: ``<master password>``

If the login is successful, the password is correct.

Changing the master password
----------------------------

#. Log in to the GeoServer web admin interface with an administrator account (a user that possesses the ``ROLE_ADMINISTRATOR`` role).

#. Once logged in, click :guilabel:`Passwords` in the :guilabel:`Security` section.

   .. figure:: img/masterpwd_menu_passwords.png

      *Passwords link in the Security menu*

#. At the very top of the screen next to :guilabel:`Active master password provider`, click :guilabel:`Change password` .

   .. figure:: img/masterpwd_page.png

      *Link to change the master password*

#. In the form that follows, enter the current master password, then the new master password, then again for confirmation. Click :guilabel:`Change password` when done.

   .. note:: The password will need to conform to the master password policy. By default, the policy states that the master password must be at least eight characters.

   .. figure:: img/masterpwd_change.png

      *Changing the master password*

#. Now that the password has been changed, delete the file :file:`<data_dir>/security/masterpw.info` and :file:`<data_dir>/security/users.properties.old`, as they are a security risk and are unnecessary.

#. Guard the new master password the same as any root or administrator account credentials.

Changing the master password policy
-----------------------------------

By default, the master password policy states that the master password must be at least eight characters. It may be desired to change this policy to provide a different level of security.

#. Log in to the GeoServer web admin interface with an administrator account (a user that possesses the ``ROLE_ADMINISTRATOR`` role).

#. Once logged in, click :guilabel:`Passwords` in the :guilabel:`Security` section.

   .. figure:: img/masterpwd_menu_passwords.png

      *Passwords link in the Security menu*

#. In the section titled :guilabel:`Password Policies`, click the :guilabel:`master` password policy.

   .. figure:: img/masterpwd_policy.png

      *Master password policy in the list of policies*

#. In the form that follows, adjust the settings. There are settings for the type of characters allowed in the password, and the length of the password. Click :guilabel:`Save` when done.

   .. figure:: img/masterpwd_policychange.png

      *Changing the master password policy*

The policy does not check to see if the current master password adheres to this new policy. After changing the policy, it is a good idea to go back and change the password to ensure that it adheres to this new policy.

