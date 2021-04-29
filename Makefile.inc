HOST=i686-elf

AS=${HOST}-as
CC=${HOST}-gcc --sysroot=${CURRENTDIR}/sysroot -isystem=/include

CFLAGS=-std=gnu99 -ffreestanding -O2 -Wall -Wextra

# ${shell pwd} gives current working directory
CURRENTDIR=${shell pwd}

SYSROOT=${CURRENTDIR}/sysroot
ISODIR=${CURRENTDIR}/isodir

KERNELDIR=${CURRENTDIR}/kernel
LIBCDIR=${CURRENTDIR}/libc

SYSROOTKERNELDIR=${SYSROOT}/kernel
SYSROOTLIBCDIR=${SYSROOT}/libc

KERNEL_OBJS=\
${SYSROOTKERNELDIR}/gdt/gdt.o \
${SYSROOTKERNELDIR}/gdt/gdt_asm.o \
${SYSROOTKERNELDIR}/boot.o \
${SYSROOTKERNELDIR}/crti.o \
${SYSROOTKERNELDIR}/crtn.o \
${SYSROOTKERNELDIR}/kernel.o \
${SYSROOTKERNELDIR}/tty.o \

STRING_OBJS=\
${SYSROOTLIBCDIR}/string/memcmp.o \
${SYSROOTLIBCDIR}/string/memcpy.o \
${SYSROOTLIBCDIR}/string/memmove.o \
${SYSROOTLIBCDIR}/string/memset.o \
${SYSROOTLIBCDIR}/string/strlen.o \

STDIO_OBJS=\
${SYSROOTLIBCDIR}/stdio/printf.o \

LINK_LIST=\
${STRING_OBJS} \
${KERNEL_OBJS} \
${STDIO_OBJS} \
