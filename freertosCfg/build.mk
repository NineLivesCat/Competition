##
#	@Author	:	NineLivesCat
#	@Time	:	2019/7/10

ifeq ($(PROJECT),)
  PROJECT = test
endif

ifeq ($(OSDIR),)
  OSDIR = ./os
endif

ifeq ($(COREDIR),)
  COREDIR = ./os/Core
endif

ifeq ($(BUILDDIR),)
  BUILDDIR = ./build
endif

ifeq ($(DEPDIR),)
  DEPDIR = ./.dep
endif

ifeq ($(OBJDIR),)
  OBJDIR = $(BUILDDIR)/obj
endif

ifeq ($(LSTDIR),)
  LSTDIR = $(BUILDDIR)/lst
endif

ifeq ($(USE_LINK_GC),yes)
  OPT   += -ffunction-sections -fdata-sections -fno-common
  LDOPT := ,--gc-sections
else
  LDOPT :=
endif

ifneq ($(USE_LDOPT),)
  LDOPT := $(LDOPT),$(USE_LDOPT)
endif

ifeq ($(USE_LTO),yes)
  OPT += -flto
endif

# FPU options default (Cortex-M4 and Cortex-M7 single precision).
ifeq ($(USE_FPU_OPT),)
  USE_FPU_OPT = -mfloat-abi=$(USE_FPU) -mfpu=fpv4-sp-d16
endif

# FPU-related options
ifeq ($(USE_FPU),)
  USE_FPU = no
endif
ifneq ($(USE_FPU),no)
  OPT    += $(USE_FPU_OPT)
  DEFS  += -DCORTEX_USE_FPU=TRUE
  ADEFS += -DCORTEX_USE_FPU=TRUE
else
  DEFS  += -DCORTEX_USE_FPU=FALSE
  ADEFS += -DCORTEX_USE_FPU=FALSE
endif

# Process stack size
ifeq ($(USE_PROCESS_STACKSIZE),)
  LDOPT := $(LDOPT),--defsym=__process_stack_size__=0x400
else
  LDOPT := $(LDOPT),--defsym=__process_stack_size__=$(USE_PROCESS_STACKSIZE)
endif

# Exceptions stack size
ifeq ($(USE_EXCEPTIONS_STACKSIZE),)
  LDOPT := $(LDOPT),--defsym=__main_stack_size__=0x400
else
  LDOPT := $(LDOPT),--defsym=__main_stack_size__=$(USE_EXCEPTIONS_STACKSIZE)
endif


ifeq ($(ADDRESS),)
  TRGT = arm-none-eabi-
  CC   = $(TRGT)gcc
  CPPC = $(TRGT)g++
  #	Enable loading with g++ only if you need C++ runtime support.
  #	NOTE: You can use C++ even without C++ support if you are careful. C++
  #	runtime support makes code size explode.
  LD   = $(TRGT)gcc
  #LD   = $(TRGT)g++
  CP   = $(TRGT)objcopy
  AS   = $(TRGT)gcc -x assembler-with-cpp
  AR   = $(TRGT)ar
  OD   = $(TRGT)objdump
  SZ   = $(TRGT)size
  HEX  = $(CP) -O ihex
  BIN  = $(CP) -O binary
else
  TRGT = $(ADDRESS)/arm-none-eabi-
  CC   = "$(TRGT)gcc"
  CPPC = "$(TRGT)g++"
#	Enable loading with g++ only if you need C++ runtime support.
#	NOTE: You can use C++ even without C++ support if you are careful. C++
#	runtime support makes code size explode.
  LD   = "$(TRGT)gcc"
  #LD   = "$(TRGT)g++"
  CP   = "$(TRGT)objcopy"
  AS   = "$(TRGT)gcc" -x assembler-with-cpp
  AR   = "$(TRGT)ar"
  OD   = "$(TRGT)objdump"
  SZ   = "$(TRGT)size"
  HEX  = $(CP) -O ihex
  BIN  = $(CP) -O binary
endif


OPT		:= $(USE_OPT)
COPT	:= $(USE_COPT)
CPPOPT	:= $(USE_CPPOPT)

OUTFILES := $(BUILDDIR)/$(PROJECT).elf \
            $(BUILDDIR)/$(PROJECT).hex \
            $(BUILDDIR)/$(PROJECT).bin \
            $(BUILDDIR)/$(PROJECT).dmp \
            $(BUILDDIR)/$(PROJECT).list

CPATH	:= $(sort $(dir $(CSRC)))
CPPPATH	:= $(sort $(dir $(CPPSRC)))
ASPATH	:= $(sort $(dir $(ASSRC)))
ASXPATH	:= $(sort $(dir $(ASXSRC)))
PATH	:= $(sort $(dir $(CPATH)) $(dir $(CPPPATH)) $(dir $(ASPATH)) $(dir $(ASXPATH)))

vpath %.c 		$(sort $(dir $(CPATH)))
vpath %.cpp 	$(sort $(dir $(CPPPATH)))
vpath %.s 		$(sort $(dir $(ASPATH)))
vpath %.S		$(sort $(dir $(ASXPATH)))

