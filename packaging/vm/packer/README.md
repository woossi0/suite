# Boundless Server VM Image Creation:  
Recommended CentOS 6 VM running on VMware with VT-x enabled (or bare metal). VirtualBox & Hyper-V do not support nested virtualization, making Packer incompatible.  

1. Download/Setup Packer: https://www.packer.io/downloads.html  

2. Download/Setup VirtualBox:  

```bash
wget -O /etc/yum.repos.d/virtualbox.repo http://download.virtualbox.org/virtualbox/rpm/rhel/virtualbox.repo
yum update -y kernel
yum install -y epel-release kernel-devel
reboot
yum groupinstall -y "Development Tools"
yum install -y dkms VirtualBox-5.0 dejavu-lgc-sans-fonts xorg-x11-xauth xorg-x11-fonts-* xorg-x11-utils
/etc/init.d/vboxdrv setup
usermod -a -G vboxusers root
```

3. Clone Suite Build repo `git@github.com:boundlessgeo/suite.git`  

4. Navigate to `packaging/vm/packer/` dir  

5. Start build: (replace version/login as needed)

```bash
packer build -var 'server_version=1.0.2' -var 'repo_login=someuser' -var 'repo_password=somepass' boundless-server.json
```

6. Compress build image. (replace version as needed)  

```bash
cd output-virtualbox-iso
zip BoundlessServer_VirtualBox_1.0.2.ova.zip BoundlessServer_VirtualBox_1.0.2.ova
```
