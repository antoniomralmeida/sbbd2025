docker network create mongoCluster
docker pull mongodb/mongodb-community-server:latest
sudo cp hosts /etc/
docker run -d -p 27017:27017 --name mongo1 --network mongoCluster mongodb/mongodb-community-server:latest mongod --replSet myReplicaSet --bind_ip localhost,mongo1
docker run -d -p 27018:27017 --name mongo2 --network mongoCluster mongodb/mongodb-community-server:latest mongod --replSet myReplicaSet --bind_ip localhost,mongo2
docker run -d -p 27019:27017 --name mongo3 --network mongoCluster mongodb/mongodb-community-server:latest mongod --replSet myReplicaSet --bind_ip localhost,mongo3

sleep 5s
docker exec -it mongo1 mongosh --eval "rs.initiate({
 _id: \"myReplicaSet\",
 members: [
   {_id: 0, host: \"mongo1\"},
   {_id: 1, host: \"mongo2\"},
   {_id: 2, host: \"mongo3\"}
 ]
})"

docker exec -it mongo1 mongosh --eval "rs.status()"