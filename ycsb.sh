wget https://github.com/brianfrankcooper/YCSB/releases/download/0.15.0/ycsb-mongodb-binding-0.15.0.tar.gz
tar xvf ycsb-mongodb-binding-0.15.0.tar.gz
rm ycsb-mongodb-binding-0.15.0.tar.gz
cd ycsb-mongodb-binding-0.15.0
host1=mongo1:27017
host2=mongo2:27018
host3=mongo3:27019
replicaset=myReplicaSet
primary=$host3
./bin/ycsb load mongodb -s -P workloads/workloada -p recordcount=500000 -threads 16 -p mongodb.url="mongodb://$host1,$host2,$host3/?replicaSet=$replicaset"
cd ..
