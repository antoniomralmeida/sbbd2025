git clone https://github.com/idealo/mongodb-performance-test.git
cp ./mongodb-performance-test/latest-version/mongodb-performance-test.jar test.jar
host1=mongo1:27017
host2=mongo2:27018
host3=mongo3:27019
replicaset=myReplicaSet

jarfile=./mongodb-performance-test/latest-version/mongodb-performance-test.jar
java -jar test.jar -m insert -o 1000000 -t 10 -h $host1 -db test -c perf 
java -jar test.jar -m update_one -d 3600 -t 10 20 30 -h $host1 -db test -c perf 
java -jar test.jar -m update_one iterate_many -d 3600 -t 10 10 20 20 30 30 -h $host1 -db test -c perf 
java -jar test.jar -m update_one iterate_many -d 3600 -t 10 20 20 40 30 60 -h $host1 -db test -c perf 
java -jar test.jar -m update_one iterate_many -url mongodb://$host1,$host2,$host3/?replicaSet=$replicaset -d 3600 -t 10 20 20 40 30 60 -db test -c perf 
