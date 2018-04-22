#!/usr/bin/make
#
# The Magma Makefile
#
#########################################################################

TOPDIR							= $(realpath .)
MFLAGS							=
#MAKEFLAGS						= --output-sync=target --jobs=6
MAKEFLAGS						= --output-sync=target

# Identity of this package.
PACKAGE_NAME					= LibCore
PACKAGE_TARNAME					= libcore
PACKAGE_VERSION					= 6.4
PACKAGE_STRING					= $(PACKAGE_NAME) $(PACKAGE_VERSION)
PACKAGE_BUGREPORT				= support@lavabit.com
PACKAGE_URL						= https://lavabit.com

MAGMA_PROGRAM					= $(addsuffix $(EXEEXT), libcore)
MAGMA_CHECK_PROGRAM				= $(addsuffix $(EXEEXT), libcore.check)
MAGMA_SHARED_LIBRARY			= $(addsuffix $(DYNLIBEXT), libcore)

MAGMA_PROGRAM_GPROF				= $(addsuffix $(EXEEXT), libcore.gprof)
MAGMA_CHECK_PROGRAM_GPROF		= $(addsuffix $(EXEEXT), libcore.check.gprof)

MAGMA_PROGRAM_PPROF				= $(addsuffix $(EXEEXT), libcore.pprof)
MAGMA_CHECK_PROGRAM_PPROF		= $(addsuffix $(EXEEXT), libcore.check.pprof)

#DIME_PROGRAM					= $(addsuffix $(EXEEXT), dime)
#SIGNET_PROGRAM					= $(addsuffix $(EXEEXT), signet)
#GENREC_PROGRAM					= $(addsuffix $(EXEEXT), genrec)
#DIME_CHECK_PROGRAM				= $(addsuffix $(EXEEXT), dime.check)

# Source Files
BUILD_SRCFILES					= src/engine/status/build.c

