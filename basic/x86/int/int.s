/*16 bit code*/
.code32

/*int func*/
/*key*/
.global _int_key_21
.extern _int_kernel_key_21

/*code*/
.text
_int_key_21:
    push %es
    push %ds
    pusha
    mov %esp,%eax
    push %eax
    mov %ss,%ax
    mov %ax,%ds
    mov %ax,%es
    call _int_kernel_key_21
    mov $0x20,%al
    out %al,$0x20
    out %al,$0xa0
    pop %eax
    popa
    pop %ds
    pop %es
    iret
