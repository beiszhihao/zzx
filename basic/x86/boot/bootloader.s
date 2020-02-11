/*16 bit code*/
.code16

/*off*/
.set BaseOff,0x7c00
.set KernelAdd,0x820

/*code*/
.text
main:

/*set stack*/
    mov $0,%ax
    mov %ax,%ss
    mov $BaseOff,%sp
    mov %ax,%ds

/*read sector*/
read_sector:
    mov $0,%ax
    mov %ax,%ss
    mov $BaseOff,%sp
    mov %ax,%ds

/*set register*/
    mov $KernelAdd,%ax
    mov %ax,%es
    mov $0,%ch
    mov $0,%dh
    mov $3,%cl

/*circular read sector*/
set_error:
    mov $0,%si
read:
    mov $0x02,%ah
    mov $1,%al
    mov $0,%bx
    mov $0x00,%dl
    int $0x13
    jnc move
    add $1,%si
    cmp $5,%si
    jae error
    mov $0x00,%ah
    mov $0x00,%dl
    int $0x13
    jmp read
move:
    mov %es,%ax
    add $0x0020,%ax
    mov %ax,%es
    add $1,%cl
    cmp $18,%cl
    jbe set_error
    jmp set_txt_mode
error:
    jmp error

/*
 *Set the text display mode. This kernel does not use any graphics card or VBE
 *You can use VBE or other video card drivers before entering the protected mode
 *It is recommended to modify this code
 */

set_txt_mode:
    mov $0x03,%ax
    int $0x10
    mov $0x2,%ah
    xor %dx,%dx
    int $0x10

/*
 *Protection mode. After this code is executed, BIOS cannot be used
 *The last jump code will jump to kernel state
 */

protect_mode:
    cli
    lgdt gdt_48
    in $0x92,%al
    or $0x02,%al
    out %al,$0x92
    mov $1,%ax
    lmsw %ax
    ljmp $0x08,$PROTECT_BEGIN

.code32
PROTECT_BEGIN:
    mov $16,%ax
    mov %ax,%ds
    mov %ax,%es
    mov %ax,%ss
    jmp 0x8200
gdt:
    .word  0,0,0,0 ;/*Empty descriptor, reserved*/
    ;/*Kernel code segment base address 0x0000, segment limit 4G*/
    .word 0xffff
    .word 0x0000
    .word 0x9a00
    .word 0x00cf
    ;/*Kernel data segment base address 0x0000, segment limit 4G*/
    .word 0xffff
    .word 0x0000
    .word 0x9200
    .word 0x00cf
    ;/*Data segment base address 0x0, segment limit 4G*/
    .word 0xffff
    .word 0x0000
    .word 0x9a00
    .word 0x00cf
    ;/*Kernel code segment base address 0x0, segment limit 4G*/
    .word 0xffff
    .word 0x0000
    .word 0x9200
    .word 0x00cf
gdt_48: ;/*Indicates the location and size of GDT*/
    .word 0x800 ;/*MAX 0x800*/
    .word gdt
    .word 0

.org 510 /* Skip to address 0x510. */
    .word 0xaa55
