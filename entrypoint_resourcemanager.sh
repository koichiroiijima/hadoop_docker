#!/bin/bash
set -ex

service ssh start

mkdir -p ${HADOOP_HOEM}/logs/

${HADOOP_HOME}/bin/yarn --daemon start resourcemanager
tail -F $(ls ${HADOOP_HOME}/logs/hadoop-root-resource*.log)
