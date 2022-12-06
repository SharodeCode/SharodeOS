ASM=nasm

SRC_DIR=src
BUILD_DIR=build

.PHONY: all clean bootloader kernel

#---------------Image file--------------#
image_file: $(BUILD_DIR)/main.img

$(BUILD_DIR)/main.img: bootloader kernel
	dd if=/dev/zero of=$(BUILD_DIR)/main.img bs=512 count=2880
	mkfs.fat -F 12 -n "NBOS" $(BUILD_DIR)/main.img
	dd if=$(BUILD_DIR)/bootloader.bin of=$(BUILD_DIR)/main.img conv=notrunc
	mcopy -i $(BUILD_DIR)/main.img $(BUILD_DIR)/kernel.bin "::kernel.bin"

#---------------Bootloader--------------#
bootloader: $(BUILD_DIR)/bootlaoder.bin

$(BUILD_DIR)/bootlaoder.bin: always
	$(ASM) $(SRC_DIR)/bootloader/boot.asm -f bin -o $(BUILD_DIR)/bootloader.bin

#---------------Kernel------------------#
kernel: $(BUILD_DIR)/kernel.bin

$(BUILD_DIR)/kernel.bin: always
	$(ASM) $(SRC_DIR)/kernel/main.asm -f bin -o $(BUILD_DIR)/kernel.bin

#---------------Always------------------#
always:
	mkdir -p $(BUILD_DIR)


#---------------Clean-------------------#
clean:
	rm -rf $(BUILD_DIR)/*