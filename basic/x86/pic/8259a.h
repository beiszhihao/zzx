
#define PIC_8259A_PIC0_ICW1        0x0020
#define PIC_8259A_PIC0_OCW2        0x0020
#define PIC_8259A_PIC0_IMR         0x0021
#define PIC_8259A_PIC0_ICW2        0x0021
#define PIC_8259A_PIC0_ICW3        0x0021
#define PIC_8259A_PIC0_ICW4        0x0021
#define PIC_8259A_PIC1_ICW1        0x00a0
#define PIC_8259A_PIC1_OCW2        0x00a0
#define PIC_8259A_PIC1_IMR         0x00a1
#define PIC_8259A_PIC1_ICW2        0x00a1
#define PIC_8259A_PIC1_ICW3        0x00a1
#define PIC_8259A_PIC1_ICW4        0x00a1

extern void __8259a_pic_init();

extern void __open_pic_int(int pic,int off);

/*pics.asm*/
extern void __pics_out8(int port,int data);
