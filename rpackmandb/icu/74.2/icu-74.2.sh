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


cd ../..
rm -rf $temppath
cd ..


i = $appath

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
                        fi
                fi
                if [[ -d "$i/lib64/pkgconfig" && ! -L "$i/lib64/pkgconfig" ]]; then
                                if [[ "$(/system/packages/coreutils/bin/basename $i)" != "pkgconf" ]]; then
                                                export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$i/lib64/pkgconfig
                                fi
                fi
                if [[ -d "$i/include" && ! -L "$i/include" ]]; then
                                export CPATH=$CPATH:$i/include
                                export C_INCLUDE_PATH=$C_INCLUDE_PATH:$i/include
                fi

        fi
unset i
ldconfig
