#include "stdder.h"
#include "stdbool.h"
#pragma pack(1)
typedef struct idt_opcode{
    short len;
    unsigned long addr;
}IDT_OPS;
#pragma pack()
/* IDT STRUCT */
struct IDT_STRUCT {
       short offset_low;
       short selector;
       char dw_count;
       char access_right;
       short offset_high;
};

/*IDT ADDR*/
#define IDT_MEMORY_ADDR             0x0026f800
#define IDT_MEMORY_ADDR_LIMIT       0x000007ff

extern bool __idt_init(void);

extern bool __set_idt(int index,int func,int selector,int jur);
extern void __load_idtr(void* gdt);

extern void __open_init();
extern void __close_init();
