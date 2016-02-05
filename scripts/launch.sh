#!/bin/bash

cd /code/BIDMach_Spark/scripts

# launch a cluster
python bidmach_ec2.py -k "dss2_rsa" -i ~/.ssh/dss2_rsa -a "ami-a6dc3bc6" -s 2 --instance-type=g2.2xlarge --region=us-west-2 launch bidcluster4

# login to the master
python bidmach_ec2.py -k "dss2_rsa" -i ~/.ssh/dss2_rsa --region=us-west-2 login bidcluster4

# start/stop the cluster
python bidmach_ec2.py -k "dss2_rsa" -i ~/.ssh/dss2_rsa --region=us-west-2 start bidcluster3

python bidmach_ec2.py -k "dss2_rsa" -i ~/.ssh/dss2_rsa --region=us-west-2 stop bidcluster4

export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=

# need more driver memory for several models, e.g. multiclass and word2vec
spark/bin/spark-shell 
spark/bin/spark-shell --driver-memory 16g --conf "spark.driver.maxResultSize=8g"


echo "y" | python bidmach_ec2.py -k "dss2_rsa" -i ~/.ssh/dss2_rsa --region=us-west-2 destroy bidcluster4


