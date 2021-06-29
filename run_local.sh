#!/bin/bash
set -e

if [ -f "/dist/dr-elephant-2.1.7/bin/stop.sh" ]; then
  ./dist/dr-elephant-2.1.7/bin/stop.sh
fi

DB_URL="127.0.0.1"
DB_NAME="drelephant"
DB_USER="root"
DB_PASSWORD="123456"
CONTAINER_NAME="drelephant-db"
existing_containers=$(docker ps --filter "name=$CONTAINER_NAME" -q)
echo "Existing container: $existing_containers"
if [ "$existing_containers" != "" ]; then
  echo "Drop a mysql database $existing_containers"
  docker stop "$existing_containers"
  docker rm "$existing_containers"
fi

docker run --name $CONTAINER_NAME -e MYSQL_ROOT_PASSWORD=$DB_PASSWORD -p $DB_URL:3306:3306 -d mysql:5.7
existing_container=$(docker ps --filter "name=$CONTAINER_NAME" -q)
while ! docker exec "$existing_container" mysqladmin --user=$DB_USER --password=$DB_PASSWORD --host $DB_URL ping --silent &> /dev/null ; do
    echo "Waiting for database connection..."
    sleep 2
done

mysql -u root -p123456 -h 127.0.0.1 -e"create database $DB_NAME;"


if [ -f "/usr/local/hadoop" ]; then
  HADOOP_VERSION=2.7.3
  echo "Setting up hadoop version $HADOOP_VERSION"
  wget http://archive.apache.org/dist/hadoop/core/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz
  tar -zxf hadoop-$HADOOP_VERSION.tar.gz
  rm hadoop-$HADOOP_VERSION.tar.gz
  mv hadoop-$HADOOP_VERSION /usr/local/hadoop
fi

export PATH=/usr/local/hadoop/bin:$PATH
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

./compile.sh compile.conf
cd dist/
unzip dr-elephant-2.1.7.zip
cd dr-elephant-2.1.7
./bin/start.sh

