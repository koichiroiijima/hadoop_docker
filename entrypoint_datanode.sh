#!/bin/bash
set -ex
service ssh start

mkdir -p ${HADOOP_HOME}/logs/

${HADOOP_HOME}/bin/hdfs --daemon start datanode
tail -F $(ls ${HADOOP_HOME}/logs/hadoop-root-datanode-*.log)