COBJ	:= $(sort $(addprefix $(OBJDIR)/, $(notdir $(CSRC:.c=.o))))
CPPOBJ	:= $(sort $(addprefix $(OBJDIR)/, $(notdir $(CPPSRC:.cpp=.o))))
ASOBJ	:= $(sort $(addprefix $(OBJDIR)/, $(notdir $(ASSRC:.s=.o))))
ASXOBJ	:= $(sort $(addprefix $(OBJDIR)/, $(notdir $(ASXSRC:.S=.o))))
OBJ		:= $(sort $(COBJ) $(CPPOBJ) $(ASOBJ) $(ASXOBJ))

# Paths
INCDIR   := $(sort $(patsubst %,-I%,$(INC)))
LIBDIR   := $(patsubst %,-L%,$(DIRLIB))

# FLAGS
LIBFLAGS = -lc -lm -lnosys
MCFLAGS   := -mcpu=$(MCU) -mthumb
ODFLAGS   = -x --syms
ASFLAGS   = $(MCFLAGS) $(OPT) -Wa,-amhls=$(LSTDIR)/$(notdir $(<:.s=.lst)) $(ADEFS)
ASXFLAGS  = $(MCFLAGS) $(OPT) -Wa,-amhls=$(LSTDIR)/$(notdir $(<:.S=.lst)) $(ADEFS)
CFLAGS    = $(MCFLAGS) $(OPT) $(COPT) $(CWARN) -Wa,-alms=$(LSTDIR)/$(notdir $(<:.c=.lst)) $(DEFS)
CPPFLAGS  = $(MCFLAGS) $(OPT) $(CPPOPT) $(CPPWARN) -Wa,-alms=$(LSTDIR)/$(notdir $(<:.cpp=.lst)) $(DEFS)
#LDFLAGS   = $(MCFLAGS) $(OPT) -nostartfiles $(LIBDIR) -Wl,-Map=$(BUILDDIR)/$(PROJECT).map,--cref,--no-warn-mismatch,--library-path=$(STARTUPLD),--script=$(LDSCRIPT)$(LDOPT)
LDFLAGS   = $(MCFLAGS) -specs=nano.specs -T$(LDSCRIPT) $(LIBDIR) $(LIBFLAGS) -Wl,-Map=$(BUILDDIR)/$(PROJECT).map,--cref -Wl,--gc-sections,--script=$(LDSCRIPT)$(LDOPT)

ASFLAGS  += -MD -MP -MF $(DEPDIR)/$(@F).d
ASXFLAGS += -MD -MP -MF $(DEPDIR)/$(@F).d
CFLAGS   += -MD -MP -MF $(DEPDIR)/$(@F).d
CPPFLAGS += -MD -MP -MF $(DEPDIR)/$(@F).d

all:$(BUILDDIR) $(DEPDIR) $(OBJDIR) $(LSTDIR) $(OBJ) $(OUTFILES) 

$(BUILDDIR):
	@echo mkdir build
	@mkdir -p $(BUILDDIR)

$(DEPDIR):
	@echo mkdir .dep
	@mkdir -p $(DEPDIR)

$(OBJDIR):
	@echo mkdir obj
	@mkdir -p $(OBJDIR)

$(LSTDIR):
	@echo mkdir lst
	@mkdir -p $(LSTDIR)

$(COBJ) : $(OBJDIR)/%.o : %.c
	@echo Compiling $(<F)
	@$(CC) -c $(CFLAGS) -I. $(INCDIR) $< -o $@

$(CPPOBJ) : $(OBJDIR)/%.o : %.cpp
	@echo Compiling $(<F)
	@$(CPPC) -c $(CPPFLAGS) -I. $(INCDIR) $< -o $@

$(ASOBJ) : $(OBJDIR)/%.o : %.s
	@echo Compiling $(<F)
	@ $(AS) -c $(ASFLAGS) -I. $(INCDIR) $< -o $@

$(ASXOBJ) : $(OBJDIR)/%.o : %.S
	@echo Compiling $(<F)
	@$(CC) -c $(ASXFLAGS) $(TOPT) -I. $(INCDIR) $< -o $@


$(BUILDDIR)/$(PROJECT).elf : $(OBJ) $(LDSCRIPT)
	@echo Linking $@
	@$(LD) $(OBJ) $(LDFLAGS) $(LIBS) $(LIBFLAGS) -o $@

%.hex: %.elf
	@echo Creating $@
	@$(HEX) $< $@

%.bin: %.elf
	@echo Creating $@
	@$(BIN) $< $@

%.dmp: %.elf
	@echo Creating $@
	@$(OD) $(ODFLAGS) $< > $@
	@echo
	@$(SZ) $<

%.list: %.elf
	@echo Creating $@
	@$(OD) -S $< > $@
	@echo
	@echo Done

lib: $(OBJ) $(BUILDDIR)/lib$(PROJECT).a

$(BUILDDIR)/lib$(PROJECT).a: $(OBJ)
	@$(AR) -r $@ $^
	@echo
	@echo Done


.PHONY : clean 
clean:
	@echo Cleaning
	@echo - $(DEPDIR)
	@-rm -fR $(DEPDIR)
	@echo - $(BUILDDIR)
	@-rm -fR $(BUILDDIR)
	@echo Done

-include $(wildcard $(DEPDIR)/*)