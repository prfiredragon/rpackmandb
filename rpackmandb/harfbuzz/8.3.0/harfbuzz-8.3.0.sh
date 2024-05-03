temppath="./harfbuzz-8.3.0"
compressfile="./harfbuzz-8.3.0.tar.xz"
appath="/system/packages/harfbuzz"

cd /tmp
tar -xf $compressfile
cd $temppath



mkdir build &&
cd    build &&

meson setup ..            \
      --prefix=$appath       \
      --buildtype=release \
      -Dgraphite2=disabled &&
ninja

ninja install


cd ../../
rm -rf $temppath
cd ..
