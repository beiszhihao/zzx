/*
 *transplant posix c
 *zzh
 *12.12
 *1.26
 *
 */
#include "stdder.h"

int strlen(const char *str){

	int count = 0;
	while(*str){
		count++;
		str++;
	}
	return count;
}

char *strcpy(char* dest,const char* src){
	char *ret = dest;
	if(dest == NULL){
		return NULL;
	}
	if(src == NULL){
		return NULL;
	}

	while((*dest = *src)){
		dest++;
		src++;
	}
	return ret;

}

char *strcat(char* dest,const char*src){
	char *ret = dest;
	if(dest == NULL){
		return NULL;
	}
	if(src == NULL){
		return NULL;
	}
	while(*dest){
		dest++;
	}
	while(*dest = *src){
		dest++;
		src++;
	}
	return ret;
}

int strcmp(const char *src,const char *dst){
              int ret=0;
              while(!(ret = *(unsigned char *)src - *(unsigned char *)dst) && *dst)
                  ++src,++dst;
              if(ret<0)
                  ret=-1;
              else if(ret>0)
                  ret=1;
              return(ret);
}

void *(memset) (void *s,int c,size_t n)
{
const unsigned char uc = c;
unsigned char *su;
for(su = s;0 < n;++su,--n)
*su = uc;
return s;
}
