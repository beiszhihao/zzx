[BITS 32]

GLOBAL __pics_out8

;void io_out8(int port, int data);
__pics_out8:
MOV        EDX,[ESP+4]        ; port
MOV        AL,[ESP+8]        ; data
OUT        DX,AL
RET

