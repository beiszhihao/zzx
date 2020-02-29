/*
 * int  kerner
 * zzh
 * 2019.12.18
 * 2.33
 *
 */
#include "output.h"
#include "stdlib.h"
#include "idt.h"
#include "8259a.h"
#include "io.h"
#include "stdio.h"
#include "dspbkltl.h"
#include "memory.h"
extern void _int_key_21(void);
extern void _int_kernel_key_21(int *esp);
struct dd{
    int yun;
    int z;
};
int main(){
    /*init idt*/
    __idt_init();
    /*set idt index*/
    __set_idt(0x21,(int)_int_key_21,8,0x008e);
    /*open init*/
    __open_init();
    /*初始化8529a电路*/
    __8259a_pic_init();
    /*开启8529a上键盘中断电路，否则idt无法响应cpu内部中断*/
    __open_pic_int(0x21,0xf9);
    __open_pic_int(0xa1,0xef);
    //检索当前可用内存
    __print("currently available memory:\n");
    struct memory_layout *ptr = (struct memory_layout *)E820_ADDR;
    for(int j =0;j<ptr->block_max;++j){
            __printk("Type:0x%x Addr:0x%x Leng:0x%x\n",ptr->block[j].type,
                     ptr->block[j].base_addr_low,
                     ptr->block[j].base_addr_low+ptr->block[j].length_low);
    }
    __print("\nmalloc demo:\n");
    //初始化内核态的内存管理
    if(_kinit() == NULL){
        __print("init memnory error");
    }
    //为内核态分配内存
    char *str = _kmalloc(10);
    char *std = _kmalloc(20);
    char *ste = _kmalloc(30);
    //打印分配到的内存地址
    __printk("str:0x%x\nstd:0x%x\nste:0x%x\n",str,std,ste);
    //写值
    //strcpy不会检查越界，需要注意写入的字节不能大于分配的字节
    strcpy(str,"hello word");
    strcpy(std,"hello word 20");
    strcpy(ste,"hello word 30");
    __printk("str:%s\nstd:%s\nste:%s\n",str,std,ste);
    //释放,注意释放不是清空内存，只是把地址归还给内核，std指向的地址依然有效
    //但是这块地址可能会被下一次的kmalloc分配走
    //为了避免错乱尽可能的在使用完kfree函数后将指针置空
    _kfree(str);
    str = NULL;
    _kfree(std);
    std = NULL;
    _kfree(ste);
    ste = NULL;
    __print("\ntty demo:\n");
    /*用户部分*/
    __print("hello word! zzxOS.\n");
    __print("$:");

    for(;;){
    }
   
}

/*处理键盘部分*/
char file[256] = {0};
int index1;
void s1(){
   __print("zzxos\n");
}
void s2(){
    __print("ld:no file\n");
    
}
void s3(){
    __print("error:no comd\n");
    
}
void _int_kernel_key_21(int *esp){
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
	get = __io_in(0x60);
    for(int i = 0;i<28;++i){
    if(get == data[i][0]){
	if(get == 0x1c){
        __print("\n");
		if(strcmp(file,"help") == 0){
            /*call*/
            s1();
            
		}else if(strcmp(file,"ld") == 0){
            
            s2();
        }else{
            
            s3();
        }
        memset(file,0,strlen(file));
        index1 = 0;
        __print("$:");
		break;
	}
        char str[4] = {0};
        str[0] = data[i][1];
	file[index1++] = data[i][1];
        __print(str);
    }
    }
}
