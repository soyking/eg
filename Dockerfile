ARG UBUNTU_VERSION=20.04
FROM ubuntu:${UBUNTU_VERSION}
RUN mkdir -p /app/bin
ADD etcd/etcd etcd/etcdctl /app/bin/
ADD Procfile /app
ADD goreman/goreman /app
EXPOSE 12379 22379 32379
WORKDIR /app
HEALTHCHECK --interval=5s --timeout=3s --start-period=10s --retries=5 \
    CMD /app/bin/etcdctl --endpoints=http://127.0.0.1:12379,http://127.0.0.1:22379,http://127.0.0.1:32379 endpoint health
CMD ["/app/goreman", "start"]
