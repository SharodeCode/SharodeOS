
# ${shell pwd} gives current working directory
CURRENTDIR=${shell pwd}

ASM=nasm
16CC = /usr/bin/watcom/binl64/wcc
16LD = /usr/bin/watcom/binl64/wlink

16CC_FLAGS = -4 -d3 -s -wx -ms -zl -zq

SRC_DIR=src
BUILD_DIR=build

KERNEL_DIR = $(SRC_DIR)/kernel

BOOTLOADER_S1_DIR = /bootloader/stage1
BOOTLOADER_S2_DIR = /bootloader/stage2

SRC_BOOTLOADER_STAGE1_DIR = $(SRC_DIR)/$(BOOTLOADER_S1_DIR)
BUILD_BOOTLOADER_STAGE1_DIR = $(BUILD_DIR)/$(BOOTLOADER_S1_DIR)

SRC_BOOTLOADER_STAGE2_DIR = $(SRC_DIR)/$(BOOTLOADER_S2_DIR)
BUILD_BOOTLOADER_STAGE2_DIR = $(BUILD_DIR)/$(BOOTLOADER_S2_DIR)

BOOTLOADER_OBJS=\
${SYSROOTKERNELDIR}/gdt/gdt.o \
${SYSROOTKERNELDIR}/gdt/gdt_asm.o \