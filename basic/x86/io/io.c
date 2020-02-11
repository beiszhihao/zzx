/*asm*/
int __io_in(int port){
        unsigned int ret = 0;
        __asm__ __volatile__("mov %0,%%edx\n\t"
                             "mov $0,%%eax\n\t"
                             "in  %%dx,%%eax\n\t"
                             :"=a"(ret):"d"(port));
        return ret;
}
