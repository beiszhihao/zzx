/*16 bit code*/
.code16

/*偏移*/
.set BaseOff,0x7c00
.set KernelAdd,0x820

/*code*/
.text
main:

/*设置堆栈*/
    mov $0,%ax
    mov %ax,%ss
    mov $BaseOff,%sp
    mov %ax,%ds

/*读取扇区*/
read_sector:
    mov $0,%ax
    mov %ax,%ss
    mov $BaseOff,%sp
    mov %ax,%ds

/*设置寄存器*/
    mov $KernelAdd,%ax
    mov %ax,%es
    mov $0,%ch
    mov $0,%dh
    mov $3,%cl

/*循环读取扇区*/
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
 *设置文本显示模式。此内核不使用任何图形卡或VBE
 *在进入保护模式之前，您可以使用VBE或其他视频卡驱动程序
 *建议修改此代码
 */

set_txt_mode:
    mov $0x03,%ax
    int $0x10
    mov $0x2,%ah
    xor %dx,%dx
    int $0x10

/*
 *保护模式。执行此代码后，无法使用BIOS
 *最后一个跳转代码将跳转到内核状态
 */

protect_mode:
    cli
    lgdt gdt_32
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

gdt32:
    .word  0,0,0,0 ;/*空描述符，保留*/
    ;/*内核代码段基址0x0000，段限制4G*/
    .word 0xffff
    .word 0x0000
    .word 0x9a00
    .word 0x00cf
    ;/*内核数据段基址0x0000，段限制4G*/
    .word 0xffff
    .word 0x0000
    .word 0x9200
    .word 0x00cf
    ;/*数据段基址0x0，段限制4G*/
    .word 0xffff
    .word 0x0000
    .word 0x9a00
    .word 0x00cf
    ;/*内核代码段基址0x0，段限制4G*/
    .word 0xffff
    .word 0x0000
    .word 0x9200
    .word 0x00cf
gdt_32: ;/*指明GDT的位置和尺寸*/
    .word 0x800 ;/*MAX 0x800*/
    .word gdt32
    .word 0

.org 510 /* Skip to address 0x510. */
    .word 0xaa55
