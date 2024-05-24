temppath="./dbus-1.14.10"
compressfile="./dbus-1.14.10.tar.xz"
appath="/system/packages/dbus"

cd /tmp
#rm -r $compressfile
#curl -L https://dbus.freedesktop.org/releases/dbus/dbus-1.14.10.tar.xz -O
tar -xf $compressfile
cd $temppath


./configure --prefix=$appath                        \
            --sysconfdir=/system/os/etc                    \
            --localstatedir=/system/os/var                 \
            --runstatedir=/system/os/run                   \
            --disable-doxygen-docs               \
            --disable-xml-docs                   \
            --disable-static                     \
            --with-systemduserunitdir=no         \
            --with-systemdsystemunitdir=no       \
            --docdir=$appath/share/doc/dbus-1.14.10  \
            --with-system-socket=/system/os/run/dbus/system_bus_socket &&
make

make install

chown -v root:messagebus $appath/libexec/dbus-daemon-launch-helper &&
chmod -v      4750       $appath/libexec/dbus-daemon-launch-helper

dbus-uuidgen --ensure

ln -sfv /system/os/var/lib/dbus/machine-id /system/os/etc/

cat > /system/os/etc/dbus-1/session-local.conf << "EOF"
<!DOCTYPE busconfig PUBLIC
 "-//freedesktop//DTD D-BUS Bus Configuration 1.0//EN"
 "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
<busconfig>

  <!-- Search for .service files in /usr/local -->
  <servicedir>/system/packages/dbus/local/share/dbus-1/services</servicedir>

</busconfig>
EOF


cd ..
rm -rf $temppath
cd ..
