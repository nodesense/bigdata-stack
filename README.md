# Big Data Stack

Big data stack running in pseudo-distributed mode with the following components:

 - Hadoop 2.8.5
 - Minio RELEASE.2019-10-12T01-39-57Z
 - Hive 2.3.6
 - Presto 326
 - Superset 0.35.1
 - Hue 4.5.0

For more details see the following [post](https://johs.me/posts/big-data-stack-running-sql-queries/).

## Data Setup 

The data shall be stored in below host path..

```

sudo rm -rf /data

sudo mkdir /data
sudo chmod 777 /data

```

# Network 

To make easy access from host machine while you develop and test code, the network range is pre-defined 
and some IPs are hard binded in the docker compose files..

To ensure create network before running docker compose..

```
docker network ls


docker network create --driver bridge --gateway 172.20.0.1 --subnet 172.20.0.0/24  bigdatanet

docker network inspect bigdatanet


```

DO NOT RUN THIS 

```
docker network rm  bigdatanet
```


# Databases

PGPASSWORD=admin psql -U admin  postgres


then in the sql prompt,

SELECT datname FROM pg_database;

or 

\l



## Quick start

Clone the repository and create `.env` file based on `sample.env` making sure `DATADIR` points to a 
suitable directory (persistent storage for all containers). Bring up the base stack:
```
docker-compose up -d
```
If you also want to start Superset and Hue, then run:
```
docker-compose -f superset/docker-compose.yml up -d
docker-compose -f hue/docker-compose.yml up -d

docker-compose -f spark/docker-compose.yml up -d
```
and initialize:
```

docker-compose -f superset/docker-compose.yml run --rm -e FLASK_APP=superset superset flask fab create-db



./scripts/init-hue.sh
./scripts/init-superset.sh
```
The stack should now be up and running and the following services available:

 - Hadoop namenode: [http://localhost:50070](http://localhost:50070)
 - Minio: [http://localhost:9000](http://localhost:9000)
 - Presto: [http://localhost:8080](http://localhost:8080)
 - Superset: [http://localhost:8088](http://localhost:8088)
 - Hue: [http://localhost:8888](http://localhost:8888)


## Update host mahcine with hard binding ip

on the host node

nano /etc/hosts

```
172.20.0.100 namenode.bigdata.training.sh
172.20.0.101 hive-server.bigdata.training.sh
172.20.0.102 hive-metastore.bigdata.training.sh
172.20.0.105 minio.bigdata.training.sh
172.20.0.111 spark-master.bigdata.training.sh
```


## Contents

The stack uses update/modified Docker images from [Big Data Europe](https://github.com/big-data-europe),
 [shawnzhu](https://github.com/shawnzhu/docker-prestodb), and [Cloudera](https://github.com/cloudera/hue). See
Dockerfiles for details.

All needed images are on Docker Hub, but if you want to build the updated/modified images yourself, just run `build-local.sh`
in the different sub-directories.

Changes compared to original images:

 - Hadoop updated to version 2.8.5
 - Hive update to version 2.3.6
 - S3 support added
 - Presto update to 326
 - Presto JDBC driver added to Hue

The scripts directory contains some helper scripts:

 - `beeline.sh`: Launch Beeline (Hive CLI) in Hive container 
 - `hadoop-client.sh`: Start container with Hadoop utilities (host filesystem mounted as `/host`). Useful for moving files to HDFS.
 - `init-hue.sh`: Create admin home folder in HDFS in order to avoid error in Hue File Browser.
 - `init-superset.sh`: Initialize Superset database and add Presto as data source
 - `presto-cli.sh`: Launch Presto CLI (downloads jar if needed)

