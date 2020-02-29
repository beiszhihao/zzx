/*
 *transplant posix c
 *zzh
 *2.20
 *2.21
 */
#include "memory.h"
#include "dspbkltl.h"
signed int ker_num = -1;
signed int us_num = -1;
struct memory_layout *mey_ptr = (struct memory_layout *)E820_ADDR;
int _kinit(){
    char *ptr = 0;
    //寻找小于1mb的空间
    for(int i = 0;i<mey_ptr->block_max;++i){
        if(mey_ptr->block[i].type == 0x1){
            if(mey_ptr->block[i].base_addr_low<=KERNEL){ if((mey_ptr->block[i].base_addr_low+mey_ptr->block[i].length_low)>(KERNEL+SIZE)){
                ker_num = i;
            }
            }
        }
    }
    //没有找到合适的内存段
    if(ker_num == -1){
        return 0;
    }
    //初始化内核段
    int _temp = 0;
    int _jy = 0;
    for(int i = 0;i<MAP_MAX;++i){
        _temp+=MAP_SIZE;
        //内核地址检查
        if(_temp >= KERNEL && _jy == 0){
            _temp = KERNEL+SIZE;
            _temp += MAP_SIZE;
            _jy = 1;
        }
        //越界检查
        if(_temp >
           mey_ptr->block[ker_num].base_addr_low+
           mey_ptr->block[ker_num].length_low){
            for(int j = j;j<MAP_MAX;++j){
                map[j].type = 1;
                map[j].add = 0;
                map[j].size = 0;
            }
            break;
        }
        map[i].type = 0;
        map[i].add = _temp;
        map[i].size = MAP_SIZE;
    }
    //寻找用户态的内存段
    for(int i = 0;i<mey_ptr->block_max;++i){
        if(mey_ptr->block[i].type == 0x1){
            if(mey_ptr->block[i].base_addr_low>=0x100000){
                us_num = i;
            }
            }
        }
    if(us_num == -1){
        return 0;
    }
    return 1;
}

void* _kmalloc(int size){
    for(int i = 0;i<MAP_MAX;++i){
        if(map[i].type == 0){
            map[i].type = 1;
            for(int j = i;j<(i+(size/MAP_SIZE));++j){
                map[j+1].type = 1;
            }
            map[i].size = size;
            return (void*)(long)map[i].add;
        }
    }
    return  0;
}
void _kfree(void* ptr){
    int * p = ptr;
    for(int i = 0;i<MAP_MAX;++i){
        if(*p == map[i].add){
            map[i].type = 0;
            map[i].size = MAP_SIZE;
            for(int j = i;j<(i+(map[i].size/MAP_SIZE));++j){
                map[j+1].type = 0;
            }
        }
    }
    return;
    
}
