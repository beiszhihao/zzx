#include "output.h"
BOOL __print(char *str,int len,int color,int dev){

	if(color > 0x000f){
		color = 0x000f;
	}
	if(color <= 0){
		color = 0x000f;
	}
	if(str == NULL){
		return FALSE;
	}
	if(len <= 0 || color <= 0 || dev > 0xfff){
		return FALSE;
	}

	char *ptr = (char *)0xb8000;
	ptr += dev;

	int i = 0;
	for(;i<len;++i){
		*ptr = str[i];
		*(ptr+1) = color;
		ptr++;
		ptr++;
	}
	return TRUE;
	
}
