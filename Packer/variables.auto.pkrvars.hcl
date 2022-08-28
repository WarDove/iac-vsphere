##################################################################################
# Vsphere common values
##################################################################################


vcenter_username="administrator@azininfradev.local"
vcenter_password="123456Bb@"
vcenter_server="10.180.12.151"
vcenter_datacenter="azin-sphere-dc"
vcenter_host="10.180.10.21"
vcenter_datastore="main-datastore"
vcenter_network="VLAN3513"

iso_file="ubuntu-20.04.4-live-server-amd64.iso"
iso_checksum="28ccdb56450e643bad03bb7bcf7507ce3d8d90e8bf09e38f6bd9ac298a98eaad"
vm_guest_os_member = "server-amd64"
vm_guest_os_version = "20-04-lts"
vm_ipv4 = "10.180.12.152"
vm_gateway = "10.180.12.20"
vm_mask_bits = "24"
vm_mask = "255.255.255.0"
nameservers = ["8.8.8.8", "8.8.4.4"]


ssh_username="devops"
ssh_password="Westside592"
vm_password_salt = "qezenfer12345678"
realname = "DevOps unit"
vm_cpu_sockets="4"
vm_cpu_cores="1"
vm_mem_size="8192"
vm_disk_size="51200"
vm_role = "consul"
shell_scripts=["./scripts/ubuntu_clean.sh"]






