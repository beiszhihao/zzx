/*
 * hello word test kerner
 * zzh
 * 2019.12.11
 * 9.51
 *
 */
#include "output.h"
#include "string.h"
int main(){
	char* str = "love to ixsy";
	char *stu = "love to to to";
	strcpy(stu,str);
	__print(stu,strlen(stu),0x000f,0);
	for(;;);
}
