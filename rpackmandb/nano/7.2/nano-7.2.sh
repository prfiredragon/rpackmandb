./configure --prefix=/system/packages/nano     \
            --sysconfdir=/system/packages/nano/etc \
            --enable-utf8     \
            --docdir=/system/packages/nano/share/doc/nano-7.2 &&
make

make install &&
install -v -m644 doc/{nano.html,sample.nanorc} /system/packages/nano/share/doc/nano-7.2
