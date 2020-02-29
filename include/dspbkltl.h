//Data structure provided by kernel layer to user layer

#ifndef _DSPBKLTL_H
#define _DSPBKLTL_H
#define E820_MAX 32
#define E820_ADDR 0x8000
#define LAYOUT_SIZE 20 //block size == 20
struct memory_layout {
int block_max;
struct {
    int base_addr_low;
    int base_addr_high;
    int length_low;
    int length_high;
    int type;
}__attribute__((packed,aligned(4))) block[E820_MAX];
}__attribute__((packed,aligned(4)));
#endif
