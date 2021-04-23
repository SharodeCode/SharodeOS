#include <tty.h>
 
void kernel_main(void) 
{
	/* Initialize terminal interface */
	terminal_initialize();
 
	terminal_writestring("Hello, welcome to SharodeOS!\n");
}