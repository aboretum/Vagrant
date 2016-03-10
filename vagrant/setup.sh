#!/bin/sh
# I. setup proxy for APT
cd /vagrant
. ./config_import.sh
echo "Acquire::http::Proxy \"$HTTP_PROXY\";" > /etc/apt/apt.conf

# II. Create users, get packages ...
chmod +x /vagrant/setup_root.sh
sudo /vagrant/setup_root.sh

# III. Setup server
chmod +x /vagrant/setup_user.sh
sudo -u vagrant /vagrant/setup_user.sh

echo "    Vagrant virtual machine should be ready for use :)"
echo "    To login to your VM:"
echo "        vagrant ssh"
echo "    Then start the server with the following commands:"
echo "      $ cd bin"
echo "      $ ./realmd &"
echo "      $ ./mangosd"
echo "    Once the server is loaded, create your admin account"
echo "     M> account create LOGIN PASS PASS"
echo "     M> account set gm LOGIN 3"
echo "     M> account set addon LOGIN 1"
echo "    And eventually set your realmlist to"
echo "        set realmlist 127.0.0.1"
