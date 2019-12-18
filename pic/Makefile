
system:_8259a.o _8259asm.o

_8259a.o:8259a.c 8259a.h
	@i386-elf-gcc -c 8259a.c -o ../temp/8259a.o
	@echo compile: 8259a.c ok

_8259asm.o:pics.asm
	@nasm -f elf pics.asm -o ../temp/pics.o
	@echo compile: pics.asm ok
