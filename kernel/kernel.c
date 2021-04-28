#include <tty.h>
#include <stdio.h>
#include <gdt.h>
 
void kernel_main(void) 
{
	gdt_initialise();
	
	/* Initialize terminal interface */
	terminal_initialize();
 
	printf("Hello, welcome to SharodeOS!\n");
	printf("This is on a newline\n");
}