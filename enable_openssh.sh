#!/bin/sh

cp -r ./usr/* /usr/

mkdir -p \
/var/run \
/var/empty

# 在开发板 /usr/local/etc/ 目录下生成key文件：

cd /usr/local/etc/
ssh-keygen -t rsa -f ssh_host_rsa_key -N ""
ssh-keygen -t dsa -f ssh_host_dsa_key -N ""
ssh-keygen -t ecdsa -f ssh_host_ecdsa_key -N ""
ssh-keygen -t dsa -f ssh_host_ed25519_key -N ""

# 修改 ssh_host_ed25519_key 权限为 600：
chmod 600 ssh_host_ed25519_key

chmod 700 /usr/local/etc/ssh_host_*

# 其中 ssh_host_ed25519_key 是SSH第二版协议用到的key，需要修改权限，否则会提示以下错误：

cat >> /etc/passwd <<EOF
sshd:x:74:74:Privilege-separated SSH:/var/empty/sshd:/sbin/nologin
EOF

