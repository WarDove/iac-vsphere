##################################################################################
# SOURCE
##################################################################################

source "null" "encrypted-pass" {
  communicator = "none"
}

source "file" "user-data" {
  content = templatefile("${path.root}/templates/user-data.pkrtpl.hcl", local.userdata_template_map)
  target  = "${path.root}/content/user-data"
}

source "file" "routes" {
  content = templatefile("${path.root}/templates/add_routes.pkrtpl.hcl", { route_targets = var.vm_route_targets, route_gw = var.vm_route_gw })
  target  = "${path.root}/content/add_routes.sh"
}

source "file" "meta-data" {
  content = jsonencode(local.metadata_template_map)
  target  = "${path.root}/content/meta-data"
}

##################################################################################
# BUILD
##################################################################################

build {
  name = "step-1"
  source "source.null.encrypted-pass" {}
  # Provision additional files by using bash commands
  provisioner "shell-local" {
    inline = ["printf '${var.ssh_password}' | openssl passwd -6 -salt '${var.vm_password_salt}' -stdin > /tmp/vm_encrypted_pass"]
  }
}

build {
  name    = "step-2"
  sources = ["source.file.user-data", "source.file.meta-data", "source.file.routes"]
}
