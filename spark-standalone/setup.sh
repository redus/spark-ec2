#!/bin/bash

BIN_FOLDER="/home/ec2-user/spark/sbin"

if [[ "0.7.3 0.8.0 0.8.1" =~ $SPARK_VERSION ]]; then
  BIN_FOLDER="/home/ec2-user/spark/bin"
fi

# Copy the slaves to spark conf
cp /home/ec2-user/spark-ec2/slaves /home/ec2-user/spark/conf/
/home/ec2-user/spark-ec2/copy-dir /home/ec2-user/spark/conf

# Set cluster-url to standalone master
echo "spark://""`cat /home/ec2-user/spark-ec2/masters`"":7077" > /home/ec2-user/spark-ec2/cluster-url
/home/ec2-user/spark-ec2/copy-dir /home/ec2-user/spark-ec2

# The Spark master seems to take time to start and workers crash if
# they start before the master. So start the master first, sleep and then start
# workers.

# Stop anything that is running
$BIN_FOLDER/stop-all.sh

sleep 2

# Start Master
$BIN_FOLDER/start-master.sh

# Pause
sleep 20

# Start Workers
$BIN_FOLDER/start-slaves.sh
