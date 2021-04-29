#include "gdt.h"

struct gdt_entry gdt_entries[3];
struct gdt_ptr gdt_first;


void gdt_initialise()
{
    /* Set GDT pointer */
	gdt_first.limit_size = (sizeof(gdt_entries) * 3) - 1;
	gdt_first.base_address = &gdt_entries;
	
    /* NULL descriptor */
	gdt_set_descriptor(0, 0, 0, 0, 0);

	/* Code segment descriptor */
	gdt_set_descriptor(1, 0, 0xFFFFFFFF, 0x9A, 0xCF);

	/* Data segment descriptor */
	gdt_set_descriptor(2, 0, 0xFFFFFFFF, 0x92, 0xCF);

	/* Load in GDT table*/
	gdt_load((struct gdt_ptr*)&gdt_entries);
}

/*
 *  Set GDT descriptor
 */
void gdt_set_descriptor(int num, unsigned long base, unsigned long limit, unsigned char access, unsigned char gran)
{
    /* Set base address */
	gdt_entries[num].base_low = (base & 0xFFFF);
	gdt_entries[num].base_middle = (base >> 16) & 0xFF;
	gdt_entries[num].base_high = (base >> 24) & 0xFF;

	/* Set limits */
	gdt_entries[num].segment_limit = (limit & 0xFFFF);
	gdt_entries[num].granularity = ((limit >> 16) & 0x0F);

    /* Set granularity */
	gdt_entries[num].granularity |= (gran & 0xF0);

    /* Set access flags */
	gdt_entries[num].access = access;
}