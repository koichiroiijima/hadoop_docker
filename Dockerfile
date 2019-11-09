FROM koichiroiijima/debian_base:10.1-0.0.2-20191029 

ENV HADOOP_VERSION=3.2.1
ENV HADOOP_HOME=/opt/hadoop/
ENV HADOOP_CONF_DIR=${HADOOP_HOME}/etc/hadoop/
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/
ENV PATH=${JAVA_HOEM}/bin:${PATH}

ENV HDFS_NAMENODE_USER="root"
ENV HDFS_DATANODE_USER="root"
ENV HDFS_SECONDARYNAMENODE_USER="root"
ENV YARN_RESOURCEMANAGER_USER="root"
ENV YARN_NODEMANAGER_USER="root"

RUN set -ex \
  && \
  apt-get update \
  && \
  apt-get install --no-install-recommends -y \
    openssh-server \
    openssh-client \
  && \
  ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa \
  && \
  cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys \
  && \
  chmod 0600 ~/.ssh/authorized_keys \
  && \
  # Bug?
  mkdir -p /usr/share/man/man1 \
  && \
  apt-get install --no-install-recommends -y openjdk-11-jdk \
  && \
  wget https://www-us.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz \
  && \
  tar xzvf hadoop-${HADOOP_VERSION}.tar.gz \
  && \
  mv /opt/hadoop-${HADOOP_VERSION}/ /opt/hadoop/ \
  && \
  wget https://repo1.maven.org/maven2/javax/annotation/javax.annotation-api/1.3.2/javax.annotation-api-1.3.2.jar -P ${HADOOP_HOME}/share/hadoop/comon/lib/ \
  && \
  wget https://repo1.maven.org/maven2/javax/activation/javax.activation-api/1.2.0/javax.activation-api-1.2.0.jar -P ${HADOOP_HOME}/share/hadoop/common/lib/ \
  && \
  ls -al ${HADOOP_HOME}/share/hadoop/common/lib/ \
  && \
  apt-get autoclean \
  && \
  apt-get clean \
  && \
  rm -rf /var/lib/apt/lists/* 

COPY entrypoint_namenode.sh /opt/entrypoint_namenode.sh
COPY entrypoint_datanode.sh /opt/entrypoint_datanode.sh
COPY entrypoint_resourcemanager.sh /opt/entrypoint_resourcemanager.sh
COPY entrypoint_nodemanager.sh /opt/entrypoint_nodemanager.sh
COPY etc/hadoop ${HADOOP_HOME}/etc/hadoop/

CMD ["/usr/sbin/sshd", "-D"]
