git clone https://github.com/idealo/mongodb-performance-test.git
jarfile=./mongodb-performance-test/latest-version/mongodb-performance-test.jar
java -jar $jarfile -m insert -o 1000000 -t 10 -db test -c perf > insert.log
java -jar $jarfile -m update_one -d 3600 -t 10 20 30 -db test -c perf >update_one.log
java -jar $jarfile -m update_one iterate_many -d 3600 -t 10 10 20 20 30 30 -db test -c perf > balanced_update.log
java -jar $jarfile -m update_one iterate_many -d 3600 -t 10 20 20 40 30 60 -db test -c perf > unbalanced_update.log
java -jar $jarfile -m update_one iterate_many -url mongodb://host-1:27017,host-2:27017,host-3:27017/?replicaSet=<rsName> -d 3600 -t 10 20 20 40 30 60 -db test -c perf > replicaset.log
