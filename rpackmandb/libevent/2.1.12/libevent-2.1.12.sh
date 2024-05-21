temppath="./libevent-2.1.12-stable"
compressfile="./libevent-2.1.12-stable.tar.gz"
appath="/system/packages/libevent"

cd /tmp
#rm -r $compressfile
#curl -L https://github.com/libevent/libevent/releases/download/release-2.1.12-stable/libevent-2.1.12-stable.tar.gz -O
tar -xf $compressfile
cd $temppath



sed -i 's/python/&3/' event_rpcgen.py



./configure --prefix=$appath --disable-static &&
make

make install


cd ..
rm -rf $temppath
cd ..
