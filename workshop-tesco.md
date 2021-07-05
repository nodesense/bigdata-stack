

open terminal 

```
cd ~ 

rm -rf ~/bigdata

mkdir ~/bigdata

chmod 777 ~/bigdata

```

open terminal

```
git clone https://github.com/nodesense/bigdata-stack


cd bigdata-stack 





docker network ls


docker network create --driver bridge --gateway 172.20.0.1 --subnet 172.20.0.0/24  bigdatanet

docker network inspect bigdatanet



cp sample.env .env


pwd 

/Users/krish/bigdata-stack

open .env file  in the editor, change DATADIR, beware of the username

open .env


DATADIR=/Users/krish/bigdata

save the file..


docker-compose up  


open new terminal, 


cd ~/bigdata-stack 
 

./scripts/init-hue.sh
./scripts/init-superset.sh
```

ensure local spark cluster is terminated 

```


```

Check below in browser..

```
Hadoop namenode: http://localhost:50070
Minio: http://localhost:9000
Presto: http://localhost:8080
Superset: http://localhost:8088
Hue: http://localhost:8888

```



