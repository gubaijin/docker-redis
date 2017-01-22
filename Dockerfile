FROM centos:7
ENV LANG en_US.UTF-8
COPY redis-3.2.3.tar.gz /root/
COPY redis-3.3.1.gem /root/
COPY create_cluster.sh /
RUN yum install -y tar make gcc net-tools gcc-c++
RUN cd /root/ && \
    yum -y install ruby rubygems && \
    tar zxf redis-3.2.3.tar.gz -C /opt/ && \
    cd /opt/redis-3.2.3 && \
    make MALLOC=libc && \
    make install && \
    cp src/redis-trib.rb /usr/local/bin/ && \
    mkdir /etc/redis && \
    mkdir -p /data/redis 
RUN gem sources -r https://rubygems.org/ && \
    gem sources -a https://ruby.taobao.org/ && \
    gem install -l /root/redis-3.3.1.gem && \
    rm -rf /root/redis*
COPY redis.conf /etc/redis
CMD redis-server /etc/redis/redis.conf && tail -f /data/redis/redis.log
