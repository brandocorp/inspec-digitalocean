provider "digitalocean" {}

resource "digitalocean_droplet" "test" {
  image    = "ubuntu-18-04-x64"
  name     = "test-droplet"
  region   = "sfo2"
  size     = "512mb"
  ssh_keys = ["dd:3b:b8:2e:85:04:06:e9:ab:ff:a8:0a:c0:04:6e:d6"]
}

resource "digitalocean_firewall" "test" {
  name = "test-firewall"

  droplet_ids = ["${digitalocean_droplet.test.id}"]

  inbound_rule = [
    {
      protocol         = "tcp"
      port_range       = 22
      source_addresses = ["0.0.0.0/0"]
    },
  ]
}
