##
#	@Author	:	NineLivesCat
#	@Time	:	2019/7/10
#	HAL and cmsis configuration files

# os directory path
ifeq ($(OSDIR),)
  OSDIR = ./os
endif

# driver directory path
ifeq ($(DRIVERDIR),)
  DRIVERDIR = = $(OSDIR)/Drivers
endif

# hal directory path
ifeq ($(HALDIR),)
  HALDIR = $(DRIVERDIR)/STM32F1xx_HAL_Driver
endif

# cmsis directory path
ifeq ($(CMSISDIR),)
  CMSISDIR = $(DRIVERDIR)/CMSIS
endif

# HAL files
CSRC += $(filter-out $(wildcard $(HALDIR)/Src/*template.c), $(wildcard $(HALDIR)/Src/stm32f1xx_hal*.c))

# LL files
#CSRC += $(filter-out $(wildcard $(HALDIR)/Src/*template.c), $(wildcard $(HALDIR)/Src/stm32f1xx_ll*.c))

# DSP files
#CSRC += $(wildcard$(CMSISDIR)/DSP_Lib/Source/BasicMathFunctions/*.c)
#CSRC += $(wildcard$(CMSISDIR)/DSP_Lib/Source/CommonTables/*.c)
#CSRC += $(wildcard$(CMSISDIR)/DSP_Lib/Source/ComplexMathFunctions/*.c)
#CSRC += $(wildcard$(CMSISDIR)/DSP_Lib/Source/ControllerFunctions/*.c)
#CSRC += $(wildcard$(CMSISDIR)/DSP_Lib/Source/FastMathFunctions/*.c)
#CSRC += $(wildcard$(CMSISDIR)/DSP_Lib/Source/FilteringFunctions/*.c)
#CSRC += $(wildcard$(CMSISDIR)/DSP_Lib/Source/MatrixFunctions/*.c)
#CSRC += $(wildcard$(CMSISDIR)/DSP_Lib/Source/StatisticsFunctions/*.c)
#CSRC += $(wildcard$(CMSISDIR)/DSP_Lib/Source/SupportFunctions/*.c)
#CSRC += $(wildcard$(CMSISDIR)/DSP_Lib/Source/TransformFunctions/*.c)
#LIBS += $(wildcard $(CMSISDIR)/Lib/GCC/*.a)

# HAL include path
INC += $(HALDIR)/Inc
INC += $(HALDIR)/Inc/Legacy

# CMSIS include path
INC += $(CMSISDIR)/Include
INC += $(CMSISDIR)/Device/ST/STM32F1xx/Include

# library include path
DIRLIB +=  $(CMSISDIR)/GCC


ifeq ($(LDSCRIPT),)
  LDSCRIPT = $(OSDIR)/STM32F105RCTx_FLASH.ld
endif