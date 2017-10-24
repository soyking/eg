FROM ubuntu:17.04
RUN mkdir -p /app/bin
ADD etcd/etcd /app/bin
ADD Procfile /app
ADD goreman/goreman /app
EXPOSE 2379 22379 32379
WORKDIR /app
CMD ["/app/goreman", "start"]
