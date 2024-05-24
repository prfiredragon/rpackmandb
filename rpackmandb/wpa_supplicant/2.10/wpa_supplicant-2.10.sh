temppath="./wpa_supplicant-2.10"
compressfile="./wpa_supplicant-2.10.tar.gz"
appath="/system/packages/wpa_supplicant"

cd /tmp
#rm -r $compressfile
#curl -L https://w1.fi/releases/wpa_supplicant-2.10.tar.gz -O
curl -L https://www.linuxfromscratch.org/patches/blfs/12.1/wpa_supplicant-2.10-security_fix-1.patch -O
tar -xf $compressfile
cd $temppath



cat > wpa_supplicant/.config << "EOF"
CONFIG_BACKEND=file
CONFIG_CTRL_IFACE=y
CONFIG_DEBUG_FILE=y
CONFIG_DEBUG_SYSLOG=y
CONFIG_DEBUG_SYSLOG_FACILITY=LOG_DAEMON
CONFIG_DRIVER_NL80211=y
CONFIG_DRIVER_WEXT=y
CONFIG_DRIVER_WIRED=y
CONFIG_EAP_GTC=y
CONFIG_EAP_LEAP=y
CONFIG_EAP_MD5=y
CONFIG_EAP_MSCHAPV2=y
CONFIG_EAP_OTP=y
CONFIG_EAP_PEAP=y
CONFIG_EAP_TLS=y
CONFIG_EAP_TTLS=y
CONFIG_IEEE8021X_EAPOL=y
CONFIG_IPV6=y
CONFIG_LIBNL32=y
CONFIG_PEERKEY=y
CONFIG_PKCS12=y
CONFIG_READLINE=y
CONFIG_SMARTCARD=y
CONFIG_WPS=y
CFLAGS += -I/usr/include/libnl3
EOF

cat >> wpa_supplicant/.config << "EOF"
CONFIG_CTRL_IFACE_DBUS=y
CONFIG_CTRL_IFACE_DBUS_NEW=y
CONFIG_CTRL_IFACE_DBUS_INTRO=y
EOF

patch -Np1 -i ../wpa_supplicant-2.10-security_fix-1.patch


cd wpa_supplicant &&
make BINDIR=$appath/sbin LIBDIR=$appath/lib INCDIR=$appath/include

mkdir -pv /system/packages/wpa_supplicant/sbin/

install -v -m755 wpa_{cli,passphrase,supplicant} $appath/sbin/ &&
install -v -m644 doc/docbook/wpa_supplicant.conf.5 $appath/share/man/man5/ &&
install -v -m644 doc/docbook/wpa_{cli,passphrase,supplicant}.8 $appath/share/man/man8/

install -v -m644 dbus/fi.w1.wpa_supplicant1.service \
                 /system/packages/dbus/share/dbus-1/system-services/ &&
install -v -d -m755 /system/os/etc/dbus-1/system.d &&
install -v -m644 dbus/dbus-wpa_supplicant.conf \
                 /system/os/etc/dbus-1/system.d/wpa_supplicant.conf


cd ..
rm -rf $temppath
cd ..
