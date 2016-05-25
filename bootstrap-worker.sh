#!/usr/bin/env bash

MESOS_ZOOKEEPER_CONNECTION_STRING=$1

sudo rpm -Uvh http://repos.mesosphere.com/el/7/noarch/RPMS/mesosphere-el-repo-7-1.noarch.rpm
sudo yum -y install mesos

cat /home/vagrant/sync/conf/hosts | sudo tee -a /etc/hosts
echo $MESOS_ZOOKEEPER_CONNECTION_STRING | sudo tee /etc/mesos/zk
echo "192.168.9.12" | sudo tee /etc/mesos-slave/hostname #TODO

sudo systemctl stop mesos-master.service
sudo systemctl disable mesos-master.service

sudo service mesos-slave restart

