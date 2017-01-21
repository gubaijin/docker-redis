FROM centos:7
ADD redis-3.2.6.tar.gz /
RUN mkdir -p /redis
ADD redis.conf /redis/

RUN yum -y update
RUN yum install -y gcc make

WORKDIR /redis-3.2.6
RUN make
RUN mv /redis-3.2.6/src/redis-server /redis/

WORKDIR /
RUN rm -rf /redis-3.2.6

RUN yum remove -y gcc make

VOLUME ["/home/volume/redis"]

EXPOSE 6379