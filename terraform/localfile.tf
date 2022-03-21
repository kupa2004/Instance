resource "local_file" "inventory" {
  filename = "${path.module}/../ansible/hosts"
  file_permission  = "0644"

  content = templatefile("${path.module}/inventory.tpl", {
    ip_addrs = google_compute_instance.andrdi-gcp-server[*].network_interface[0].access_config[0].nat_ip
  })

  provisioner "local-exec" {
    command = "ANSIBLE_CONFIG=${path.module}/../ansible/ansible.cfg ansible-playbook ${path.module}/../ansible/build.yml"
  }
}
