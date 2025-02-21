# Useful unix command

## file permission
4 = read  
2 = write  
1 = execute  

```shell script
chmod 100 ~/.ssh/authorized_keys
---x------ 1 nicolas.cailleux domain users 1161 21 févr. 08:35 authorized_keys

chmod 200 ~/.ssh/authorized_keys
--w------- 1 nicolas.cailleux domain users 1161 21 févr. 08:35 authorized_keys

chmod 400 ~/.ssh/authorized_keys
-r-------- 1 nicolas.cailleux domain users 1161 21 févr. 08:35 authorized_keys

chmod 600 ~/.ssh/authorized_keys
-rw------- 1 nicolas.cailleux domain users 1161 21 févr. 08:35 authorized_keys

chmod 700 ~/.ssh/authorized_keys
-rwx------ 1 nicolas.cailleux domain users 1161 21 févr. 08:35 authorized_keys
``̀` 

## ajouter utilisateur debian
```shell script
adduser --force-badname nicocaill

adduser nicocaill www-data

groups nicocaill
usermod -g www-data nicocaill
groups nicocaill

usermod -d /home/nicocaill nicocaill
mkdir -p /home/nicocaill/.ssh

touch /home/nicocaill/.ssh/authorized_keys
chmod 700 /home/nicocaill/.ssh
chmod 640 /home/nicocaill/.ssh/authorized_keys
chown -R nicocaill:nicocaill /home/nicocaill/
```

## obtenir le nombre de worker_processes
```shell script
grep -c ^processor /proc/cpuinfo
```

## obtenir le nombre worker_connections
```shell script
ulimit -n
```

## connexion vpn
```shell script
sudo openvpn --config /etc/openvpn/client/client.ovpn
```

## change machine name
```shell script
sudo hostnamectl set-hostname newHostname
```

## kill workbench
```shell script
pkill mysql-workbench
```

## add user to sudo
```shell script
usermod -aG sudo user
```

## docker-compose without sudo
```shell script
sudo groupadd docker
sudo gpasswd -a $USER docker
newgrp docker
```

## rendre executable un sh
```shell script
chmod a+x filename
```

## unattended-upgrades
```shell script
sudo su
unattended-upgrade --debug --dry-run
echo 'Dpkg::Options {"--force-confdef"; "--force-confold";};' >> /etc/apt/apt.conf.d/50unattended-upgrades
apt install unattended-upgrades
```

## docker daemon on reboot
```shell script
sudo systemctl enable docker.service
```

## gitlab 5xx
```shell script
sudo gitlab-ctl stop
sudo systemctl stop gitlab-runsvdir.service
sudo systemctl start gitlab-runsvdir.service
sudo gitlab-ctl restart
```

## up or down AWS develop EC2
```shell script
./scripts/upAndDownAws/init.sh up || down
```

## change AWS EC2 instance type
tag:slug = api prod  
newInstanceType = m5a.2xlarge
```shell script
./scripts/changeInstanceType/init.sh tag:slug newInstanceType
```

## add VPN server
```shell script
sudo apt update
sudo apt upgrade -y
mkdir vpn
cd vpn/
wget https://git.io/vpn -O openvpn-install.sh

# make executable and execut
chmod +x openvpn-install.sh
sudo ./openvpn-install.sh
```

## add ovpn file on client
```shell script
sudo apt update
sudo apt upgrade -y
apt install openvpn -y

# copy file from remote to local
scp remote:~/client-vpn.ovpn ~/

# connect
sudo openvpn client-vpn.ovpn
```
