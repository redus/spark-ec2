#!/bin/bash

pushd /home/ec2-user > /dev/null

if [ -d "ephemeral-hdfs" ]; then
  echo "Ephemeral HDFS seems to be installed. Exiting."
  return 0
fi

case "$HADOOP_MAJOR_VERSION" in
  1)
    wget http://s3.amazonaws.com/spark-related-packages/hadoop-1.0.4.tar.gz
    echo "Unpacking Hadoop"
    tar xvzf hadoop-1.0.4.tar.gz > /tmp/spark-ec2_hadoop.log
    rm hadoop-*.tar.gz
    mv hadoop-1.0.4/ ephemeral-hdfs/
    sed -i 's/-jvm server/-server/g' /home/ec2-user/ephemeral-hdfs/bin/hadoop
    cp /home/ec2-user/hadoop-native/* /home/ec2-user/ephemeral-hdfs/lib/native/
    ;;
  2) 
    wget http://s3.amazonaws.com/spark-related-packages/hadoop-2.0.0-cdh4.2.0.tar.gz  
    echo "Unpacking Hadoop"
    tar xvzf hadoop-*.tar.gz > /tmp/spark-ec2_hadoop.log
    rm hadoop-*.tar.gz
    mv hadoop-2.0.0-cdh4.2.0/ ephemeral-hdfs/

    # Have single conf dir
    rm -rf /home/ec2-user/ephemeral-hdfs/etc/hadoop/
    ln -s /home/ec2-user/ephemeral-hdfs/conf /home/ec2-user/ephemeral-hdfs/etc/hadoop
    cp /home/ec2-user/hadoop-native/* /home/ec2-user/ephemeral-hdfs/lib/native/
    ;;
  yarn)
    wget http://s3.amazonaws.com/spark-related-packages/hadoop-2.4.0.tar.gz
    echo "Unpacking Hadoop"
    tar xvzf hadoop-*.tar.gz > /tmp/spark-ec2_hadoop.log
    rm hadoop-*.tar.gz
    mv hadoop-2.4.0/ ephemeral-hdfs/

    # Have single conf dir
    rm -rf /home/ec2-user/ephemeral-hdfs/etc/hadoop/
    ln -s /home/ec2-user/ephemeral-hdfs/conf /home/ec2-user/ephemeral-hdfs/etc/hadoop
    ;;

  *)
     echo "ERROR: Unknown Hadoop version"
     return 1
esac
/home/ec2-user/spark-ec2/copy-dir /home/ec2-user/ephemeral-hdfs

popd > /dev/null
