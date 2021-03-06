#include "../include/output.h"
static int dev_add = 0;
static int str_num = 0;
void ___setmv(int pos,int hight,int low){
   if(hight == 0){
   hight = (pos >> 8)&0xff;
   }
   if(low == 0){
   low = pos & 0xff;
   }
   asm("mov $0x3d4,%dx\n"\
    "mov $0xe,%al\n"\
    "out %al,%dx\n"\
    "inc %dx\n"\
    "mov 12(%esp),%ax\n"\
    "out %al,%dx\n"\
    "mov $0x3d4,%dx\n"\
    "mov $0xf,%al\n"\
    "out %al,%dx\n"\
    "inc %dx\n"\
    "mov 16(%esp),%ax\n"\
    "out %al,%dx");
    
}
bool __Print(char *str,int len,int color,int dev){
   
    int _temp_dev = 0;
	
	_temp_dev = dev;
	
	if(color > 0x000f){
		color = 0x000f;
	}
	if(color <= 0){
		color = 0x000f;
	}
	if(str == NULL){
		return false;
	}
	if(len <= 0 || color <= 0 || dev > 0xfff){
		return false;
	}

	char *ptr = (char *)0xb8000;
	ptr += _temp_dev;

	int i = 0;
	for(;i<len;++i){
		
		if(str[i] == '\n'){
			ptr+=160;
			ptr-=str_num*2;
			_temp_dev = (int)(ptr-(0xb8000));
			str_num = 0;
			continue;
		}
		str_num++;
		*ptr = str[i];
		*(ptr+1) = color;
		ptr++;
		ptr++;
		_temp_dev += 2;
	}
        ___setmv(_temp_dev/2,0,0);  ///2 mv no bg
	dev_add = _temp_dev;
	return true;
	
}

/*
 * 17岁boy博主修改优化
 * 主页：https://blog.csdn.net/bjbz_cxy/
 */

bool __print(char *str){
   
	__Print(str,strlen(str),0x00ef,dev_add);
}

bool __printk(char *str, ...){
    char str_ptr[256] = {0};
    va_list argptr;
    int cnt;
    va_start(argptr, str);
    cnt = vsprintf(str_ptr, str, argptr);
    va_end(argptr);
    __print(str_ptr);
}
