##
#	@Author	:	NineLivesCat
#	@Time	:	2019/6/22

ifeq ($(CHIBIOS),)
	CHIBIOS = $(COREDIR)/chibios
endif

ALLCSRC += $(wildcard $(COREDIR)/source/*.c)
ALLCPPSRC += $(wildcard $(COREDIR)/source/*.cpp)

AllINC += $(COREDIR)/source
