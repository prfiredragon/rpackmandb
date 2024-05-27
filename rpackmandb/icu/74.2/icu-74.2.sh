temppath="./icu"
compressfile="./icu4c-74_2-src.tgz"
appath="/system/packages/icu"

cd /tmp
#rm -r $compressfile
#curl -L https://github.com/unicode-org/icu/releases/download/release-74-2/icu4c-74_2-src.tgz -O
tar -xf $compressfile
cd $temppath

cd source                                    &&
./configure --prefix=$appath                    &&
make



make install

ln -s /system/packages/icu/lib/*.so /system/os/lib/
ln -s /system/packages/icu/bin/* /system/os/bin/
ln -s /system/packages/icu/sbin/* /system/os/sbin/

cd ../..
rm -rf $temppath
cd ..
