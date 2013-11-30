#!/bin/bash

set -e

# Updating and Upgrading dependencies

echo "apt updating"
sudo apt-get update -yq > /dev/null
sudo apt-get upgrade -yq > /dev/null

sudo apt-get -y -q install linux-headers-$(uname -r) build-essential dkms nfs-common
sudo apt-get update -yq --fix-missing

# Setup sudo to allow no-password sudo for "admin"
sudo cp /etc/sudoers /etc/sudoers.orig
sudo sed -i -e '/Defaults\s\+env_reset/a Defaults\texempt_group=admin' /etc/sudoers
sudo sed -i -e 's/%admin ALL=(ALL) ALL/%admin ALL=NOPASSWD:ALL/g' /etc/sudoers

# Set SSH to 18500
sudo sed -i -e 's/Port 22/Port 18500/' /etc/ssh/sshd_config
sudo sed -i -e 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i -e 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

# iptables
sudo wget -q -N https://raw.github.com/juliangiuca/aws_automation/master/iptables.firewall.rules > /etc/iptables.firewall.rules -P /etc
sudo bash -c 'printf "#!/bin/sh\n/sbin/iptables-restore < /etc/iptables.firewall.rules\n" > /etc/network/if-pre-up.d/firewall'
sudo chmod +x /etc/network/if-pre-up.d/firewall

