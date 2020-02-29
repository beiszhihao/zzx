#ifndef _MEMORY_H
#define _MEMORY_H
#define KERNEL 0x8200
#define SIZE  5480
#define MAP_SIZE 4
#define MAP_MAX 128
struct memont_t{
    long long add;
    int type;
    int size;
}map[MAP_MAX];
int num;
extern int _kinit();
extern void* _kmalloc(int size);
extern void _kfree(void *ptr);
#endif
