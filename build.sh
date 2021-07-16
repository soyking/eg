#!/bin/bash -ex

source config.var

etcd_dir="etcd"
goreman_dir="goreman"

if [ "$1" = "--force" ]; then
	rm -rf $etcd_dir
	rm -rf $goreman_dir
fi

if [ ! -f $etcd_dir"/etcd" ]; then
	mkdir $etcd_dir
	wget "https://github.com/etcd-io/etcd/releases/download/"$etcd_version"/etcd-"$etcd_version"-linux-amd64.tar.gz" -O $etcd_dir/etcd.tar.gz
	tar xvf $etcd_dir/etcd.tar.gz -C $etcd_dir --strip-components=1
fi

if [ ! -f $goreman_dir"/goreman" ]; then
	mkdir $goreman_dir
	wget "https://github.com/mattn/goreman/releases/download/"$goreman_version"/goreman_"$goreman_version"_linux_amd64.tar.gz" -O $goreman_dir/goreman.zip
	tar xvf $goreman_dir/goreman.zip -C $goreman_dir --strip-components=1
fi

docker build --build-arg UBUNTU_VERSION=$ubuntu_version \
	--label ubuntu=$ubuntu_version \
	--label etcd=$etcd_version \
	--label goreman=$goreman_version \
	-t $docker_tag .
