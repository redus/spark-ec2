./spark-ec2 -k UP-MDP-1 -i UP-MDP-1.pem -t m4.large -r us-east-1 -z us-east-1a --ebs-vol-size=500 --ebs-vol-num=1 --spark-version=2.0.0 --hadoop-major-version=yarn --no-ganglia launch spark-cluster
