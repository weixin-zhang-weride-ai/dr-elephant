# Dr. Elephant

[![Build Status](https://api.travis-ci.org/linkedin/dr-elephant.svg)](https://travis-ci.org/linkedin/dr-elephant/)
[![Join the chat at https://gitter.im/linkedin/dr-elephant](https://badges.gitter.im/linkedin/dr-elephant.svg)](https://gitter.im/linkedin/dr-elephant?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

<a href=""><img src="images/wiki/dr-elephant-logo-150x150.png" align="left" hspace="10" vspace="6"></a>

**Dr. Elephant** is a performance monitoring and tuning tool for Hadoop and Spark. It automatically gathers all the metrics, runs analysis on them, and presents them in a simple way for easy consumption. Its goal is to improve developer productivity and increase cluster efficiency by making it easier to tune the jobs. It analyzes the Hadoop and Spark jobs using a set of pluggable, configurable, rule-based heuristics that provide insights on how a job performed, and then uses the results to make suggestions about how to tune the job to make it perform more efficiently.

## Quick Start from weixin.zhang@weride.ai
```
docker run -e MYSQL_ROOT_PASSWORD=123456 -p 127.0.0.1:3306:3306 -d mysql:5.7
mysql -u root -p123456 -h 127.0.0.1 -e"create database drelephant;"
./compile.sh
HADOOP_VERSION=2.7.3
wget http://archive.apache.org/dist/hadoop/core/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz
tar -zxf hadoop-$HADOOP_VERSION.tar.gz
rm hadoop-$HADOOP_VERSION.tar.gz
mv hadoop-$HADOOP_VERSION /usr/local/hadoop
export PATH=/usr/local/hadoop/bin:$PATH
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

cd dist/
unzip dr-elephant-2.1.7.zip
cd dr-elephant-2.1.7
./bin/start.sh
```

## Docker container version
[Link](https://github.com/weixin-zhang-weride-ai/dr-elephant-docker)

## Documentation

For more information on Dr. Elephant, check the wiki pages [here](https://github.com/linkedin/dr-elephant/wiki).

For quick setup instructions: [Click here](https://github.com/linkedin/dr-elephant/wiki/Quick-Setup-Instructions-(Must-Read))

Developer guide: [Click here](https://github.com/linkedin/dr-elephant/wiki/Developer-Guide)

Administrator guide: [Click here](https://github.com/linkedin/dr-elephant/wiki/Administrator-Guide)

User guide: [Click here](https://github.com/linkedin/dr-elephant/wiki/User-Guide)

Engineering Blog: [Click here](https://engineering.linkedin.com/blog/2016/04/dr-elephant-open-source-self-serve-performance-tuning-hadoop-spark)

## Mailing-list & Github Issues

~~Google groups mailing list: [Click here](https://groups.google.com/forum/#!forum/dr-elephant-users)~~ (Reached upper limit! please create github issues)

Github issues: [click here](https://github.com/linkedin/dr-elephant/issues)

## Meetings

We have scheduled a weekly Dr. Elephant meeting for the interested developers and users to discuss future plans for Dr. Elephant. Please [click here](https://github.com/linkedin/dr-elephant/issues/209) for details.

## How to Contribute?

Check this [link](https://github.com/linkedin/dr-elephant/wiki/How-to-Contribute%3F).

## License

    Copyright 2016 LinkedIn Corp.

    Licensed under the Apache License, Version 2.0 (the "License"); you may not
    use this file except in compliance with the License. You may obtain a copy of
    the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
    License for the specific language governing permissions and limitations under
    the License.
