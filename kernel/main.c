/*
 * int  kerner
 * zzh
 * 2019.12.18
 * 2.33
 *
 */
#include "output.h"
#include "string.h"
#include "stdlib.h"
#include "idt.h"
#include "8259a.h"
#include "io.h"

extern void asm_int21(void);
extern void int21(int *esp);

int main(){
    /*init idt*/
    __idt_init();
    /*set idt index*/
    __set_idt(0x21,(int)asm_int21,8,0x008e);
    /*open init*/
    __open_init();
    /*初始化8529a电路*/
    __8259a_pic_init();
    /*开启8529a上键盘中断电路，否则idt无法响应cpu内部中断*/
    __open_pic_int(0x21,0xf9);
    __open_pic_int(0xa1,0xef);
    
    /*用户部分*/
    __print("hello word! zzxOS.\n");
    __print("$:");

    for(;;){
    }
   
}

/*处理键盘部分*/
void int21(int *esp){
    unsigned char data[28][2] = {
       0x1e,'a',
       0x30,'b',
       0x2e,'c',
       0x20,'d',
       0x12,'e',
       0x21,'f',
       0x22,'g',
       0x18,'o',
       0x19,'p',
       0x17,'i',
       0x15,'y',
       0x14,'t',
       0x13,'r',
       0x11,'w',
       0x10,'q',
       0x1f,'s',
       0x23,'h',
       0x24,'j',
       0x25,'k',
       0x26,'l',
       0x2c,'z',
       0x2f,'v',
       0x32,'m',
       0x16,'u',
       0x2d,'x',
       0x31,'n',
       0x39,' ',
       0x1c,'\n'
       };
    unsigned char get = 0;
	get = __io_in8(0x60);
    for(int i = 0;i<28;++i){
    if(get == data[i][0]){
        char str[4] = {0};
        str[0] = data[i][1];
        __print(str);
    }
    }
}
