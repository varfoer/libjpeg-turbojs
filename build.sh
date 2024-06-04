#!/bin/sh
# rm -rf build

cd extern/libjpeg-turbo
mkdir -p build
cd build
emcmake cmake ..
make make -j 16
make install
cd ../../..

mkdir -p build
#(cd build && emconfigure cmake -DCMAKE_BUILD_TYPE=Debug ..) &&
(cd build && emcmake cmake ..) &&
(cd build && make VERBOSE=1 -j 16)
cp ./build/src/libjpegturbowasm.js ./dist && 
cp ./build/src/libjpegturbowasm.wasm ./dist && 
cp ./build/src/libjpegturbojs.js.mem ./dist &&
cp ./build/src/libjpegturbojs.js ./dist &&
(cd test/node; npm --experimental-wasm-simd run test)