/*
 *transplant posix c
 *zzh
 *12.12
 *1.26
 *
 */
#include "macro.h"

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
