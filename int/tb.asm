[BITS 32]

GLOBAL __load_idtr
GLOBAL __io_cli
GLOBAL __io_sti

;void load_idtr(int limit, int addr)
__load_idtr:
 mov ax, [esp+4]
 mov [esp+6], ax
 lidt [esp+6]
 ret

; void io_cli(void);
__io_cli:
        CLI
        RET
; void io_sti(void);
__io_sti:
        STI
        RET
