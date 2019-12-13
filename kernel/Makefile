
OS := macos

main: main.o

ifeq ($(OS), debian)
	@objcopy -S -O binary ../temp/main.bin ../bin/main.bin
	@echo debian comple ok
else ifeq ($(OS), macos)
	@i386-elf-objcopy -S -O binary ../temp/main.bin ../bin/main.bin
	@echo macos comple ok
endif
main.o:main.c
ifeq ($(OS), debian)
	@echo debian path comple make
	@gcc -Wall main.c -o ../temp/main.o
else ifeq ($(OS), macos)
	@echo macos path comple make
	@i386-elf-gcc -c main.c -o ../temp/main.o -I "../text" -I "../sd" -I "../c"
	@i386-elf-ld ../temp/main.o ../bin/output.bin ../bin/string.bin ../bin/stdlib.bin -o ../temp/main.bin -T kn.ld
endif
