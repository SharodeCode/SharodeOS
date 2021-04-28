#include <tty.h>

void printf(const char* data) 
{
	terminal_writestring(data);
}