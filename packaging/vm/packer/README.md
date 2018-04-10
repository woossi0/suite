# Boundless Server VM Image Creation:  

1. Download/Setup Packer: https://www.packer.io/downloads.html  

2. Clone Suite Build repo `git@github.com:boundlessgeo/suite-build.git`  

3. Navigate to `packer/` dir  

4. Start build: (replace version/login as needed)

```bash
packer build -var 'server_version=1.0.2' -var 'repo_login=someuser' -var 'repo_password=somepass' boundless-server.json
```

5. Compress build image. (replace version as needed)  

```bash
cd output-virtualbox-iso
zip BoundlessServer_VirtualBox_1.0.2.ova.zip BoundlessServer_VirtualBox_1.0.2.ova
```