MAGMA_STATIC					= 
MAGMA_DYNAMIC					= -lrt -ldl -lpthread -lresolv
MAGMA_SRCDIRS					= $(shell find src -type d -print)
MAGMA_SRCFILES					= $(filter-out $(FILTERED_SRCFILES), $(foreach dir, $(MAGMA_SRCDIRS), $(wildcard $(dir)/*.c)))

MAGMA_CHECK_STATIC				= $(MAGMA_STATIC) $(TOPDIR)/lib/local/lib/libcheck.a
MAGMA_CHECK_DYNAMIC				= $(MAGMA_DYNAMIC) -lm
MAGMA_CHECK_SRCDIRS				= $(shell find check -type d -print)
MAGMA_CHECK_SRCFILES			= $(foreach dir, $(MAGMA_CHECK_SRCDIRS), $(wildcard $(dir)/*.c))

#DIME_SRCDIRS					= $(shell find src/ tools/dime -type d -print)
#DIME_SRCFILES					= $(filter-out $(FILTERED_SRCFILES), $(foreach dir, $(DIME_SRCDIRS), $(wildcard $(dir)/*.c)))
#DIME_STATIC						= $(TOPDIR)/lib/local/lib/libz$(STATLIBEXT) $(TOPDIR)/lib/local/lib/libssl$(STATLIBEXT) \
#                                 $(TOPDIR)/lib/local/lib/libcrypto$(STATLIBEXT) $(TOPDIR)/lib/local/lib/libutf8proc$(STATLIBEXT)

#SIGNET_SRCDIRS					= $(shell find src/ tools/signet -type d -print)
#SIGNET_SRCFILES					= $(filter-out $(FILTERED_SRCFILES), $(foreach dir, $(SIGNET_SRCDIRS), $(wildcard $(dir)/*.c)))
#SIGNET_STATIC					= $(TOPDIR)/lib/local/lib/libz$(STATLIBEXT) $(TOPDIR)/lib/local/lib/libssl$(STATLIBEXT) \
                                  $(TOPDIR)/lib/local/lib/libcrypto$(STATLIBEXT) $(TOPDIR)/lib/local/lib/libutf8proc$(STATLIBEXT)

#GENREC_SRCDIRS					= $(shell find src/ tools/genrec -type d -print)
#GENREC_SRCFILES					= $(filter-out $(FILTERED_SRCFILES), $(foreach dir, $(GENREC_SRCDIRS), $(wildcard $(dir)/*.c)))
#GENREC_STATIC					= $(TOPDIR)/lib/local/lib/libz$(STATLIBEXT) $(TOPDIR)/lib/local/lib/libssl$(STATLIBEXT) \
                                  $(TOPDIR)/lib/local/lib/libcrypto$(STATLIBEXT) $(TOPDIR)/lib/local/lib/libutf8proc$(STATLIBEXT)
                                  
#DIME_CHECK_DYNAMIC				= $(MAGMA_DYNAMIC) -lstdc++
#DIME_CHECK_CPPDIRS				= $(shell find check/dime -type d -print)
#DIME_CHECK_SRCDIRS				= $(shell find src/ check/dime -type d -print)
#DIME_CHECK_CPPFILES				= $(foreach dir, $(DIME_CHECK_CPPDIRS), $(wildcard $(dir)/*.cpp))
#DIME_CHECK_SRCFILES				= $(filter-out $(FILTERED_SRCFILES), $(foreach dir, $(DIME_CHECK_SRCDIRS), $(wildcard $(dir)/*.c)))
#DIME_CHECK_STATIC				= $(MAGMA_STATIC) $(TOPDIR)/lib/local/lib/libz$(STATLIBEXT) $(TOPDIR)/lib/local/lib/libssl$(STATLIBEXT) \
                                  $(TOPDIR)/lib/local/lib/libcrypto$(STATLIBEXT) $(TOPDIR)/lib/local/lib/libutf8proc$(STATLIBEXT) \
                                  $(TOPDIR)/lib/sources/googtest/lib/.libs/libgtest.a 
 
FILTERED_SRCFILES				= src/providers/dime/ed25519/test.c src/providers/dime/ed25519/test-internals.c \
                                  src/providers/dime/ed25519/fuzz/curve25519-ref10.c src/providers/dime/ed25519/fuzz/ed25519-donna-sse2.c \
                                  src/providers/dime/ed25519/fuzz/fuzz-curve25519.c src/providers/dime/ed25519/fuzz/ed25519-donna.c \
                                  src/providers/dime/ed25519/fuzz/ed25519-ref10.c src/providers/dime/ed25519/fuzz/fuzz-ed25519.c

#PACKAGE_DEPENDENCIES			= $(MAGMA_SHARED_LIBRARY) $(MAGMA_STATIC) $(filter-out $(MAGMA_STATIC), $(MAGMA_CHECK_STATIC))

# Bundled Dependency Include Paths
INCDIR							= $(TOPDIR)/lib/local/include
#MAGMA_INCDIRS					= spf2/ mysql/ openssl/ lzo/ libxml2/ libmemcached/ opendkim/ dspam/ freetype2/

MAGMA_CHECK_INCDIRS				= 

MAGMA_CINCLUDES					= -Isrc #-Isrc/providers -I$(INCDIR) $(addprefix -I,$(MAGMA_INCLUDE_ABSPATHS))
#DIME_CHECK_CINCLUDES			= $(MAGMA_CINCLUDES)
#MAGMA_CHECK_CINCLUDES			= -Icheck/magma -Ilib/local/include/ $(MAGMA_CINCLUDES) $(addprefix -I,$(MAGMA_CHECK_INCLUDE_ABSPATHS))
#DIME_CHECK_CPPINCLUDES			= -Icheck/dime -Ilib/sources/googtest/include/ -Ilib/sources/googtest/ -Ilib/sources/googtap/src/ $(MAGMA_CINCLUDES)

CDEFINES						= -D_REENTRANT -D_GNU_SOURCE -D_LARGEFILE64_SOURCE -DHAVE_NS_TYPE -DFORTIFY_SOURCE=2 -DMAGMA_PEDANTIC 
CDEFINES.build.c 				= -DMAGMA_VERSION=\"$(MAGMA_VERSION)\" -DMAGMA_COMMIT=\"$(MAGMA_COMMIT)\" -DMAGMA_TIMESTAMP=\"$(MAGMA_TIMESTAMP)\"

CPPDEFINES						= $(CDEFINES) -DGTEST_TAP_PRINT_TO_STDOUT -DGTEST_HAS_PTHREAD=1
#CPPDEFINES						+= -DDIME_BUILD=\"$(MAGMA_VERSION)\" -DDIME_STAMP=\"$(MAGMA_TIMESTAMP)\"


# Hidden Directory for Dependency Files
DEPDIR							= .deps
#DIME_DEPFILES					= $(patsubst %.c,$(DEPDIR)/%.d,$(DIME_SRCFILES))
MAGMA_DEPFILES					= $(patsubst %.c,$(DEPDIR)/%.d,$(MAGMA_SRCFILES))
#SIGNET_DEPFILES					= $(patsubst %.c,$(DEPDIR)/%.d,$(SIGNET_SRCFILES))
#GENREC_DEPFILES					= $(patsubst %.c,$(DEPDIR)/%.d,$(GENREC_SRCFILES))
MAGMA_CHECK_DEPFILES			= $(patsubst %.c,$(DEPDIR)/%.d,$(MAGMA_CHECK_SRCFILES))
#DIME_CHECK_DEPFILES				= $(patsubst %.c,$(DEPDIR)/%.d,$(DIME_CHECK_SRCFILES))
#DIME_CHECK_DEPFILES				+= $(patsubst %.cc,$(DEPDIR)/%.d,$(DIME_CHECK_CCFILES))
#DIME_CHECK_DEPFILES				+= $(patsubst %.cpp,$(DEPDIR)/%.d,$(DIME_CHECK_CPPFILES))

# Hidden Directory for Object Files
OBJDIR							= .objs
MAGMA_OBJFILES					= $(patsubst %.c,$(OBJDIR)/%.o,$(MAGMA_SRCFILES))
MAGMA_CHECK_OBJFILES			= $(patsubst %.c,$(OBJDIR)/%.o,$(MAGMA_CHECK_SRCFILES))

MAGMA_PROF_OBJFILES				= $(patsubst %.c,$(OBJDIR)/%.pg.o,$(MAGMA_SRCFILES))
MAGMA_CHECK_PROF_OBJFILES		= $(patsubst %.c,$(OBJDIR)/%.pg.o,$(MAGMA_CHECK_SRCFILES))

#DIME_OBJFILES					= $(filter-out .objs/src//magma.o, $(patsubst %.c,$(OBJDIR)/%.o,$(DIME_SRCFILES)))
#SIGNET_OBJFILES					= $(filter-out .objs/src//magma.o, $(patsubst %.c,$(OBJDIR)/%.o,$(SIGNET_SRCFILES)))
#GENREC_OBJFILES					= $(filter-out .objs/src//magma.o, $(patsubst %.c,$(OBJDIR)/%.o,$(GENREC_SRCFILES)))
#DIME_CHECK_OBJFILES				= $(filter-out .objs/src//magma.o, $(patsubst %.c,$(OBJDIR)/%.o,$(DIME_CHECK_SRCFILES)))
#DIME_CHECK_OBJFILES				+= $(patsubst %.cc,$(OBJDIR)/%.o,$(DIME_CHECK_CCFILES))
#DIME_CHECK_OBJFILES				+= $(patsubst %.cpp,$(OBJDIR)/%.o,$(DIME_CHECK_CPPFILES))

# Resolve the External Include Directory Paths
INCLUDE_DIR_VPATH				= $(INCDIR) /usr/include /usr/local/include
INCLUDE_DIR_SEARCH 				= $(firstword $(wildcard $(addsuffix /$(1),$(subst :, ,$(INCLUDE_DIR_VPATH)))))

# Generate the Absolute Directory Paths for Includes
MAGMA_INCLUDE_ABSPATHS			+= $(foreach target,$(MAGMA_INCDIRS), $(call INCLUDE_DIR_SEARCH,$(target)))
MAGMA_CHECK_INCLUDE_ABSPATHS	+= $(foreach target,$(MAGMA_CHECK_INCDIRS), $(call INCLUDE_DIR_SEARCH,$(target)))

# Magma Incremental Builds
# MAGMA_INCREMENTAL_BUILD		= $(patsubst %.c, $(OBJDIR)/%.o, $(shell find src/ tools/ check/ -type f -mtime -1 -print))

# Compiler Parameters
CC								= gcc
CFLAGS							= -std=gnu99 -O0 -fPIC -fmessage-length=0 -ggdb3 -rdynamic -c $(CFLAGS_WARNINGS) -MMD 
CFLAGS_WARNINGS					= -Wall -Werror -Winline -Wformat-security -Warray-bounds #-Wfatal-errors
CFLAGS_PEDANTIC					= -Wextra -Wpacked -Wunreachable-code -Wformat=2

CPP								= g++
CPPFLAGS						= -std=c++0x $(CPPFLAGS_WARNINGS) -Wno-unused-parameter -pthread -g3 
CPPFLAGS_WARNINGS				= -Werror -Wall -Wextra -Wformat=2 -Wwrite-strings -Wno-format-nonliteral #-Wfatal-errors

# Linker Parameters
LD								= gcc
LDFLAGS							= -rdynamic -shared

# Archiver Parameters
AR								= ar
ARFLAGS							= rcs

# Strip Parameters
STRIP							= strip
STRIPFLAGS						= --strip-debug

# GProf Parameters
GPROF							= -pg -finstrument-functions -fprofile-arcs -ftest-coverage

# PProf Parameters
PPROF							= -lprofiler

# Other External programs
MV								= mv --force
RM								= rm --force
RMDIR							= rmdir --parents --ignore-fail-on-non-empty
MKDIR							= mkdir --parents
RANLIB							= ranlib
INSTALL							= install

# Text Coloring
RED								= $$(tput setaf 1)
BLUE							= $$(tput setaf 4)
GREEN							= $$(tput setaf 2)
WHITE							= $$(tput setaf 7)
YELLOW							= $$(tput setaf 3)

# Text Weighting
BOLD							= $$(tput bold)
NORMAL							= $$(tput sgr0)

# Calculate the version, commit and timestamp strings.
MAGMA_REPO						= $(shell which git &> /dev/null && git log &> /dev/null && echo 1) 
ifneq ($(strip $(MAGMA_REPO)),1)
	MAGMA_VERSION				:= $(PACKAGE_VERSION)
	MAGMA_COMMIT				:= "NONE"
else
	# Add the --since='YYYY/MM/DD' or --since='TAG' to the git log command below to reset the patch version to 0.
	MAGMA_VERSION				:= $(PACKAGE_VERSION).$(shell git log --format='%H' | wc -l)
	MAGMA_COMMIT				:= $(shell git log --format="%H" -n 1 | cut -c33-40)
endif

MAGMA_TIMESTAMP					= $(shell date +'%Y%m%d.%H%M')

ifeq ($(VERBOSE),yes)
RUN								=
else
RUN								= @
VERBOSE							= no
endif

# So we can tell the user what happened
ifdef MAKECMDGOALS
TARGETGOAL						+= $(MAKECMDGOALS)
else
TARGETGOAL						= $(.DEFAULT_GOAL)
endif

ifeq ($(OS),Windows_NT)
    HOSTTYPE 					:= "Windows"
    LIBPREFIX					:= 
    DYNLIBEXT					:= ".dll"
    STATLIBEXT					:= ".lib"
    EXEEXT 						:= ".exe"
    
    # Alias the target names on Windows to the equivalent without the exe extension.
#	$(basename $(DIME_PROGRAM)) := $(DIME_PROGRAM)
	$(basename $(MAGMA_PROGRAM)) := $(MAGMA_PROGRAM)
#	$(basename $(SIGNET_PROGRAM)) := $(SIGNET_PROGRAM)
#	$(basename $(GENREC_PROGRAM)) := $(GENREC_PROGRAM)
#	$(basename $(DIME_CHECK_PROGRAM)) := $(DIME_CHECK_PROGRAM)
	$(basename $(MAGMA_CHECK_PROGRAM)) := $(MAGMA_CHECK_PROGRAM)
else
    HOSTTYPE					:= $(shell uname -s)
    LIBPREFIX					:= lib
    DYNLIBEXT					:= .so
    STATLIBEXT					:= .a
    EXEEXT						:= 
endif

all: config warning $(MAGMA_PROGRAM) #$(DIME_PROGRAM) $(SIGNET_PROGRAM) $(GENREC_PROGRAM) $(MAGMA_CHECK_PROGRAM) $(DIME_CHECK_PROGRAM) finished 

strip: config warning stripped-$(MAGMA_PROGRAM) stripped-$(MAGMA_SHARED_LIBRARY) finished
	
warning:
ifeq ($(VERBOSE),no)
	@echo 
	@echo 'For a more verbose output' 
	@echo '  make '$(GREEN)'VERBOSE=yes' $(NORMAL)$(TARGETGOAL)
	@echo 
endif

config:
	@echo 
	@echo 'TARGET' $(TARGETGOAL)
	@echo 'VERBOSE' $(VERBOSE)
	@echo 
	@echo 'VERSION ' $(MAGMA_VERSION)
	@echo 'COMMIT '$(MAGMA_COMMIT)
	@echo 'DATE ' $(MAGMA_TIMESTAMP)
	@echo 'HOST ' $(HOSTTYPE)

setup: $(PACKAGE_DEPENDENCIES)
ifeq ($(VERBOSE),no)
	@echo 'Running the '$(YELLOW)'setup'$(NORMAL)' scripts.'
endif
	$(RUN)dev/scripts/linkup.sh
ifeq ($(VERBOSE),no)
	@echo 'Generating new '$(YELLOW)'key'$(NORMAL)' files.'
endif

check: config warning $(MAGMA_CHECK_PROGRAM) $(DIME_CHECK_PROGRAM) finished
	$(RUN)$(TOPDIR)/$(MAGMA_CHECK_PROGRAM) sandbox/etc/magma.sandbox.config
	$(RUN)$(TOPDIR)/$(DIME_CHECK_PROGRAM)

gprof: $(MAGMA_PROGRAM_GPROF) $(MAGMA_CHECK_PROGRAM_GPROF)

pprof: $(MAGMA_PROGRAM_PPROF) $(MAGMA_CHECK_PROGRAM_PPROF)
  
# If verbose mode is disabled, we only output this finished message.
finished:
ifeq ($(VERBOSE),no)
	@echo 'Finished' $(BOLD)$(GREEN)$(TARGETGOAL)$(NORMAL)
endif

#incremental: $(MAGMA_INCREMENTAL_BUILD)

# Delete the compiled program along with the generated object and dependency files
clean:
	@$(RM) $(MAGMA_PROGRAM) $(DIME_PROGRAM) $(SIGNET_PROGRAM) $(GENREC_PROGRAM) $(MAGMA_CHECK_PROGRAM) $(DIME_CHECK_PROGRAM) 
	@$(RM) $(MAGMA_PROGRAM_PPROF) $(MAGMA_CHECK_PROGRAM_PPROF) $(MAGMA_PROGRAM_GPROF) $(MAGMA_CHECK_PROGRAM_GPROF)
	@$(RM) $(MAGMA_OBJFILES) $(DIME_OBJFILES) $(SIGNET_OBJFILES) $(GENREC_OBJFILES) $(MAGMA_CHECK_OBJFILES) $(DIME_CHECK_OBJFILES) $(MAGMA_PROF_OBJFILES) $(MAGMA_CHECK_PROF_OBJFILES) 
	@$(RM) $(MAGMA_DEPFILES) $(DIME_DEPFILES) $(SIGNET_DEPFILES) $(GENREC_DEPFILES) $(MAGMA_CHECK_DEPFILES) $(DIME_CHECK_DEPFILES)
	@for d in $(sort $(dir $(MAGMA_OBJFILES)) $(dir $(MAGMA_CHECK_OBJFILES)) $(dir $(DIME_OBJFILES)) $(dir $(SIGNET_OBJFILES)) $(dir $(GENREC_OBJFILES))); \
		do if test -d "$$d"; then $(RMDIR) "$$d"; fi; done
	@for d in $(sort $(dir $(MAGMA_DEPFILES)) $(dir $(MAGMA_CHECK_DEPFILES)) $(dir $(DIME_DEPFILES)) $(dir $(SIGNET_DEPFILES)) $(dir $(GENREC_DEPFILES))); \
		do if test -d "$$d"; then $(RMDIR) "$$d"; fi; done
	@echo 'Finished' $(BOLD)$(GREEN)$(TARGETGOAL)$(NORMAL)

distclean: 
	@$(RM) $(MAGMA_PROGRAM) $(DIME_PROGRAM) $(SIGNET_PROGRAM) $(GENREC_PROGRAM) $(MAGMA_CHECK_PROGRAM) $(DIME_CHECK_PROGRAM) 
	@$(RM) $(MAGMA_PROGRAM_PPROF) $(MAGMA_CHECK_PROGRAM_PPROF) $(MAGMA_PROGRAM_GPROF) $(MAGMA_CHECK_PROGRAM_GPROF) $(MAGMA_SHARED_LIBRARY)
	@$(RM) $(MAGMA_OBJFILES) $(DIME_OBJFILES) $(SIGNET_OBJFILES) $(GENREC_OBJFILES) $(MAGMA_CHECK_OBJFILES) $(DIME_CHECK_OBJFILES) $(MAGMA_PROF_OBJFILES) $(MAGMA_CHECK_PROF_OBJFILES)  
	@$(RM) $(MAGMA_DEPFILES) $(DIME_DEPFILES) $(SIGNET_DEPFILES) $(GENREC_DEPFILES) $(MAGMA_CHECK_DEPFILES) $(DIME_CHECK_DEPFILES)
	@$(RM) --recursive --force $(DEPDIR) $(OBJDIR) lib/local lib/logs lib/objects lib/sources
	@echo 'Finished' $(BOLD)$(GREEN)$(TARGETGOAL)$(NORMAL)

stripped-%: $(MAGMA_PROGRAM) $(MAGMA_SHARED_LIBRARY)
ifeq ($(VERBOSE),no)
	@echo 'Creating' $(RED)$@$(NORMAL)
else
	@echo 
endif
	$(RUN)$(STRIP) $(STRIPFLAGS) --output-format=$(shell objdump -p "$(subst stripped-,,$@)" | grep "file format" | head -1 | \
	awk -F'file format' '{print $$2}' | tr --delete [:space:]) -o "$@" "$(subst stripped-,,$@)"

install: $(MAGMA_PROGRAM) $(MAGMA_SHARED_LIBRARY)
ifeq ($(VERBOSE),no)
	@echo 'Installing' $(GREEN)$(MAGMA_PROGRAM)$(NORMAL)
endif
	$(RUN)$(INSTALL) --mode=0755 --owner=root --group=root --context=system_u:object_r:bin_t:s0 --no-target-directory \
		$(MAGMA_PROGRAM) /usr/libexec/$(MAGMA_PROGRAM)
	$(RUN)$(INSTALL) --mode=0755 --owner=root --group=root --context=system_u:object_r:bin_t:s0 --no-target-directory \
		$(MAGMA_SHARED_LIBRARY) /usr/libexec/$(MAGMA_SHARED_LIBRARY)
		
# Construct the magma daemon executable.
$(MAGMA_PROGRAM): $(PACKAGE_DEPENDENCIES) $(MAGMA_OBJFILES)
ifeq ($(VERBOSE),no)
	@echo 'Constructing' $(RED)$@$(NORMAL)
else
	@echo
endif
	$(RUN)$(LD) $(LDFLAGS) -o '$@' $(MAGMA_OBJFILES) -Wl,--start-group $(MAGMA_DYNAMIC) $(MAGMA_STATIC) -Wl,--end-group

# Construct the magma unit test executable.
$(MAGMA_CHECK_PROGRAM): $(PACKAGE_DEPENDENCIES) $(MAGMA_CHECK_OBJFILES) $(filter-out .objs/src/magma.o, $(MAGMA_OBJFILES))
ifeq ($(VERBOSE),no)
	@echo 'Constructing' $(RED)$@$(NORMAL)
endif
	$(RUN)$(LD) $(LDFLAGS) -o '$@' $(MAGMA_CHECK_OBJFILES) $(filter-out .objs/src/magma.o, $(MAGMA_OBJFILES)) -Wl,--start-group,--whole-archive $(MAGMA_CHECK_STATIC) -Wl,--no-whole-archive,--end-group $(MAGMA_CHECK_DYNAMIC) 
		
# Construct the magma daemon executable with pprof support.
$(MAGMA_PROGRAM_PPROF): $(PACKAGE_DEPENDENCIES) $(MAGMA_OBJFILES)
ifeq ($(VERBOSE),no)
	@echo 'Constructing' $(RED)$@$(NORMAL)
else
	@echo
endif
	$(RUN)$(LD) $(LDFLAGS) -o '$@' $(MAGMA_OBJFILES) -Wl,--start-group $(MAGMA_DYNAMIC) $(PPROF) $(MAGMA_STATIC) -Wl,--end-group 

# Construct the magma unit test executable with pprof support.
$(MAGMA_CHECK_PROGRAM_PPROF): $(PACKAGE_DEPENDENCIES) $(MAGMA_CHECK_OBJFILES) $(filter-out .objs/src/magma.o, $(MAGMA_OBJFILES))
ifeq ($(VERBOSE),no)
	@echo 'Constructing' $(RED)$@$(NORMAL)
endif
	$(RUN)$(LD) $(LDFLAGS) -o '$@' $(MAGMA_CHECK_OBJFILES) $(filter-out .objs/src/magma.o, $(MAGMA_OBJFILES)) -Wl,--start-group,--whole-archive $(MAGMA_CHECK_STATIC) -Wl,--no-whole-archive,--end-group $(MAGMA_CHECK_DYNAMIC) $(PPROF)

# Construct the magma daemon executable with gprof support.
$(MAGMA_PROGRAM_GPROF): $(PACKAGE_DEPENDENCIES) $(MAGMA_PROF_OBJFILES)
ifeq ($(VERBOSE),no)
	@echo 'Constructing' $(RED)$@$(NORMAL)
else
	@echo
endif
	$(RUN)$(LD) $(LDFLAGS) $(GPROF) -o '$@' $(MAGMA_PROF_OBJFILES) -Wl,--start-group $(MAGMA_DYNAMIC) $(MAGMA_STATIC) -Wl,--end-group

# Construct the magma unit test executablew with gprof support.
$(MAGMA_CHECK_PROGRAM_GPROF): $(PACKAGE_DEPENDENCIES) $(MAGMA_CHECK_PROF_OBJFILES) $(filter-out .objs/src/magma.pg.o, $(MAGMA_PROF_OBJFILES))
ifeq ($(VERBOSE),no)
	@echo 'Constructing' $(RED)$@$(NORMAL)
endif
	$(RUN)$(LD) $(LDFLAGS) $(GPROF) -o '$@' $(MAGMA_CHECK_PROF_OBJFILES) $(filter-out .objs/src/magma.pg.o, $(MAGMA_PROF_OBJFILES)) -Wl,--start-group,--whole-archive $(MAGMA_CHECK_STATIC) -Wl,--no-whole-archive,--end-group $(MAGMA_CHECK_DYNAMIC) 

# Construct the dime command line utility
$(DIME_PROGRAM): $(PACKAGE_DEPENDENCIES) $(DIME_OBJFILES) 
ifeq ($(VERBOSE),no)
	@echo 'Constructing' $(RED)$@$(NORMAL)
else
	@echo 
endif
	$(RUN)$(LD) $(LDFLAGS) -o '$@' $(DIME_OBJFILES) -Wl,--start-group,--whole-archive $(MAGMA_STATIC) $(DIME_STATIC) -Wl,--no-whole-archive,--end-group $(MAGMA_DYNAMIC) 

# Construct the signet command line utility
$(SIGNET_PROGRAM): $(PACKAGE_DEPENDENCIES) $(SIGNET_OBJFILES) 
ifeq ($(VERBOSE),no)
	@echo 'Constructing' $(RED)$@$(NORMAL)
else
	@echo 
endif
	$(RUN)$(LD) $(LDFLAGS) -o '$@' $(SIGNET_OBJFILES) -Wl,--start-group,--whole-archive $(MAGMA_STATIC) $(SIGNET_STATIC) -Wl,--no-whole-archive,--end-group $(MAGMA_DYNAMIC)

# Construct the dime command line utility
$(GENREC_PROGRAM): $(PACKAGE_DEPENDENCIES) $(GENREC_OBJFILES) 
ifeq ($(VERBOSE),no)
	@echo 'Constructing' $(RED)$@$(NORMAL)
else
	@echo 
endif
	$(RUN)$(LD) $(LDFLAGS) -o '$@' $(GENREC_OBJFILES) -Wl,--start-group,--whole-archive $(MAGMA_STATIC) $(GENREC_STATIC) -Wl,--no-whole-archive,--end-group $(MAGMA_DYNAMIC)

# Construct the dime unit test executable
$(DIME_CHECK_PROGRAM): $(PACKAGE_DEPENDENCIES) $(DIME_CHECK_OBJFILES) 
ifeq ($(VERBOSE),no)
	@echo 'Constructing' $(RED)$@$(NORMAL)
endif
	$(RUN)$(LD) $(LDFLAGS) -o '$@' $(DIME_CHECK_OBJFILES) -Wl,--start-group,--whole-archive $(DIME_CHECK_STATIC) -Wl,--no-whole-archive,--end-group $(DIME_CHECK_DYNAMIC) 

$(OBJDIR)/check/dime/%.o: check/dime/%.cpp 
ifeq ($(VERBOSE),no)
	@echo 'Building' $(YELLOW)$<$(NORMAL)
endif
	@test -d $(DEPDIR)/$(dir $<) || $(MKDIR) $(DEPDIR)/$(dir $<)
	@test -d $(OBJDIR)/$(dir $<) || $(MKDIR) $(OBJDIR)/$(dir $<)
	$(RUN)$(CPP) -o '$@' $(CPPFLAGS) $(CPPDEFINES) $(CPPFLAGS.$(<F)) $(CPPDEFINES.$(<F)) $(DIME_CHECK_CPPINCLUDES) -MF"$(<:%.cpp=$(DEPDIR)/%.d)" -MD -MP -MT"$@" -c "$<"

# The Magma Unit Test Object Files
$(OBJDIR)/check/magma/%.o: check/magma/%.c
ifeq ($(VERBOSE),no)
	@echo 'Building' $(YELLOW)$<$(NORMAL)
endif
	@test -d $(DEPDIR)/$(dir $<) || $(MKDIR) $(DEPDIR)/$(dir $<)
	@test -d $(OBJDIR)/$(dir $<) || $(MKDIR) $(OBJDIR)/$(dir $<)
	$(RUN)$(CC) -o '$@' $(CFLAGS) $(CDEFINES) $(CFLAGS.$(<F)) $(CDEFINES.$(<F)) $(MAGMA_CHECK_CINCLUDES) -MF"$(<:%.c=$(DEPDIR)/%.d)" -MT"$@" "$<"

# The Magma Daemon Object Files
$(OBJDIR)/%.o: %.c 
ifeq ($(VERBOSE),no)
	@echo 'Building' $(YELLOW)$<$(NORMAL)
endif
	@test -d $(DEPDIR)/$(dir $<) || $(MKDIR) $(DEPDIR)/$(dir $<)
	@test -d $(OBJDIR)/$(dir $<) || $(MKDIR) $(OBJDIR)/$(dir $<)
	$(RUN)$(CC) -o '$@' $(CFLAGS) $(CDEFINES) $(CFLAGS.$(<F)) $(CDEFINES.$(<F)) $(MAGMA_CINCLUDES) -MF"$(<:%.c=$(DEPDIR)/%.d)" -MT"$@" "$<"

# The Magma Unit Test Object Files (GProf Version)
$(OBJDIR)/check/magma/%.pg.o: check/magma/%.c
ifeq ($(VERBOSE),no)
	@echo 'Building' $(YELLOW)$<$(NORMAL)
endif
	@test -d $(DEPDIR)/$(dir $<) || $(MKDIR) $(DEPDIR)/$(dir $<)
	@test -d $(OBJDIR)/$(dir $<) || $(MKDIR) $(OBJDIR)/$(dir $<)
	$(RUN)$(CC) -o '$@' $(GPROF) $(CFLAGS) $(CDEFINES) $(CFLAGS.$(<F)) $(CDEFINES.$(<F)) $(MAGMA_CHECK_CINCLUDES) -MF"$(<:%.c=$(DEPDIR)/%.d)" -MT"$@" "$<"

# The Magma Daemon Object Files (GProf Version)
$(OBJDIR)/%.pg.o: %.c 
ifeq ($(VERBOSE),no)
	@echo 'Building' $(YELLOW)$<$(NORMAL)
endif
	@test -d $(DEPDIR)/$(dir $<) || $(MKDIR) $(DEPDIR)/$(dir $<)
	@test -d $(OBJDIR)/$(dir $<) || $(MKDIR) $(OBJDIR)/$(dir $<)
	$(RUN)$(CC) -o '$@' $(GPROF) $(CFLAGS) $(CDEFINES) $(CFLAGS.$(<F)) $(CDEFINES.$(<F)) $(MAGMA_CINCLUDES) -MF"$(<:%.c=$(DEPDIR)/%.d)" -MT"$@" "$<"
	
$(PACKAGE_DEPENDENCIES): 
ifeq ($(VERBOSE),no)
	@echo 'Building the '$(YELLOW)'bundled'$(NORMAL)' dependencies.'
endif
	$(RUN)dev/scripts/builders/build.lib.sh all

# If we've already generated dependency files, use them to see if a rebuild is required
-include $(MAGMA_DEPFILES) $(DIME_DEPFILES) $(SIGNET_DEPFILES) $(GENREC_DEPFILES) $(MAGMA_CHECK_DEPFILES) $(DIME_CHECK_DEPFILES)

# Special Make Directives
.SUFFIXES: .c .cc .cpp .o 
#.NOTPARALLEL: warning conifg $(PACKAGE_DEPENDENCIES)
.PHONY: all strip warning config finished check setup clean distclean install pprof gprof

# vim:set softtabstop=4 shiftwidth=4 tabstop=4:
