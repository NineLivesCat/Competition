##
#	@Author	:	NineLivesCat
#	@Time	:	2019/7/10


# project name
PROJECT = test

# os directory
OSDIR = ./os

# core directory
COREDIR = ./os/Core

# build path
BUILDDIR = ./build

# Dependencies directory
DEPDIR = ./.dep

# Define the complier path if need
ADDRESS = D:/GNU Tools ARM Embedded/7.0 2017q4/bin

# personal source and header
CSRC += $(wildcard ./source/*.c)
CPPSRC += $(wildcard ./source/*.cpp)
ASSRC += $(wildcard ./source/*.s)
ASXSRC += $(wildcard ./source/*.S)
INC += ./source

# MCU 
MCU = cortex-m3

# linker script file
LDSCRIPT = $(OSDIR)/STM32F105RCTx_FLASH.ld
# startup file
ASSRC += $(OSDIR)/startup_stm32f105xc.s

# FreeRTOS and hal
include $(OSDIR)/syscfg.mk
include $(OSDIR)/oscfg.mk

# Compiler options here.	
  USE_OPT = --specs=nosys.specs -O3 -ggdb -fomit-frame-pointer

# C specific options
  USE_COPT = -std=c11

# C++ specific options
  USE_CPPOPT = -std=gnu++11 -fno-exceptions -fno-rtti -fno-threadsafe-statics

# Enable this if you want the linker to remove unused code and data
  USE_LINK_GC = yes

# Linker extra options here.
  USE_LDOPT =

# Enable this if you want link time optimizations
  USE_LTO = no

#	Stack size to be allocated to the Cortex-M process stack
  USE_PROCESS_STACKSIZE = 0x400

#	Stack size to the allocated to the Cortex-M main/exceptions stack
  USE_EXCEPTIONS_STACKSIZE = 0x400

#	FPU mode (no/soft/hard)
  USE_FPU = no

#	FPU-related options.
  USE_FPU_OPT = -mfloat-abi=$(USE_FPU) -mfpu=fpv4-sp-d16

#	THUMB-specific options here,allows to compile the application in THUMB mode.
  TOPT = -mthumb -DTHUMB

#	Define C warning options here
  CWARN = -Wall -Wextra -Wundef -Wstrict-prototypes

#	Define C++ warning options here
  CPPWARN = -Wall -Wextra -Wundef

#	List all user C define here, like -D_DEBUG=1
  DEFS += -DUSE_HAL_DRIVER \
-DSTM32F105xC \

#	Define ASM defines here
  ADEFS +=

#	List the user directory to look for the libraries here
  DIRLIB += 

#	List all user libraries here
  LIBS += 

include ./build.mk