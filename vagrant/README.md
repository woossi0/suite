# Boundless Server build and packaging environment

A vagrant configuration which sets up a complete Boundless Server build and 
packaging environment.

The vagrant file defaults to CentOS 7, but can be configured for CentOS 6 
instead. Ubuntu 14, or Ubuntu 16 are also available, but don't work yet 
(package installation needs to be generified).

The vagrant file will install all prerequesites for the build, checkout the 
Boundless Server to `/home/vagrant/suite`, and initialize the submodules

Once it is running, you can ssh in via `vagrant ssh`, and build Boundless 
Server using `ant clean build assemble`, as per usual.

## Prerequesites: 

The ssh key you have registered with GitHub should be available from the host 
ssh user agent, so that Vagrant can forward it, in order to checkout all the
required repositories from GitHub.

You can add it (on the host machine) via `ssh-add -K /path/to/id_rsa`