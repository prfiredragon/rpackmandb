temppath="./sudo-1.9.15p5"
compressfile="./sudo-1.9.15p5.tar.gz"
appath="/system/packages/sudo"

cd /tmp
#rm -r $compressfile
#curl -L https://www.sudo.ws/dist/sudo-1.9.15p5.tar.gz
#curl -L https://www.linuxfromscratch.org/patches/blfs/12.1/wpa_supplicant-2.10-security_fix-1.patch -O
tar -xf $compressfile
cd $temppath


./configure --prefix=$appath              \
            --libexecdir=$appath/lib      \
            --with-secure-path         \
            --with-env-editor          \
            --docdir=$appath/share/doc/sudo-1.9.15p5 \
            --with-passprompt="[sudo] password for %p: " &&
make

make install

cat > /system/os/etc/sudoers.d/00-sudo << "EOF"
Defaults secure_path="/system/os/sbin:/system/os/bin"
%wheel ALL=(ALL) ALL
%sudo ALL=(ALL) ALL
EOF


cd ../
rm -rf $temppath

cd ..
