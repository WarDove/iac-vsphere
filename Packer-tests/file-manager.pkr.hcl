source "null" "encrypted-pass" {
  communicator = "none"
}

build {
  name = "step-1"
  source "source.null.encrypted-pass" {}
  # Provision additional files by using bash commands
  provisioner "shell-local" {
    inline = ["printf '${var.ssh_password}' | openssl passwd -6 -salt '${var.vm_password_salt}' -stdin > /tmp/vm_encrypted_pass"]
  }
}


source "file" "user-data" {
  content = templatefile("${path.root}/templates/user-data.pkrtpl.hcl", local.userdata_template_map)
}

build {
  name = "step-2"
  source "source.file.user-data" {
    target = "${path.root}/content/user-data"
  }
}
