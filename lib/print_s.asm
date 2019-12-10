[BITS 32] 
[SECTION .text]
;__print_s(char* str,int len,int color,int dev)
__print_s:
;ini
mov ebx,0xb8000
mov eax,[esp+4];add
add ebx,eax
mov dx,[esp+8];color
mov ecx,[esp+12];len
mov edi,[esp+16];str
loop1:
    mov ah,dl
    mov al,[ds:edi]
    cmp al,'\'
    jne input
    inc edi
    mov al,[ds:edi]
    cmp al,'\'
    je hef
    dec edi
    mov al,[ds:edi]
    jmp input
hef:
    add ebx,160
    sub ebx,dword[_temp]
    mov dword[_temp],0
    inc edi
    sub ecx,2
    jmp loop1
input:
    mov [ds:ebx],ax
    inc ebx
    inc ebx
    inc edi
    inc dword[_temp]
    inc dword[_temp]
loop loop1
ret
[SECTION .data]
_temp db 0