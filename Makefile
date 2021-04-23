include Makefile.inc

.PHONY: build clean run make-directories install-headers

build: make-directories install-headers
	
	# Compile all files in the kernel folder
	make ${KERNEL_OBJS}
	make ${STRING_OBJS}

	${CC} -T ${KERNELDIR}/linker.ld -o SharodeOS.bin -ffreestanding -O2 -nostdlib ${LINK_LIST} -lgcc

	cp SharodeOS.bin ${ISODIR}/boot/SharodeOS.bin
	cp grub.cfg ${ISODIR}/boot/grub/grub.cfg
	grub-mkrescue -o SharodeOS.iso ${ISODIR}

make-directories:
	mkdir -p isodir/boot/grub
	mkdir -p sysroot/kernel
	mkdir -p sysroot/libc
	mkdir -p sysroot/libc/string
	mkdir -p sysroot/include

install-headers:
	cp -R --preserve=timestamps ${KERNELDIR}/include/. ${SYSROOT}/include/.
	cp -R --preserve=timestamps ${LIBCDIR}/include/. ${SYSROOT}/include/.

clean:
	rm -rf sysroot
	rm -rf isodir
	rm -rf SharodeOS.bin
	rm -rf SharodeOS.iso

run:
	qemu-system-i386 -cdrom SharodeOS.iso

# Compile all .S files in kernel dircetory (${KERNELDIR}/%.S) into object files in the boot diectory (${BOOTDIR}/$@)
${SYSROOTKERNELDIR}/%.o: ${KERNELDIR}/%.S
	${AS} $^ -o $@

${SYSROOTKERNELDIR}/%.o: ${KERNELDIR}/%.c
	${CC} -c $^ -o $@ ${CFLAGS}

${SYSROOTLIBCDIR}/string/%.o: ${LIBCDIR}/string/%.c
	${CC} -c $^ -o $@ ${CFLAGS}