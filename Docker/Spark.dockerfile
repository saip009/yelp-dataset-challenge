FROM anapsix/alpine-java:8_jdk
LABEL Maintainer=ldharmap@usc.edu \
    Name=SparkSetup Version=0.0.1
# Install dependencies for downloading packages
RUN apk add tar && apk add gzip && apk add curl
# Install Scala
ARG SCALA_DOWNLOAD_LINK=https://downloads.lightbend.com/scala/2.11.12/scala-2.11.12.tgz
ARG SCALA_DIR=/usr/lib/scala/
RUN mkdir ${SCALA_DIR} && curl ${SCALA_DOWNLOAD_LINK} \
    | tar -xz -C ${SCALA_DIR} --strip-components 1
ENV PATH=$PATH:${SCALA_DIR}/bin
# Install Spark
ARG SPARK_DOWNLOAD_LINK=http://mirror.cc.columbia.edu/pub/software/apache/spark/spark-2.3.1/spark-2.3.1-bin-hadoop2.7.tgz
ARG SPARK_DIR=/usr/lib/spark/
RUN mkdir ${SPARK_DIR} && curl ${SPARK_DOWNLOAD_LINK} \
    | tar -xz -C ${SPARK_DIR} --strip-components 1
ENV PATH=$PATH:${SPARK_DIR}/bin
# Install Anaconda
ARG ANACONDA_DOWNLOAD_LINK=https://repo.anaconda.com/archive/Anaconda3-5.2.0-Linux-x86_64.sh
ARG ANACONDA_DIR=$HOME/anaconda
RUN wget ${ANACONDA_DOWNLOAD_LINK} -O ~/conda.sh \
    && bash ~/conda.sh -f -b -p ${ANACONDA_DIR} \
    && rm ~/conda.sh
ENV PATH=$PATH:${ANACONDA_DIR}/bin
# Setup pyspark to use jupyter
ENV PYSPARK_DRIVER_PYTHON=jupyter
ENV PYSPARK_DRIVER_PYTHON_OPTS='notebook --ip=0.0.0.0 --port=6006 --allow-root'
WORKDIR /yelp
ENTRYPOINT [ "pyspark", "--master", "local[*]" ]
