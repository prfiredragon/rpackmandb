temppath="./freetype-2.13.2"
compressfile="./freetype-2.13.2.tar.xz"
appath="/system/packages/freetype"

cd /tmp
rm -r $compressfile
curl -L https://downloads.sourceforge.net/freetype/freetype-2.13.2.tar.xz -O
tar -xf $compressfile
cd $temppath



sed -ri "s:.*(AUX_MODULES.*valid):\1:" modules.cfg &&

sed -r "s:.*(#.*SUBPIXEL_RENDERING) .*:\1:" \
    -i include/freetype/config/ftoption.h  &&

./configure --prefix=$appath --enable-freetype-config --disable-static &&
make

make install


cd ..
rm -rf $temppath
cd ..
