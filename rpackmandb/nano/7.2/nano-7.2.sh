temppath="./nano-7.2"
compressfile="./nano-7.2.tar.xz"

cd /tmp
tar -xf $compressfile
cd $temppath



./configure --prefix=/system/packages/nano     \
            --sysconfdir=/system/packages/nano/etc \
            --enable-utf8     \
            --docdir=/system/packages/nano/share/doc/nano-7.2 &&
make

make install &&
install -v -m644 doc/{nano.html,sample.nanorc} /system/packages/nano/share/doc/nano-7.2
cd ../
rm -rf $temppath
