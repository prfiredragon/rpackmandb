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

cat > /system/os/etc/resolv.conf.head << "EOF"
# OpenDNS servers
nameserver 8.8.8.8
nameserver 8.8.4.4
nameserver 208.67.222.222
nameserver 208.67.220.220
EOF

cat > /system/os/etc/resolv.conf << "EOF"
# OpenDNS servers
nameserver 8.8.8.8
nameserver 8.8.4.4
nameserver 208.67.222.222
nameserver 208.67.220.220
EOF

cd ..
rm -rf $temppath
cd ..
