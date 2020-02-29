#ifndef _OUTPUT_H
#define _OUTPUT_H
#include "stdder.h"
#include "stdbool.h"
#include "string.h"
#include "stdarg.h"
#include "stdio.h"
extern bool __Print(char *str,int len,int color,int dev);
extern bool __print(char *str);
extern bool __printk(char *str,...);
#endif
