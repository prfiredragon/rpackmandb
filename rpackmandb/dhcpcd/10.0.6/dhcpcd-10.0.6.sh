temppath="./dhcpcd-10.0.6"
compressfile="./dhcpcd-10.0.6.tar.xz"
appath="/system/packages/dhcpcd"

cd /tmp
#rm -r $compressfile
#curl -L https://github.com/NetworkConfiguration/dhcpcd/releases/download/v10.0.6/dhcpcd-10.0.6.tar.xz -O
tar -xf $compressfile
cd $temppath



./configure --prefix=$appath                \
            --sysconfdir=/etc            \
            --libexecdir=$appath/lib/dhcpcd \
            --dbdir=/system/os/var/lib/dhcpcd      \
            --runstatedir=/system/os/run           \
            --privsepuser=dhcpcd         &&
make


make install


cd ..
rm -rf $temppath
cd ..
