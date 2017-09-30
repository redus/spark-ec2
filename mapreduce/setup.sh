#!/bin/bash
MAPREDUCE=/home/ec2-user/mapreduce

mkdir -p /mnt/mapreduce/logs
for node in $SLAVES $OTHER_MASTERS; do
  ssh -t $SSH_OPTS ec2-user@$node "sudo mkdir -p /mnt/mapreduce/logs && chown hadoop:hadoop /mnt/mapreduce/logs && chown hadoop:hadoop /mnt/mapreduce" & sleep 0.3
done
wait

chown hadoop:hadoop /mnt/mapreduce -R
/home/ec2-user/spark-ec2/copy-dir $MAPREDUCE/conf
