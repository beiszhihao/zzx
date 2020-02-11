#compile
ASSEM:=i386-elf-gcc -c
CC:=i386-elf-gcc

#link
LIN:=i386-elf-ld -s
LINK:=ld.link

#obj
OBJ:=i386-elf-objcopy -R .pdr -R .coment -R .note -S -O binary

#path
OBJ_BIN_PATH:=../../../bin
OBJ_TEMP_PATH:=../../../temp

all: bootloader.bin

bootloader.bin : bootloader.s
	@${ASSEM} bootloader.s -o ${OBJ_TEMP_PATH}/bootloader.o
	@${LIN} ${OBJ_TEMP_PATH}/bootloader.o -o ${OBJ_BIN_PATH}/bootloader.bin -T ${LINK}
	@${OBJ} ${OBJ_BIN_PATH}/bootloader.bin
	@echo compile: boot.asm ok
