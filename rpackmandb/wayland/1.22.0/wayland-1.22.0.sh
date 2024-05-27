temppath="./wayland-1.22.0"
compressfile="./wayland-1.22.0.tar.xz"
appath="/system/packages/wayland"

cd /tmp
#rm -r $compressfile
#curl -L https://gitlab.freedesktop.org/wayland/wayland/-/releases/1.22.0/downloads/wayland-1.22.0.tar.xz -O
tar -xf $compressfile
cd $temppath


mkdir build &&
cd    build &&

meson setup ..            \
      --prefix=$appath       \
      --buildtype=release \
      -Ddocumentation=false &&
ninja

ninja install





cd ../
rm -rf $temppath
cd ..
