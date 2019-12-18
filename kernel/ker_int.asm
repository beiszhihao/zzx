[BITS 32]
GLOBAL asm_int21

EXTERN int21

asm_int21:
PUSH    ES
PUSH    DS
PUSHAD
MOV        EAX,ESP
PUSH       EAX
MOV        AX,SS
MOV        DS,AX
MOV        ES,AX
CALL        int21
mov al,0x20
out 0x20,al
out 0xa0,al
POP        EAX
POPAD
POP        DS
POP        ES
IRETD
