#include "8259a.h"
void __8259a_pic_init(){
    
    __open_pic_int(PIC_8259A_PIC0_IMR,  0xff  ); /* disabled all interrupts */
    __open_pic_int(PIC_8259A_PIC1_IMR,  0xff  ); /* disabled all interrupts */

    __open_pic_int(PIC_8259A_PIC0_ICW1, 0x11  ); /* edge trigger mode */
    __open_pic_int(PIC_8259A_PIC0_ICW2, 0x20  ); /* IRQ0-7 are received by INT20-27 */
    __open_pic_int(PIC_8259A_PIC0_ICW3, 1 << 2); /* PIC1 is connected by IRQ2 */
    __open_pic_int(PIC_8259A_PIC0_ICW4, 0x01  ); /* unbuffered mode */

    __open_pic_int(PIC_8259A_PIC1_ICW1, 0x11  ); /* edge trigger mode */
    __open_pic_int(PIC_8259A_PIC1_ICW2, 0x28  ); /* IRQ8-15 are received by INT28-2f */
    __open_pic_int(PIC_8259A_PIC1_ICW3, 2     ); /* PIC1 is connnected by IRQ2 */
    __open_pic_int(PIC_8259A_PIC1_ICW4, 0x01  ); /* unbuffered mode */

    __open_pic_int(PIC_8259A_PIC0_IMR,  0xfb  ); /* 11111011 disable all interrupts except PIC1 */
    __open_pic_int(PIC_8259A_PIC1_IMR,  0xff  ); /* 11111111 disable all interrupts */
}

void __open_pic_int(int pic,int off){
    __pics_out8(pic,off);
}
