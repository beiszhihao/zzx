
cd hand
make

cd ..
cd lib
make

cd ..
cd kernel
make

cd ..
cd test
make

cd ..
dd if=/dev/zero of=./temp/_temp.img bs=512 count=2880
dd if=./bin/boot.bin of=./image/zzxOS.img bs=512 count=1 conv=notrunc
dd if=./temp/_temp.img of=./image/zzxOS.img skip=1 seek=1 bs=512 count=2879
dd if=./bin/main_t.bin of=./image/zzxOS.img bs=512 seek=2 conv=notrunc

echo "comple ok"