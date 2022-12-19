include Makefile.inc

.PHONY: build clean bootloader kernel

build: clean make-directories bootloader kernel Image-File

#---------------Image file--------------#

Image-File: bootloader kernel
	dd if=/dev/zero of=$(BUILD_DIR)/main.img bs=512 count=2880
	mkfs.fat -F 12 -n "NBOS" $(BUILD_DIR)/main.img
	dd if=$(BUILD_BOOTLOADER_STAGE1_DIR)/bootloader.bin of=$(BUILD_DIR)/main.img conv=notrunc
	mcopy -i $(BUILD_DIR)/main.img $(BUILD_DIR)/stage2.bin "::stage2.bin"
	mcopy -i $(BUILD_DIR)/main.img $(BUILD_DIR)/kernel/kernel.bin "::kernel.bin"

#---------------Bootloader--------------#
bootloader: make-directories
	$(ASM) $(SRC_BOOTLOADER_STAGE1_DIR)/boot.asm -f bin -o $(BUILD_BOOTLOADER_STAGE1_DIR)/bootloader.bin
	nasm -f obj -o $(BUILD_BOOTLOADER_STAGE2_DIR)/x86.o $(SRC_BOOTLOADER_STAGE2_DIR)/x86.asm
	nasm -f obj -o $(BUILD_BOOTLOADER_STAGE2_DIR)/main.o $(SRC_BOOTLOADER_STAGE2_DIR)/main.asm

	$(16CC) $(16CC_FLAGS) -fo=$(BUILD_BOOTLOADER_STAGE2_DIR)/mainc.o $(SRC_BOOTLOADER_STAGE2_DIR)/main.c

	$(16LD) NAME $(BUILD_DIR)/stage2.bin FILE \{ $(BUILD_BOOTLOADER_STAGE2_DIR)/x86.o $(BUILD_BOOTLOADER_STAGE2_DIR)/main.o $(BUILD_BOOTLOADER_STAGE2_DIR)/mainc.o \} OPTION MAP=$(BUILD_DIR)/stage2.map @linker.lnk

#---------------Kernel------------------#
kernel: make-directories
	$(ASM) $(SRC_DIR)/kernel/main.asm -f bin -o $(BUILD_DIR)/kernel/kernel.bin

#---------------Make Directories------------------#
make-directories:
	mkdir -p $(BUILD_DIR)
	mkdir -p $(BUILD_DIR)/bootloader
	mkdir -p $(BUILD_DIR)/bootloader/stage1
	mkdir -p $(BUILD_DIR)/bootloader/stage2
	mkdir -p $(BUILD_DIR)/kernel


#---------------Clean-------------------#
clean:
	rm -rf $(BUILD_DIR)/*