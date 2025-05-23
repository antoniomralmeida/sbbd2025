wget https://github.com/brianfrankcooper/YCSB/releases/download/0.15.0/ycsb-mongodb-binding-0.15.0.tar.gz
tar xvf ycsb-mongodb-binding-0.15.0.tar.gz
rm ycsb-mongodb-binding-0.15.0.tar.gz
cd ycsb-mongodb-binding-0.15.0
#docker exec -it mongo1 mongosh --eval "rs.status()"


host1=mongo1:27017
host2=mongo2:27018
host3=mongo3:27019
replicaset=myReplicaSet
primary=$host1

docker exec -it mongo1 mongosh ycsb --eval "db.dropDatabase()"

docker exec -it mongo1 mongosh ycsb --eval "db.setProfilingLevel(2)"


##./bin/ycsb load mongodb -s -P workloads/workloada -p recordcount=500000 -threads 16 -p mongodb.url="mongodb://$host1,$host2,$host3/?replicaSet=$replicaset"
./bin/ycsb load mongodb -s -P workloads/workloada -p recordcount=500000 -threads 16 -p mongodb.url="mongodb://$primary" >ycsb.log

docker exec -it mongo1 mongoexport --uri="mongodb://mongo1:27017" --db=ycsb --collection=system.profile --out=profile.json

mongodb-cli/bin/mongoexport --uri="mongodb://mongo1:27017" --db=ycsb --collection=system.profile --out=profile.json

cd ..
