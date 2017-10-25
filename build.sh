etcd_version="3.2.7"
goreman_version="0.0.10"

etcd_dir="etcd"
goreman_dir="goreman"

if [ "$1" = "--force" ]; then
	rm -rf $etcd_dir
	rm -rf $goreman_dir
fi

if [ ! -f $etcd_dir"/etcd" ]; then
	mkdir $etcd_dir
	wget "https://github.com/coreos/etcd/releases/download/v"$etcd_version"/etcd-v"$etcd_version"-linux-amd64.tar.gz" -O $etcd_dir/etcd.tar.gz
	tar xvf $etcd_dir/etcd.tar.gz -C etcd --strip-components=1
fi

if [ ! -f $goreman_dir"/goreman" ]; then
	mkdir $goreman_dir
	wget "https://github.com/mattn/goreman/releases/download/v"$goreman_version"/goreman_linux_amd64.zip" -O $goreman_dir/goreman.zip
	unzip $goreman_dir/goreman.zip -d goreman
fi

docker build -t "etcd-goreman:"$etcd_version .
