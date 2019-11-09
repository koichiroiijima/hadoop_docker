#!/bin/bash
set -ex

service ssh start

mkdir -p ${HADOOP_HOME}/logs/

${HADOOP_HOME}/bin/hdfs namenode -format hdfsbdl
${HADOOP_HOME}/bin/hdfs --daemon start namenode
tail -F $(ls ${HADOOP_HOME}/logs/hadoop-root-namenode-*.log)
