# packer-build-kvm-image-using-QEMU-and-cloud-image

1.Using Docker 

Build a OS image with QEMU and Ubuntu Cloud Image

Prerequirements

Packer
QEMU
Docker
Build an image of cloud-init settings
```
$ docker run -it -v `pwd`:/tmp/host --rm ubuntu:16.04
# apt update
# apt install -y vim cloud-utils
# cloud-localds /tmp/host/cloud.img /tmp/host/cloud.cfg
```
Build a OS image with Packer
```
$ packer build template.json
```
2.Without docker
```
$ sudo apt install -y cloud-utils
$ cloud-localds ./cloud.img ./cloud.cfg
$ packer build template.json
```
