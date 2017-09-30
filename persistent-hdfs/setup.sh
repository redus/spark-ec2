#!/bin/bash

PERSISTENT_HDFS=/home/ec2-user/persistent-hdfs

pushd /home/ec2-user/spark-ec2/persistent-hdfs > /dev/null
source ./setup-slave.sh

for node in $SLAVES $OTHER_MASTERS; do
  ssh -t $SSH_OPTS ec2-user@$node "/home/ec2-user/spark-ec2/persistent-hdfs/setup-slave.sh" & sleep 0.3
done
wait

/home/ec2-user/spark-ec2/copy-dir $PERSISTENT_HDFS/conf

if [[ ! -e /vol/persistent-hdfs/dfs/name ]] ; then
  echo "Formatting persistent HDFS namenode..."
  $PERSISTENT_HDFS/bin/hadoop namenode -format
fi

echo "Persistent HDFS installed, won't start by default..."

popd > /dev/null
