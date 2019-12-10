ORG        0x8200

[bits 32]
PROTECT_BEGIN:

;设置背景颜色
mov ecx,2000
mov ebx,0xb8000
loop2:
mov ah,020h
mov al,000h
mov [ds:ebx],ax
inc ebx
inc ebx
loop loop2

;打印输出
push data
push len
push 002fh
push 0000h
call __print_s
add esp,16;清理栈
jmp $


data:
    ;
    db 'this is written in "NASM" assembly language.\\' 
    db 'if you see this message.it means that you have entered kernel state.\\'
    db 'You can use other languages to build your framework.\\'
    db 'The current display is in text mode and can only display 256 characters at most\\'
    db 'Please note that a sector is read-only. If you want to load a larger kernel.\\please modify the boot'

len: equ $- data
%include "../lib/print_s.asm"

main:

