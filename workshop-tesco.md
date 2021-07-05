

open terminal 

```
git clone https://github.com/nodesense/bigdata-stack


cd bigdata-stack 



sudo rm -rf /data

sudo mkdir /data


sudo chmod 777 /data



docker network ls


docker network create --driver bridge --gateway 172.20.0.1 --subnet 172.20.0.0/24  bigdatanet

docker network inspect bigdatanet


./scripts/init-hue.sh
./scripts/init-superset.sh
```

ensure local spark cluster is terminated 

```

docker-compose up -d
```

Check below in browser..

```
Hadoop namenode: http://localhost:50070
Minio: http://localhost:9000
Presto: http://localhost:8080
Superset: http://localhost:8088
Hue: http://localhost:8888

```



