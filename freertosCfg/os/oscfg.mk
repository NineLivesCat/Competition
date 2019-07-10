##
#	@Author	:	NineLivesCat
#	@Time	:	2019/7/10
#	FreeRTOS configuration files

# os directory path
ifeq ($(OSDIR),)
  OSDIR = ./os
endif

# core path
ifeq ($(COREDIR),)
  COREDIR = ./os/Core
endif

# FreeRTOS path
ifeq ($(FREERTOSDIR),)
  FREERTOSDIR = $(OSDIR)/Middlewares/Third_Party/FreeRTOS/Source
endif

CSRC += $(wildcard $(FREERTOSDIR)/*.c)
CSRC += $(wildcard $(FREERTOSDIR)/CMSIS_RTOS/*.c)
CSRC += $(wildcard $(FREERTOSDIR)/portable/MemMang/*.c)
CSRC += $(wildcard $(FREERTOSDIR)/portable/GCC/ARM_CM3/*.c)

INC += $(FREERTOSDIR)/include
INC += $(FREERTOSDIR)/portable/GCC/ARM_CM3
INC += $(FREERTOSDIR)/CMSIS_RTOS

CSRC += $(wildcard $(COREDIR)/source/*.c)
CPPSRC += $(wildcard $(COREDIR)/source/*.cpp)

INC += $(COREDIR)/source