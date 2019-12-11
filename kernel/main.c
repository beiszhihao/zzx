/*
 * hello word test kerner
 * zzh
 * 2019.12.11
 * 9.51
 *
 */

int main(){
	char *p = 0;
	p = (char*)0xb8000;

	char* str = "hello word!";
	
	for(int i = 0;i<11;++i){
		*p = str[i];
		p++;
		p++;
	}

	//sleep(%)
	for(;;);
}
