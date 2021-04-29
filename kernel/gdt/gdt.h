#ifndef _GDT_H
#define _GDT_H 1

#include <stddef.h>

void gdt_set_descriptor(int num, unsigned long base, unsigned long limit, unsigned char access, unsigned char gran);
void gdt_initialise();

struct gdt_entry
{
   unsigned short segment_limit;  // segment limit first 0-15 bits
   unsigned short base_low;  // base first 0-15 bits
   unsigned char  base_middle; // base 16-23 bits
   unsigned char  access;  // access byte
   unsigned char  granularity;  // high 4 bits (flags) low 4 bits (limit 4 last bits)(limit is 20 bit wide)
   unsigned char  base_high;  // base 24-31 bits
} __attribute__((packed));


struct gdt_ptr
{
   unsigned short limit_size;  // limit size of all GDT segments
   struct gdt* base_address;  // base address of the first GDT segment
} __attribute__((packed));

extern struct gdt_entry gdt_entries[3];
extern struct gdt_ptr gdt_first;

extern void gdt_load(struct gdt_ptr*);


#endif