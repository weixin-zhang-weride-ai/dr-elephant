FROM centos:7

ENV HADOOP_VERSION	2.7.3
ENV SPARK_VERSION	1.6.2
ENV HADOOP_HOME		/usr/local/hadoop
ENV SPARK_HOME      /opt/spark
ENV PATH		$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH:/activator-dist-1.3.9/bin
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
ENV ELEPHANT_CONF_DIR=/dr-elephant/app-conf
ENV CONTAINER_SETUP_DIR=container-config

RUN yum install -y java-1.8.0-openjdk-devel wget unzip git which zip mariadb

# Activator instalation
RUN wget https://downloads.typesafe.com/typesafe-activator/1.3.9/typesafe-activator-1.3.9.zip
RUN unzip typesafe-activator-1.3.9.zip

# Hadoop Installation
RUN wget http://archive.apache.org/dist/hadoop/core/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz  && tar -zxf /hadoop-$HADOOP_VERSION.tar.gz && \
    rm /hadoop-$HADOOP_VERSION.tar.gz && mv hadoop-$HADOOP_VERSION ${HADOOP_HOME} && mkdir -p ${HADOOP_HOME}/logs 

# # Spark Installation
RUN wget https://d3kbcqa49mib13.cloudfront.net/spark-${SPARK_VERSION}-bin-without-hadoop.tgz && tar -zxvf spark-${SPARK_VERSION}-bin-without-hadoop.tgz && \
    mv spark-${SPARK_VERSION}-bin-without-hadoop ${SPARK_HOME}

# Dr Elephant Instalation
COPY . /dr-elephant-sources/
RUN sed -i "s/hadoop_version=.*/hadoop_version=$HADOOP_VERSION/g" /dr-elephant-sources/compile.conf
RUN sed -i "s/spark_version=.*/spark_version=$SPARK_VERSION/g" /dr-elephant-sources/compile.conf
RUN cat /dr-elephant-sources/compile.conf
RUN cd /dr-elephant-sources && ./compile.sh compile.conf &&  cd dist && unzip dr*.zip  && rm *.zip && mv $PWD/dr*/ /dr-elephant

# POST Installation
RUN sed -i 's#/dev/null#$project_root/logs/out#' /dr-elephant/bin/start.sh && mkdir -p /dr-elephant/app-conf && cp /dr-elephant-sources/app-conf/* /dr-elephant/app-conf

COPY ${CONTAINER_SETUP_DIR}/elephant.conf /dr-elephant/app-conf
COPY ${CONTAINER_SETUP_DIR}/entrypoint.sh /
COPY ${CONTAINER_SETUP_DIR}/start.sh /

VOLUME $HADOOP_HOME/etc/hadoop/

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/start.sh"]

