LOAD_ADD EQU 0x0820

ORG        0x7c00

;
;2019.12.10
;zzh
;


;
;Read sectors. This code only reads one sector - 512 bytes
;If your kernel is larger than 512 bytes, modify the following code to read more sectors
;Otherwise, code snippet termination will occur
;

set_ds_sp:
MOV        AX,0
MOV        SS,AX
MOV        SP,0x7c00
MOV        DS,AX


; 程序主体

entry:
        MOV        AX,0               ; 初始化寄存器
        MOV        SS,AX
        MOV        SP,0x7c00
        MOV        DS,AX

; 新加了一部分读盘

        MOV        AX,LOAD_ADD
        MOV        ES,AX
        MOV        CH,0               ; 柱面0
        MOV        DH,0               ; 磁头0
        MOV        CL,3               ; 扇区2
        
        
readloop:
        MOV        SI,0               ; 记录失败次数的计数器
retry:
        MOV        AH,0x02            ; AH=0x02 : 读入磁盘
        MOV        AL,1               ; 1个扇区
        MOV        BX,0
        MOV        DL,0x00            ; A驱动器
        INT        0x13               ; 调用磁盘BIOS
        JNC        next               ; 没出错时跳转到next
        ADD        SI,1               ; 往SI加1
        CMP        SI,5               ; 比较SI和5
        JAE        error              ; SI >= 5时, 跳转到error
        MOV        AH,0x00
        MOV        DL,0x00            ; A驱动器
        INT        0x13               ; 重置驱动器
        JMP        retry
next:
        MOV        AX,ES              ; 把内存地址往后移0x200=512字节
        ADD        AX,0x0020
        MOV        ES,AX              ; 因为没有ADD ES, 0x20指令, 所以这里稍微绕个弯
        ADD        CL,1               ; 往CL里加1
        CMP        CL,18              ; CL和18比较
        JBE        readloop           ; CL <= 18 则跳转到readloop
        
jmp set_txt_mode

fin:
        HLT                           ; 让CPU停止等待指令
        JMP        fin                ; 无限循环
        
error:
        jmp $

;
;Set the text display mode. This kernel does not use any graphics card or VBE
;You can use VBE or other video card drivers before entering the protected mode
;It is recommended to modify this code
;

set_txt_mode:
mov ax,3h
int 10h
mov ah,2h
xor dx,dx
int 10h

;
;Protection mode. After this code is executed, BIOS cannot be used
;The last jump code will jump to kernel state
;

protect_mode:
cli
mov ax,gdt
mov word [gdt_fake],ax
mov bx,gdt_48
lgdt [bx]
in al , 0x92
or al , 0000_0010B
out 0x92,al
mov ax,1
lmsw ax
jmp dword 0x0008:PROTECT_BEGIN
[bits 32]
PROTECT_BEGIN:
mov ax , 16
mov ds , ax
mov es,ax
mov ss,ax
JMP        0x8200
gdt:
    dw  0,0,0,0 ;/*Empty descriptor, reserved*/
    ;/*Kernel code segment base address 0x0000, segment limit 4G*/
    dw 0xffff
    dw 0x0000
    dw 0x9a00
    dw 0x00cf
    ;/*Kernel data segment base address 0x0000, segment limit 4G*/
    dw 0xffff
    dw 0x0000
    dw 0x9200
    dw 0x00cf
    ;/*Data segment base address 0x0, segment limit 4G*/
    dw 0xffff
    dw 0x0000
    dw 0x9a00
    dw 0x00cf
    ;/*Kernel code segment base address 0x0, segment limit 4G*/
    dw 0xffff
    dw 0x0000
    dw 0x9200
    dw 0x00cf
gdt_48: ;/*Indicates the location and size of GDT*/
    dw 0x800 ;/*MAX 0x800*/
gdt_fake:
    dw 0   ;/*32-bit base address, split into 2 words here*/
    dw 0x0

;end 512--
times 510 - ($ - $$) db 0    
dw 0aa55h                   
