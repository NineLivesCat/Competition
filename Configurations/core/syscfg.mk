##
#	@Author	:	NineLivesCat
#	@Time	:	2019/6/22

ifeq ($(CHIBIOS),)
	CHIBIOS = $(COREDIR)/chibios
endif

ALLCSRC += $(wildcard $(COREDIR)/src/*.c)
ALLCPPSRC += $(wildcard $(COREDIR)/src/*.cpp)

AllINC += $(COREDIR)/inc

include $(COREDIR)/oscfg.mk