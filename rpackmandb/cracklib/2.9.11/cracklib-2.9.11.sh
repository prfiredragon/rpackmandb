temppath="./cracklib-2.9.11"
compressfile="./cracklib-2.9.11.tar.xz"

cd /tmp
tar -xf $compressfile
cd $temppath

#autoreconf -fiv &&

PYTHON=python3               \
./configure --prefix=/system/packages/cracklib    \
            --disable-static \
            --with-default-dict=/system/packages/cracklib/lib/cracklib/pw_dict &&
make

make install

install -v -m644 -D    ../cracklib-words-2.9.11.xz \
                         /system/packages/cracklib/share/dict/cracklib-words.xz    &&

unxz -v                  /system/packages/cracklib/share/dict/cracklib-words.xz    &&
ln -v -sf cracklib-words /system/packages/cracklib/share/dict/words                &&
echo $(hostname) >>      /system/packages/cracklib/share/dict/cracklib-extra-words &&
install -v -m755 -d      /system/packages/cracklib/lib/cracklib                    &&
source /root/.bash_profile
create-cracklib-dict     /system/packages/cracklib/share/dict/cracklib-words \
                         /system/packages/cracklib/share/dict/cracklib-extra-words

make test


cd ..
rm -rf $temppath
cd ..
