ENTRY(_start)
phys = 1M;
SECTIONS
{
  . = phys;

  .text : AT(phys)
  {
    code = .;
    *(.text)

    /* Read-only data. */
    *(.rodata)
    . = ALIGN(4096);
  }


  .data : AT(phys + (data - code))
  {
    data = .;
    /* Read-write data (initialised) */
    *(.data)
    . = ALIGN(4096);
  }

  .bss : AT(phys + (bss - code))
  {
    /* Stack */
    bss = .;
    *(.bss)
    . = ALIGN(4096);
  }
  end = .;
}