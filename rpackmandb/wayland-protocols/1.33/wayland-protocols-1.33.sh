temppath="./wayland-protocols-1.33"
compressfile="./wayland-protocols-1.33.tar.xz"
appath="/system/packages/wayland-protocols"

cd /tmp
#rm -r $compressfile
#curl -L https://gitlab.freedesktop.org/wayland/wayland-protocols/-/releases/1.33/downloads/wayland-protocols-1.33.tar.xz -O
tar -xf $compressfile
cd $temppath






mkdir build &&
cd    build &&

meson setup ..            \
      --prefix=$appath       \
      --buildtype=release  &&
ninja

ninja install

ln -s /system/packages/wayland-protocols/share/wayland-protocols /system/packages/wayland/share/



cd ../
rm -rf $temppath
cd ..
