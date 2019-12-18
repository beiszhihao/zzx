#include "idt.h"

bool __idt_init(void){
    
    struct IDT_STRUCT    *idt_addr = (struct IDT_STRUCT    *) IDT_MEMORY_ADDR;
    if(idt_addr == NULL){
        return false;
    }
    
    int i = 0;
    int idt_len = 0;
    idt_len = (IDT_MEMORY_ADDR_LIMIT/sizeof(struct IDT_STRUCT));
    
    for (; i <= idt_len; i++) {
           idt_addr->offset_low   = 0;
           idt_addr->selector     = 0;
           idt_addr->dw_count     = 0;
           idt_addr->access_right = 0;
           idt_addr->offset_high  = 0;
           idt_addr = idt_addr+i;
    }
    
    __load_idtr(IDT_MEMORY_ADDR_LIMIT,IDT_MEMORY_ADDR);
    
   
    return true;
}

bool __set_idt(int index,int func,int selector,int jur){
    
    struct IDT_STRUCT    *idt_addr = (struct IDT_STRUCT    *) IDT_MEMORY_ADDR+index;
    if(idt_addr == NULL){
        return false;
    }
    
    if(idt_addr == NULL){
        return false;
    }
    
    idt_addr->offset_low   = func & 0xffff;
    idt_addr->selector     = selector;
    idt_addr->dw_count     = (jur >> 8) & 0xff;
    idt_addr->access_right = jur & 0xff;
    idt_addr->offset_high  = (func >> 16) & 0xffff;
    
    return true;
}

void __open_init(){
    __io_sti();
}
