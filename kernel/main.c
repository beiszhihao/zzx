/*
 * hello word test kerner
 * zzh
 * 2019.12.11
 * 9.51
 *
 */
#include "output.h"
#include "string.h"
#include "stdlib.h"
int main(){
	char str[10] = {0};
	itoa(123,str,10);
	char *s = "sd";
	__print(str,strlen(str),0x000f,0);
	for(;;);
}
