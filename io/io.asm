[BITS 32]
GLOBAL __io_in8
GLOBAL __io_in16
GLOBAL __io_in32
GLOBAL __io_out8
GLOBAL __io_out16
GLOBAL __io_out32

 ; int io_in8(int port);
__io_in8:
MOV        EDX,[ESP+4]        ; port
MOV        EAX,0
IN        AL,DX
RET

 ; int io_in16(int port);
__io_in16:
        MOV        EDX,[ESP+4]        ; port
        MOV        EAX,0
        IN        AX,DX
        RET

; int io_in32(int port);
__io_in32:
        MOV        EDX,[ESP+4]        ; port
        IN        EAX,DX
        RET

; void io_out8(int port, int data);
__io_out8:
        MOV        EDX,[ESP+4]        ; port
        MOV        AL,[ESP+8]        ; data
        OUT        DX,AL
        RET

 ; void io_out16(int port, int data);
__io_out16:
        MOV        EDX,[ESP+4]        ; port
        MOV        EAX,[ESP+8]        ; data
        OUT        DX,AX
        RET

 ; void io_out32(int port, int data);
__io_out32:
        MOV        EDX,[ESP+4]        ; port
        MOV        EAX,[ESP+8]        ; data
        OUT        DX,EAX
        RET
