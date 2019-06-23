PROJECT = test

ALLCSRC += $(wildcard ./src/*.c)
ALLCPPSRC += $(wildcard ./src/*.cpp)

ALLINC += ./inc

BUILDDIR := ./build
DEPDIR   := ./.dep

ifeq ($(COREDIR),)
	COREDIR = ./core
endif

include $(COREDIR)/syscfg.mk