/*16 bit code*/
.code16

/*偏移*/
.set BaseOff,0x7c00
.set KernelAdd,0x820

/*标识符*/
.set x64,0x00

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
 *获取物理内存信息，为操作系统内存管理做准备
 */
get_momony_txt:
mov $0,%ax
mov $0,%bx
mov $0,%cx
mov $0,%dx
mov %ax,%es
probe_memory:
//对 0x8000 处的 32 位单元清零,即给位于 0x8000 处的
//struct e820map 的结构域 nr_map 清零
movl $0, 0x8000
xorl %ebx, %ebx
//表示设置调用 INT 15h BIOS 中断后,BIOS 返回的映射地址描述符的起始地址
movw $0x8004, %di
start_probe:
movl $0xE820, %eax // INT 15 的中断调用参数
//设置地址范围描述符的大小为 20 字节,其大小等于 struct e820map 的结构域 map 的大
movl $20, %ecx
//设置 edx 为 534D4150h (即 4 个 ASCII 字符“SMAP”),这是一个约定
movl $0x534d4150, %edx
//调用 int 0x15 中断,要求 BIOS 返回一个用地址范围描述符表示的内存段信息
int $0x15
//如果 eflags 的 CF 位为 0,则表示还有内存段需要探测
jnc cont
//探测有问题,结束探测
movw $12345, (0x8000)
jmp finish_probe
cont:
//设置下一个 BIOS 返回的映射地址描述符的起始地址
addw $20, %di
//递增 struct e820map 的结构域 nr_map
incl 0x8000
//如果 INT0x15 返回的 ebx 为零,表示探测结束,否则继续探测
cmpl $0, %ebx
jnz start_probe
finish_probe :

/*
 *保护模式。执行此代码后，无法使用BIOS
 *最后一个跳转代码将跳转到内核状态
 */

protect_mode:
    movw $0,%ax
    movw %ax,%ds
    cli
    lgdt gdt_32
    in $0x92,%al
    or $0x02,%al
    out %al,$0x92
    mov $1,%ax
    lmsw %ax
    ljmp $0x08,$LONG_MODE

.code32
LONG_MODE:
    mov $16,%ax
    mov %ax,%ds
    mov %ax,%es
    mov %ax,%ss

/*
 * 判断是否需要开启64位模式
 */
    mov $0x00,%eax
    cmp $x64,%eax
    jnc Kernel
/*
 * check一下cpuid功能
 */
    mov $0x80000000,%eax
    cpuid
    cmp $0x80000001,%eax
    jc no_long_mode
/*
 * 检查此设备是否支持长模式
 */
    mov $0x80000001,%eax
    cpuid
    bt $29,%edx
    jnc no_long_mode

/*
 * 重新装入64位的gdt表
 * 装入后需要重新设置段
 * 这里段其实和32位没有区别，只是线性地址空间，没有了段长的限制了
 */
    lgdt gdt_64
    mov $16,%ax
    mov %ax,%ds
    mov %ax,%es
    mov %ax,%ss
/*
 * 开启PAE功能，启用物理扩展功能，超越4g空间
 */
    mov %cr4,%eax
    bts $5,%eax
    mov %eax,%cr4

/*
* 64位架构下，处理器需要页表支持，这里生成一份通用页表，放在内存的0x90000位置上
*/
    movl $0x91007   ,(0x90000)
    movl $0x91007   ,(0x90800)
    movl $0x92007   ,(0x91000)
    movl $0x000083  ,(0x92000)
    movl $0x200083  ,(0x92008)
    movl $0x9400083 ,(0x92010)
    movl $0x600083  ,(0x92018)
    movl $0x800083  ,(0x92020)
    movl $0xa00083  ,(0x92028)

/*
 * cr3是保存页表目录地址，将内存地址写入
 */
    mov $0x90000,%eax
    mov %eax,%cr3

/*
 * msr寄存器，修改第8位激活ia-32e模式
 */
    mov $0xc0000080,%ecx
    rdmsr
    bts $8,%eax
    wrmsr

/*
 * 重新开启pg，与分页，彻底进入64位架构
 */
    mov %cr0,%eax
    bts $0,%eax
    bts $32,%eax
    mov %eax,%cr0

/*
 *跳转至内核
 */
Kernel:
    jmp 0x8200

    no_long_mode:
    jmp no_long_mode

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

gdt_64:
.word gdt_end - gdt64 - 1
.long gdt64

gdt64:
.quad 0x0000000000000000
.quad 0x00af9a000000ffff
.quad 0x00cf92000000ffff
gdt_end:


.org 510 /* Skip to address 0x510. */
    .word 0xaa55
