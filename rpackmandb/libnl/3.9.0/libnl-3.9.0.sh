temppath="./libnl-3.9.0"
compressfile="./libnl-3.9.0.tar.gz"
appath="/system/packages/libnl"

cd /tmp
#rm -r $compressfile
#curl -L https://github.com/thom311/libnl/releases/download/libnl3_9_0/libnl-3.9.0.tar.gz -O
tar -xf $compressfile
cd $temppath



sed -i 's/python/&3/' event_rpcgen.py




./configure --prefix=$appath     \
            --sysconfdir=/system/os/etc \
            --disable-static  &&
make

make install

ln -s /system/packages/libnl/lib/libnl*.so /system/os/lib/


cd ..
rm -rf $temppath
cd ..
