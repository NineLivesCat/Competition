PROJECT = test

ALLCSRC += $(wildcard ./source/*.c)
ALLCPPSRC += $(wildcard ./source/*.cpp)

ALLINC += ./source

BUILDDIR := ./build
DEPDIR   := ./.dep

ifeq ($(COREDIR),)
	COREDIR = ./core
endif

include $(COREDIR)/syscfg.mk
include $(COREDIR)/oscfg.mk