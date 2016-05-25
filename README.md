# vagrant-mesos

A Mesos cluster. Tested with 2 nodes on VirtualBox.

## Initialize

	cp conf/zoo.cfg.sample conf/zoo.cfg
	cp conf/hosts.sample conf/hosts

## Run

	vagrant up

## Test

	MASTER=$(mesos-resolve `cat /etc/mesos/zk`)
	mesos-execute --master=$MASTER --name="cluster-test" --command="sleep 5"

## More information

- https://open.mesosphere.com/getting-started/install/

