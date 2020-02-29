#ifndef _STRING_H
#define _STRING_H
extern int strlen(const char *str);
extern char* strcpy(char* dest,const char* src);
extern char* strcat(char* dest,const char* src);
extern int strcmp(const char *src,const char *dst);
extern void *(memset) (void *s,int c,size_t n);
extern char* itoa(int value,char*string,int radix);

#endif
