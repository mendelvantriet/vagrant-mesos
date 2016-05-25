#!/usr/bin/env bash

ZOOKEEPER_ID=$1
ZOOKEEPER_QUORUM=$2
MESOS_ZOOKEEPER_CONNECTION_STRING=$3

sudo rpm -Uvh http://repos.mesosphere.com/el/7/noarch/RPMS/mesosphere-el-repo-7-1.noarch.rpm
sudo yum -y install mesos marathon
sudo yum -y install mesosphere-zookeeper

sudo echo $ZOOKEEPER_ID > /etc/zookeeper/conf/myid
sudo mkdir /opt/mesosphere/zookeeper/conf && sudo cp /home/vagrant/sync/conf/zoo.cfg /opt/mesosphere/zookeeper/conf
cat /home/vagrant/sync/conf/hosts | sudo tee -a /etc/hosts

sudo systemctl start zookeeper

echo $MESOS_ZOOKEEPER_CONNECTION_STRING | sudo tee /etc/mesos/zk
echo $ZOOKEEPER_QUORUM | sudo tee /etc/mesos-master/quorum
echo "192.168.9.11" | sudo tee /etc/mesos-master/hostname #TODO

sudo systemctl stop mesos-slave.service
sudo systemctl disable mesos-slave.service

sudo service mesos-master restart
sudo service marathon restart
