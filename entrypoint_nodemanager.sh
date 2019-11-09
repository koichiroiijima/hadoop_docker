#!/bin/bash
set -ex
service ssh start

mkdir -p ${HADOOP_HOME}/logs/

${HADOOP_HOME}/bin/yarn --daemon start nodemanager
tail -F $(ls ${HADOOP_HOME}/logs/hadoop-root-nodemanager*.log)
