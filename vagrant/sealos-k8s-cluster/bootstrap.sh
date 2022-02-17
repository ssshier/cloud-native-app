#!/bin/bash

## !IMPORTANT ##
#
## This script is tested only in the generic/ubuntu2004 Vagrant box
## If you use a different version of Ubuntu or a different Ubuntu Vagrant box test this again
#

echo "[TASK 0] Setting TimeZone"
timedatectl set-timezone Asia/Shanghai

echo "[TASK 1] Setting DNS"
cat >/etc/systemd/resolved.conf <<EOF
[Resolve]
DNS=8.8.8.8
FallbackDNS=223.5.5.5
EOF
systemctl daemon-reload
systemctl restart systemd-resolved.service
mv /etc/resolv.conf /etc/resolv.conf.bak
ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf

echo "[TASK 2] Setting Ubuntu System Mirrors"
cat >/etc/apt/sources.list<<EOF
deb http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse
EOF
apt update -qq >/dev/null 2>&1

echo "[TASK 3] Disable and turn off SWAP"
sed -i '/swap/d' /etc/fstab
swapoff -a

echo "[TASK 4] Stop and Disable firewall"
systemctl disable --now ufw >/dev/null 2>&1

echo "[TASK 5] Enable ssh password authentication"
sed -i 's/^PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config
echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
systemctl reload sshd

echo "[TASK 6] Set root password"
echo -e "kubeadmin\nkubeadmin" | passwd root >/dev/null 2>&1
echo "export TERM=xterm" >> /etc/bash.bashrc

echo "[TASK 7] Update /etc/hosts file"
cat >>/etc/hosts<<EOF
192.168.56.100   kmaster.k8s.com     kmaster
192.168.56.101   kworker1.k8s.com    kworker1
192.168.56.102   kworker2.k8s.com    kworker2
EOF