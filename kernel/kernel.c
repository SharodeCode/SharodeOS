#include <tty.h>
#include <stdio.h>
 
void kernel_main(void) 
{
	/* Initialize terminal interface */
	terminal_initialize();
 
	printf("Hello, welcome to SharodeOS!\n");
}