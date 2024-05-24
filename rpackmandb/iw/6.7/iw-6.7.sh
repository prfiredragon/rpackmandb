temppath="./iw-6.7"
compressfile="./iw-6.7.tar.xz"
appath="/system/packages/iw"

cd /tmp
#rm -r $compressfile
#curl -L https://www.kernel.org/pub/software/network/iw/iw-6.7.tar.xz -O
tar -xf $compressfile
cd $temppath

sed -i "/INSTALL.*gz/s/.gz//" Makefile &&
make PREFIX=$appath


make PREFIX=$appath install


cd ..
rm -rf $temppath
cd ..
