#include "stdint.h"
#include "x86.h"

void _cdecl cstart_(uint16_t bootDrive)
{
    char test = 'v';
    WriteChar(test, 0);

    for (;;);
}