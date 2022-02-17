#!/bin/bash

# 下载并安装sealos, sealos是个golang的二进制工具，直接下载拷贝到bin目录即可, release页面也可下载
wget -c https://sealyun.oss-cn-beijing.aliyuncs.com/latest/sealos && \
    chmod +x sealos && mv sealos /usr/bin

# 下载离线资源包
# 默认下载位置是/root/kube1.22.0.tar.gz
# 使用vagrant执行的位置是/home/vagrant/kube1.22.0.tar.gz
wget -c https://sealyun.oss-cn-beijing.aliyuncs.com/05a3db657821277f5f3b92d834bbaf98-v1.22.0/kube1.22.0.tar.gz

# 安装一个kubernetes集群

sealos init --passwd 'kubeadmin' \
    --master 192.168.56.100 \
    --node 192.168.56.101 \
    --pkg-url /home/vagrant/kube1.22.0.tar.gz \
    --version v1.22.0