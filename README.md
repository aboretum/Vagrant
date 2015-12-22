# NostalriusTBC - Vagrant config and provisioning
This repository is part of the NostalriusTBC project.
https://github.com/NostalriusTBC/


## How to
### 1. Requirements
Download vagrant (https://www.vagrantup.com/) and VirtualBox (https://www.virtualbox.org/).

### 2. Provisioning
Run the following command to create and configure a virtual machine within VirtualBox.

MySQL, emulator, script and database will be automatically build and set up.


```
vagrant up
```

### 3. Data files (DBCs, maps, vmaps, mmaps ...)
You need to create a new directory ``vagrant/data`` and copy all your data files inside.
You should have the following directories created:

```
vagrant/data/dbc
vagrant/data/maps
vagrant/data/vmaps
vagrant/data/mmaps
```

### 4. Start your server
Congratulations ! Your Virtual Machine is ready. Run these commands to start the authentification and world servers.

```
vagrant ssh
cd bin
./realmd &
./mangosd
```

If you are starting MaNGOS for the first time, you need to create your game account with the following MaNGOS commands:

```
account create LOGIN PASSWORD PASSWORD
account set gm LOGIN 3
account set addon LOGIN 1
```

### 5. Login
You only need to set your WoW realmlist to


```
set realmlist 127.0.0.1
```

## Uninstall
If you want to uninstall your vagrant:


```
vagrant destroy
```