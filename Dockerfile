FROM redis
COPY redis.conf /path/to/redis.conf
CMD [ "redis-server","/path/to/redis.conf" ]
