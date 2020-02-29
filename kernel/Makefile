
main: main.o

	@i386-elf-objcopy -S -O binary ../temp/main.bin ../bin/main.bin

main.o:main.c
	@i386-elf-gcc -c int.s -o ../bin/int.o
	@echo compile: ker_int.c ok
	@i386-elf-gcc -c main.c -o ../temp/main.o -I "../basic/x86_64/include" -I "../basic/x86_64/int" -I "../c" -I "../basic/x86_64/pic" -I "../basic/x86_64/io" -I "../include"
	@echo compile: main.c ok
	@i386-elf-ld ../temp/main.o ../bin/int.o ../bin/io.o ../temp/idt.o ../temp/8259a.o ../bin/output.bin ../bin/string.bin ../bin/stdlib.bin ../bin/stdio.bin ../bin/memory.bin -o ../temp/main.bin -T kn.ld
