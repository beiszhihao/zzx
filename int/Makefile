
idt:idt.o tb.o
	

idt.o:idt.c idt.h
	@i386-elf-gcc -c idt.c -o ../temp/idt.o -I "../c" -I "../text"
	@echo compile: idt.c ok

tb.o:tb.asm
	@nasm -f elf tb.asm -o ../temp/tb.o
	@echo compile: tb.c ok
	


