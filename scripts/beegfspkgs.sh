#!/bin/bash
#
BEEGFS_VER=713

KERNEL=$(uname -r)
echo "Kernel version is $KERNEL"
#
systemctl stop firewalld
systemctl disable firewalld
#
yum -y install epel-release
yum install -y kernel-devel-${KERNEL} kernel-headers-${KERNEL} kernel-tools-libs-devel-${KERNEL}
yum -y install gcc gcc-c++
yum -y install zlib zlib-devel bzip2 bzip2-devel bzip2-libs openssl openssl-devel openssl-libs nfs-utils rpcbind mdadm wget python-pip automake autoconf
#
if [ ${BEEGFS_VER} -eq 713 ]
then
wget -O /etc/yum.repos.d/beegfs-rhel7.repo https://www.beegfs.io/release/beegfs_7_1.713/dists/beegfs-rhel7.repo
sed -i 's/beegfs_7_1/beegfs_7_1.713/g' /etc/yum.repos.d/beegfs-rhel7.repo
else
wget -O /etc/yum.repos.d/beegfs-rhel7.repo https://www.beegfs.io/release/beegfs_7_1/dists/beegfs-rhel7.repo
fi
rpm --import https://www.beegfs.io/release/latest-stable/gpg/RPM-GPG-KEY-beegfs
#
echo "net.ipv4.neigh.default.gc_thresh1=1100" | tee -a /etc/sysctl.conf
echo "net.ipv4.neigh.default.gc_thresh2=2200" | tee -a /etc/sysctl.conf
echo "net.ipv4.neigh.default.gc_thresh3=4400" | tee -a /etc/sysctl.conf
