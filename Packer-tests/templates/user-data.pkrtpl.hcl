#cloud-config
autoinstall:
  apt:
    disable_components: []
    geoip: true
    preserve_sources_list: false
    primary:
    - arches:
      - amd64
      - i386
      uri: http://az.archive.ubuntu.com/ubuntu
    - arches:
      - default
      uri: http://ports.ubuntu.com/ubuntu-ports
  identity:
    hostname: ${vm_hostname}
    password: ${vm_encrypted_pass}
    realname: ${realname}
    username: ${vm_username}
  kernel:
    package: linux-generic
  keyboard:
    layout: us
    toggle: null
    variant: ''
  locale: en_US.UTF-8
  network:
    network:
      ethernets:
        eth0:
          addresses:
          - ${vm_ip_addr}
          gateway4: ${vm_gateway} 
          nameservers:
            addresses: 
%{ for dns in nameservers ~}
            - ${dns}
%{ endfor ~}
            search: []
    version: 2
  ssh:
    allow-pw: true
    authorized-keys: []
    install-server: true
  packages: 
%{ for package in packages ~}
  - ${package}
%{ endfor ~}
  storage:
    layout:
      name: lvm
  updates: security
  version: 1
  late-commands:
    - sed -ie 's/GRUB_CMDLINE_LINUX=.*/GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0"/' /target/etc/default/grub
    - curtin in-target --target=/target -- update-grub2
    - curtin in-target --target=/target -- apt-get update
    - curtin in-target --target=/target -- apt-get upgrade --yes
