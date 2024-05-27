temppath="./libxml2-2.12.5"
compressfile="./libxml2-2.12.5.tar.xz"
appath="/system/packages/libxml2"

cd /tmp
#rm -r $compressfile
#curl -L https://download.gnome.org/sources/libxml2/2.12/libxml2-2.12.5.tar.xz -O
tar -xf $compressfile
cd $temppath


./configure --prefix=$appath           \
            --sysconfdir=/system/os/etc       \
            --disable-static        \
            --with-history          \
            --with-icu              \
            PYTHON=/system/packages/python/bin/python3 \
            --docdir=$appath/share/doc/libxml2-2.12.5 &&
make

make install

rm -vf $appath/lib/libxml2.la &&
sed '/libs=/s/xml2.*/xml2"/' -i $appath/bin/xml2-config


cd ../
rm -rf $temppath
cd ..
