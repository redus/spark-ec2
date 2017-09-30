#!/bin/bash

/home/ec2-user/spark-ec2/copy-dir /home/ec2-user/tachyon

/home/ec2-user/tachyon/bin/tachyon format

sleep 1

/home/ec2-user/tachyon/bin/tachyon-start.sh all Mount
