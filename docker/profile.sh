


docker exec -it mongo1 mongosh --quiet --eval "db.setProfilingLevel(2);db.system.profile.find().pretty();" 