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

export i=$appath

        if [[ -d "$i" && ! -L "$i" ]]; then
                if [[ -d "$i/bin" && ! -L "$i/bin" ]]; then
                                export PATH=$PATH:$i/bin
                                ln -s $i/bin/* /system/os/bin/
                fi
                if [[ -d "$i/sbin" && ! -L "$i/sbin" ]]; then
                                export PATH=$PATH:$i/sbin
                                ln -s $i/sbin/* /system/os/sbin/
                fi
                if [[ -d "$i/lib" && ! -L "$i/lib" ]]; then
                                export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$i/lib
                                export LD_RUN_PATH=$LD_RUN_PATH:$i/lib
                                echo "$i/lib" > /system/os/etc/ld.so.conf.d/$(/system/packages/coreutils/bin/basename $i).conf
				ln -s $i/lib/*.so /system/os/lib/
                fi
                if [[ -d "$i/lib64" && ! -L "$i/lib64" ]]; then
                                export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$i/lib64
                                export LD_RUN_PATH=$LD_RUN_PATH:$i/lib64
                                echo "$i/lib64" > /system/os/etc/ld.so.conf.d/$(/system/packages/coreutils/bin/basename $i).conf
				ln -s $i/lib64/*.so /system/os/lib64/
                fi
                if [[ -d "$i/lib/pkgconfig" && ! -L "$i/lib/pkgconfig" ]]; then

                        if [[ "$(/system/packages/coreutils/bin/basename $i)" != "pkgconf" ]]; then
                                export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$i/lib/pkgconfig
				ln -s $i/lib/pkgconfig/* /system/packages/pkgconf/lib/pkgconfig/
                        fi
                fi
                if [[ -d "$i/lib64/pkgconfig" && ! -L "$i/lib64/pkgconfig" ]]; then
                                if [[ "$(/system/packages/coreutils/bin/basename $i)" != "pkgconf" ]]; then
                                                export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$i/lib64/pkgconfig
						ln -s $i/lib64/pkgconfig/* /system/packages/pkgconf/lib/pkgconfig/
                                fi
                fi
                if [[ -d "$i/include" && ! -L "$i/include" ]]; then
                                export CPATH=$CPATH:$i/include
                                export C_INCLUDE_PATH=$C_INCLUDE_PATH:$i/include
                fi

        fi
unset i
ldconfig
