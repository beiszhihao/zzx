/*
 *transplant posix c
 *zzh
 *2.19
 */
#ifndef _STLIB_H
#define _STLIB_H

#include "stdder.h"
#include "stdarg.h"
/* we use this so that we can do without the ctype library */
#define is_digit(c)    ((c) >= '0' && (c) <= '9')


// 定义常用符号常数
#define ZEROPAD    1        /* pad with zero */
#define SIGN    2        /* unsigned/signed long */
#define PLUS    4        /* show plus */
#define SPACE    8        /* space if plus */
#define LEFT    16        /* left justified */
#define SPECIAL    32        /* 0x */
#define SMALL    64        /* use 'abcdef' instead of 'ABCDEF' */

// 除法操作，输入：n为被除数，base为除数；结果：n为商，函数返回值为余数。
#define do_div(n,base) ({ \
int __res; \
__asm__("divl %4":"=a" (n),"=d" (__res):"0" (n),"1" (0),"r" (base)); \
__res; })


// 格式化输出
extern int vsprintf(char *buf, const char *fmt, va_list args);
extern int vspf(char* buff,char *fmt, ...);

#endif
