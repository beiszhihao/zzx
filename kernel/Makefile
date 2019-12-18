
main: main.o

	@i386-elf-objcopy -S -O binary ../temp/main.bin ../bin/main.bin

main.o:main.c

	@nasm -f elf ker_int.asm -o ../bin/ker_int.o
	@echo compile: ker_int.c ok
	@i386-elf-gcc -c main.c -o ../temp/main.o -I "../text" -I "../int" -I "../c" -I "../pic" -I "../io"
	@echo compile: main.c ok
	@i386-elf-ld ../temp/main.o ../bin/ker_int.o ../bin/io.o ../temp/idt.o ../temp/tb.o ../temp/8259a.o ../temp/pics.o ../bin/output.bin ../bin/string.bin ../bin/stdlib.bin -o ../temp/main.bin -T kn.ld
