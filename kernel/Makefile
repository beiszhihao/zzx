main.bin : main.o
	objcopy -S -O binary ../temp/main.o ../bin/main.bin
main.o : main.c
	gcc -Wall main.c -o ../temp/main.o
