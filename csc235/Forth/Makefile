#Makefile for Gforth

#Copyright (C) 1995,1996,1997,1998,2000,2003,2004,2005,2006,2007,2008 Free Software Foundation, Inc.

#This file is part of Gforth.

#Gforth is free software; you can redistribute it and/or
#modify it under the terms of the GNU General Public License
#as published by the Free Software Foundation, either version 3
#of the License, or (at your option) any later version.

#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.

#You should have received a copy of the GNU General Public License
#along with this program. If not, see http://www.gnu.org/licenses/.

# To change the values of `make' variables: instead of editing Makefiles,
# (1) if the variable is set in `config.status', edit `config.status'
#     (which will cause the Makefiles to be regenerated when you run `make');
# (2) otherwise, pass the desired values on the `make' command line.

# Warning:
# For some stupid reason setting SHELL to bash does not work properly with
# DOS. If you want to use shell-specific things that must run with DOS make
# an external batch file and call it with bash (see versions.bsh).

# ------------- gforth version

VERSION	= 0.7.3
DOSVERSION=`echo $(VERSION)|sed 's/\.//g'|sed 's/-.*//g'`

# -------------	System specific variables	

machine=amd64
kernel_fi=kernl64l.fi
EXE=

# this is the type of machine
# used to extend the include path with ./arch/$machine
# so we can include a machine specific 
# machine.h file

PATHSEP = :

EC = 

# -------------	Utility programs

SHELL	= /bin/sh
RM	= rm
RMTREE	= rm -rf
CP	= cp -p
MV	= mv
TAR	= tar cf -
INSTALL	= /usr/bin/install -c
INSTALL_PROGRAM = ${INSTALL}
MASSAGE_EXE = chcon -t unconfined_execmem_exec_t
INSTALL_SCRIPT = ${INSTALL}
INSTALL_DATA = ${INSTALL} -m 644
INSTALL_INFO = /usr/bin/install-info
LN_S	= ln -s
M4      = m4 -s
GCC	= gcc
EMACS   = emacs
LIBTOOL = libtool
PREFORTH	= ./preforth -p ".$(PATHSEP)~+$(PATHSEP)$(srcdir)"
CC	= $(GCC)
FORTHPATH = .$(PATHSEP)$(libdir)/gforth/site-forth$(PATHSEP)$(siteforthdir)$(PATHSEP)$(libdir)/gforth/$(VERSION)$(PATHSEP)$(datadir)/gforth/$(VERSION)
FORTHSIZES = 
FORTHS_ARGS =  -p "$(FORTHPATH)$(PATHSEP)$(srcdir)"
FORTH_ARGS = --die-on-signal $(FORTHS_ARGS)
ENGINE = ./gforth
FORTH	= $(ENGINE) $(FORTH_ARGS)
FORTHS	= $(ENGINE) $(FORTHS_ARGS)
# the (existing) forth system to use for cross compiling and primitives tables
# per default we use the one in this directory for a rebuild. It is also
# possible to override this variable at the command line for an initial build (jaw)
BUILDFORTH = $(ENGINE) --die-on-signal -m 4M -p ".$(PATHSEP)~+$(PATHSEP)$(srcdir)" -i $(kernel_fi)
# the forth system plus flags we use to build
FORTHB = $(BUILDFORTH) exboot.fs -e 'fpath= .|~+|$(srcdir)'
# the Forth system for running prims2x.fs
FORTHP = $(FORTH)
ENGINE_FAST = ./gforth-fast
FORTH_FAST	= $(ENGINE_FAST) $(FORTH_ARGS)
FORTHKFLAGS= --die-on-signal -p ".$(PATHSEP)~+$(PATHSEP)$(srcdir)" -i $(kernel_fi)
FORTHK	= $(ENGINE) $(FORTHKFLAGS)
#FORTHP	= $(ENGINE) --die-on-signal -i ./$(kernel_fi)
#the "-2 image-included-files +!" undoes the change to image-included-files
# in exboot.fs
STARTUP	= exboot.fs startup.fs arch/amd64/asm.fs arch/amd64/disasm.fs
STRIP	= strip
TEXI2DVI = texi2dvi
TEXI2PDF = texi2dvi --pdf
DVI2PS	= dvips -t letterSize -Z
#you can get texi2html from http://wwwcn.cern.ch/dci/texi2html/
MAKEINFO = makeinfo
TEXI2HTML = texi2html

# -------------	Compiler Flags

XCFLAGS	= -O2
XDEFINES = -DHAVE_CONFIG_H
SWITCHES = $(XCFLAGS) $(XDEFINES) $(OPTDEFINES) #-DNDEBUG #turn off assertions
ENGINE_FLAGS =  -fno-gcse -fno-strict-aliasing -fno-crossjumping -fno-reorder-blocks -falign-labels=1 -falign-loops=1 -falign-jumps=1 -fno-defer-pop -fcaller-saves
DEBUGFLAG = 
CFLAGS	= $(DEBUGFLAG) -I$(srcdir)/engine -I$(srcdir)/arch/$(machine) -O3 -Wall $(SWITCHES) -DDEFAULTPATH='"$(FORTHPATH)"'
CPPFLAGS = 

#John Wavrik should use -Xlinker -N to get a writable text (executable)
XLDFLAGS =  -export-dynamic
LDFLAGS	=  $(DEBUGFLAG) $(XLDFLAGS)
LDLIBS	= -lffi -lltdl -lm 

STACK_CACHE_REGS = 1
STACK_CACHE_DEFAULT_FAST = 1

# ------------	Install Directories


prefix = /usr/local
exec_prefix = ${prefix}
srcdir = .
bindir = ${exec_prefix}/bin
#read-only architecture-independent files
datarootdir = ${prefix}/share
datadir = ${datarootdir}
#read-only architecture-dependent non-ascii files
libdir = ${exec_prefix}/lib
libccdir = $(libdir)/gforth/$(VERSION)/libcc-named/
includedir = ${prefix}/include
infodir = ${datarootdir}/info
htmldir = ${docdir}
mandir = ${datarootdir}/man
man1dir= $(mandir)/man1
man1ext= .1
#older emacses have their site-lisp in $(libdir)/emacs/
emacssitelispdir=${datadir}/emacs/site-lisp
siteforthdir=$(datadir)/gforth/site-forth

PROFOBJS = 
PROFEXES = 

INSTALLDIRS = . engine kernel doc asm ec test \
	compat unix \
	arch arch/generic arch/m68k arch/mips \
	arch/386 arch/hppa arch/sparc arch/power \
	arch/alpha arch/4stack arch/misc arch/6502 \
	arch/8086 arch/avr arch/c165 arch/h8 \
	arch/shboom arch/sharc arch/ia64 arch/amd64 \
	arch/arm arch/r8c vmgen-ex

INCLUDES = engine/forth.h engine/threaded.h engine/io.h engine/longlong.h

KERN_SRC = \
	mach16b.fs mach16l.fs mach32b.fs mach32l.fs mach64b.fs mach64l.fs \
	machpc.fs.in \
	kernel/aliases0.fs \
	kernel/aliases.fs \
	kernel/args.fs \
	kernel/cbr.fs \
	kernel/cloop.fs \
	kernel/cond.fs \
	kernel/cond-old.fs \
	cross.fs \
	kernel/errore.fs \
	kernel/files.fs \
	kernel/require.fs \
	kernel/paths.fs \
	kernel/kernel.fs \
	kernel/main.fs \
	kernel/prim0.fs \
	search.fs \
	kernel/quotes.fs \
	kernel/tools.fs \
	kernel/toolsext.fs \
	kernel/vars.fs \
	kernel/accept.fs \
	kernel/basics.fs \
	kernel/int.fs \
	kernel/comp.fs \
	kernel/io.fs \
	kernel/input.fs \
	kernel/license.fs \
	kernel/nio.fs \
	kernel/saccept.fs \
	kernel/doers.fs \
	kernel/getdoers.fs \
	kernel/pass.fs \
	kernel/xchars.fs

EC_SRC = \
	asm/README \
	asm/bitmask.fs \
	asm/numref.fs \
	chains.fs \
	asm/basic.fs \
	asm/generic.fs \
	asm/target.fs \
	ec/README \
	ec/mirror.fs \
	ec/shex.fs \
	ec/builttag.fs \
	ec/dotx.fs \
	ec/nesting.fs \
	build-ec.in

GFORTH_FI_SRC = \
	assert.fs \
	backtrac.fs \
	blocked.fb \
	blocks.fs \
	bufio.fs \
	code.fs \
	debug.fs \
	debugs.fs \
	dis-gdb.fs \
	ekey.fs \
	envos.fs \
	savesys.fs \
	environ.fs \
	errors.fs \
	exboot.fs \
	except.fs \
	extend.fs \
	float.fs \
	glocals.fs \
	hash.fs \
	history.fs \
	intcomp.fs \
	mkdir.fs \
	libcc.fs \
	locals.fs \
	look.fs \
	mkdir.fs \
	quotes.fs \
	search.fs \
	see.fs \
	see-ext.fs \
	simp-see.fs \
	source.fs \
	startup.fs \
	struct.fs \
	struct0x.fs \
	stuff.fs \
	tasker.fs \
	termsize.fs \
	utf-8.fs \
	vt100.fs \
	vt100key.fs \
	wordinfo.fs \
	arch/386/asm.fs arch/386/disasm.fs \
	arch/amd64/asm.fs arch/amd64/disasm.fs \
	arch/alpha/asm.fs arch/alpha/disasm.fs arch/alpha/testasm.fs\
	arch/mips/asm.fs arch/mips/disasm.fs arch/mips/insts.fs \
	arch/mips/testasm.fs arch/mips/testdisasm.fs \
	arch/power/asm.fs arch/power/disasm.fs arch/power/inst.fs

LIBCC_SRC = cstr.fs unix/socket.fs

LIBCC_DIST_SRC = libffi.fs fflib.fs $(LIBCC_SRC)

LIBCC_BUILD_SRC =  libffi.fs $(LIBCC_SRC)

FORTH_SRC = $(KERN_SRC) $(GFORTH_FI_SRC) $(EC_SRC) $(LIBCC_DIST_SRC) \
	ans-report.fs ansi.fs answords.fs \
	colorize.fs comp-i.fs complex.fs \
	depth-changes.fs dosekey.fs doskey.fs ds2texi.fs \
	envos.dos envos.os2 etags.fs fft.fs filedump.fs fi2c.fs \
	fsl-util.4th glosgen.fs gray.fs httpd.fs install-tags.fs \
	make-app.fs doc/makedoc.fs locate.fs more.fs onebench.fs \
	other.fs prims2x.fs prims2x0.6.2.fs proxy.fs random.fs \
	regexp.fs sokoban.fs string.fs table.fs tags.fs \
	tt.fs \
	unbuffer.fs wordsets.fs xwords.fs \
	test/tester.fs test/ttester.fs \
	test/coretest.fs test/postpone.fs test/dbltest.fs \
	test/string.fs test/float.fs test/search.fs test/gforth.fs \
	test/other.fs test/signals.fs test/checkans.fs \
	test/primtest.fs test/coreext.fs test/deferred.fs \
	test/coremore.fs test/gforth-nofast.fs test/libcc.fs \
	bubble.fs siev.fs matrix.fs fib.fs \
	oof.fs oofsampl.fs objects.fs objexamp.fs mini-oof.fs moof-exm.fs \
	moofglos.fs fixpath.fs \
	add.fs lib.fs oldlib.fs sieve.fs \
	endtry-iferror.fs recover-endtry.fs

COMPAT = compat/README \
	compat/anslocal.fs \
	compat/assert.fs \
	compat/control.fs \
	compat/defer.fs \
	compat/exception.fs \
	compat/execute-parsing.fs \
	compat/loops.fs \
	compat/required.fs \
	compat/strcomp.fs \
	compat/struct.fs \
	compat/vocabulary.fs

GFORTH_TEXI =  doc/gforth.texi doc/version.texi

VMGEN_TEXI = doc/vmgen.texi doc/version.texi doc/fdl.texi

ALLSUBDIRS = engine

ARCHS =	\
	arch/generic/machine.h \
	arch/m68k/machine.h \
	arch/mips/machine.h \
	arch/386/machine.h \
	arch/hppa/machine.h \
	arch/hppa/cache.c \
	arch/sparc/machine.h \
	arch/power/machine.h \
	arch/power/_sync_cache_range.c \
	arch/alpha/machine.h \
	arch/arm/machine.h \
	arch/arm/cacheflush0.c \
	arch/arm/cacheflush-linux.c \
	arch/ia64/machine.h \
	arch/ia64/flush_icache_block.c \
	arch/amd64/machine.h \
	arch/4stack/README \
	arch/4stack/asm.fs \
	arch/4stack/mach.fs \
	arch/4stack/prim.fs \
	arch/4stack/mach.sh \
	arch/4stack/relocate.fs \
	arch/misc/README \
	arch/misc/asm.fs \
	arch/misc/mach.fs \
	arch/misc/optcmove.fs \
	arch/misc/prim.fs \
	arch/misc/sim.fs \
	arch/misc/sokoban.fs \
	arch/misc/tt.fs \
	arch/6502/prim.fs \
	arch/6502/mach.fs \
	arch/shboom/asm.fs \
	arch/shboom/compiler.fs \
	arch/shboom/dis.fs \
	arch/shboom/mach.fs \
	arch/shboom/prim.fs \
	arch/shboom/dis2.fs \
	arch/shboom/sh.p \
	arch/shboom/doers.fs \
	arch/sharc/mach.fs \
	arch/sharc/machine.h \
	arch/sharc/compile.sharc \
	arch/sharc/systypes.h \
	arch/sharc/types.h \
	arch/sharc/g21k-3.3.4-bp1.diff \
	arch/r8c/asm.fs \
	arch/r8c/mach.fs \
	arch/r8c/prim.fs

#not included in distribution until distribution terms are included:
ARCHS_NO_DIST = \
	arch/6502/asm.fs \
	arch/6502/cold.fs \
	arch/6502/softuart.fs \
	arch/6502/zero.fs \
	arch/8086/asm.fs \
	arch/8086/mach.fs \
	arch/8086/mach.sh \
	arch/8086/prim.fs \
	arch/avr/asm.fs \
	arch/c165/asm.fs \
	arch/c165/mach.fs \
	arch/c165/prim.fs \
	arch/h8/asm.fs \
	arch/r8c/asm-test.fs \
	arch/r8c/errors.fs \
	arch/r8c/lauflicht.fs \
	arch/r8c/tasker.fs \
	arch/r8c/terminal.fs \
	arch/r8c/tt.fs \
	arch/sharc/unistd.h

VMGEN_EX = vmgen-ex/Makefile vmgen-ex/README vmgen-ex/disasm.c \
	vmgen-ex/engine.c vmgen-ex/fib.mini \
	vmgen-ex/mini-inst.vmg vmgen-ex/mini-super.vmg vmgen-ex/mini.h \
	vmgen-ex/mini.l vmgen-ex/mini.y vmgen-ex/peephole-blacklist \
	vmgen-ex/peephole.c vmgen-ex/profile.c vmgen-ex/seq2rule.awk \
	vmgen-ex/simple.mini vmgen-ex/stat.awk vmgen-ex/support.c \
	vmgen-ex/test.mini vmgen-ex/test.out

VMGEN_EX2 = $(VMGEN_EX:vmgen-ex/%=vmgen-ex2/%)

ENGINE_SOURCES = engine/Makefile.in engine/config.h.in \
	engine/engine.c engine/main.c \
	engine/io.c engine/support.c engine/signals.c engine/libcc.h.in \
	engine/profile.c engine/128bit.h \
	engine/getopt.c engine/getopt1.c engine/getopt.h engine/select.c \
	engine/ecvt.c engine/memcmp.c engine/rint.c \
	engine/strtol.c engine/strtoul.c \
	engine/ansidecl.h engine/memmove.c \
	engine/pow10.c engine/atanh.c engine/cleanalign.c \
	engine/strerror.c engine/strsignal.c engine/dblsub.c \
	engine/fnmatch.h engine/fnmatch.c \
	engine/makefile.dos engine/makefile.os2

SOURCES	= $(ENGINE_SOURCES) compat Makefile.in Makedist.in \
	gforthmi.in vmgen.in preforth.in gfgen README.vmgen NEWS.vmgen \
	autogen.sh configure.in configure config.sub config.guess \
	elisp-comp missing stamp-h.in envos.fs.in \
	iss.sh install-sh INSTALL INSTALL.BINDIST NEWS README ToDo BUGS \
	BUILD-FROM-SCRATCH model \
	COPYING COPYING.LIB COPYING.DOC AUTHORS ChangeLog Benchres aclocal.m4 \
	doc/gforth.ds doc/gforth.1 doc/version.texi.in \
	doc/vmgen.texi doc/fdl.texi doc/gpl.texi \
	gforth.el \
	$(ARCHS) \
	INSTALL.DOS makefile.dos mkdosmf.sed config.bat \
	dosconf.h gforthmi.bat mkinstalldirs siteinit.fs \
	versions.bsh \
	configure.cmd mkos2mf.sed os2conf.h makefile.os2 \
	gforthmi.cmd glosgen.glo doc/glossaries.doc \
	$(INCLUDES) $(FORTH_SRC) $(COMPAT) $(VMGEN_EX) $(VMGEN_EX2) \
	timings.sc \
	test/coretest.out test/checkans.out test/gforth.out \
	cache*.vmg peeprules.vmg prim

RCS_FILES =  ToDo model high-level

ENGINES = gforth$(EC)$(EXE) gforth-ditc$(EC)$(EXE) gforth-itc$(EC)$(EXE) $(PROFEXES)

ENGINES_FAST = gforth-fast$(OPT)$(EC)$(EXE) #gforth-native$(OPT)$(EC)$(EXE) 

GEN = $(ENGINES) $(ENGINES_FAST) gforth.elc

# things that need a working forth system to be generated
FORTH_GEN_ENGINE=engine/prim.i engine/prim_lab.i engine/prim_names.i \
	engine/prim_superend.i engine/profile.i \
	engine/prim_num.i engine/prim_grp.i \
	engine/costs.i engine/super2.i
FORTH_GEN_ENGINE_FAST= \
	engine/prim-fast.i engine/prim_lab-fast.i engine/prim_names-fast.i \
	engine/prim_superend-fast.i engine/profile-fast.i \
	engine/prim_num-fast.i engine/prim_grp-fast.i \
	engine/costs-fast.i engine/super2-fast.i
FORTH_GEN_PRIMB = $(FORTH_GEN_ENGINE) kernel/aliases.fs kernel/prim.fs
FORTH_GEN0 = prim.b $(FORTH_GEN_PRIMB)
FORTH_GEN =  $(FORTH_GEN0) kernl16l.fi kernl16b.fi kernl32l.fi kernl32b.fi kernl64l.fi kernl64b.fi gforth.fi
# this is used for antidependences,
FORTH_GEN1 = $(FORTH_GEN0) kernl64l.fi build-ec

#kernel dependencies
KERN_DEPS = $(KERN_SRC) kernel/version.fs machpc.fs $(FORTH_GEN0) compat/strcomp.fs

#distributed documentation
DOCDIST = doc/gforth.info doc/gforth.info-* doc/gforth.ps \
	  doc/vmgen.info doc/vmgen.ps

BKERNLS = kernl16b$(EC).fi kernl16l$(EC).fi \
	  kernl32b$(EC).fi kernl32l$(EC).fi \
	  kernl64b$(EC).fi kernl64l$(EC).fi

KERNLS = kernl16b$(EC).fi- kernl16l$(EC).fi- \
	 kernl32b$(EC).fi- kernl32l$(EC).fi- \
	 kernl64b$(EC).fi- kernl64l$(EC).fi-

# -------------        Make forth images
GEN_PRECIOUS = $(FORTH_GEN) $(KERNLS) \
	doc/gforth.texi doc/gforth.dvi doc/gforth.ps \
	doc/vmgen.dvi doc/vmgen.ps \
	Makefile Makedist engine/Makefile configure

#standards.info recommends this:
.SUFFIXES:
.SUFFIXES: .c .o

all: kernel/version.fs more check

# use this dependency for phony targets just as mostlyclean,...
FORCE: ;

#this rule avoids remaking everything after minor changes in Makefile.in
version:	Makefile.in configure.in
		if test -r $@ && test x'$(VERSION)' = x`cat $@` ; then true ; else echo $(VERSION) > $@ ; fi

# With dos we use normal dos echo
# we cannot pipe the output to engine/version.h directly because
# of the "/ and \" problem. Copying works because we use the
# shell und file utilities.

kernel/version.fs:	version
	echo ": version-string s\" $(VERSION)\" ;" > kernel/version.fs

more:	$(ENGINES) $(FORTH_GEN) $(GEN) build-libcc-named

#from the gcc Makefile: 
#"Deletion of files made during compilation.
# There are four levels of this:
#   `mostlyclean', `clean', `distclean' and `realclean'.
# `mostlyclean' is useful while working on a particular type of machine.
# It deletes most, but not all, of the files made by compilation.
# It does not delete libgcc.a or its parts, so it won't have to be recompiled.
# `clean' deletes everything made by running `make all'.
# `distclean' also deletes the files made by config.
# `realclean' also deletes everything that could be regenerated automatically."

mostlyclean:	FORCE
		-$(RM) -rf engine/*.s gforth.fi *.fi~ *.fi- kernel/version.fs \
		*TAGS gforth~ \
		doc/crossdoc.fd doc/doc.fd doc/gforth.texi doc/gforth.fns \
		doc/gforth.aux doc/gforth.cp doc/gforth.cps \
		doc/gforth.dvi doc/gforth.fn doc/gforth.ky doc/gforth.log \
		doc/gforth.pg \
		doc/gforth.toc doc/gforth.tp doc/gforth.vr html \
		gforth-$(VERSION).tar.gz

# Just the stuff needed to rebuild the documentation nac03feb1999
docclean:	FORCE
		-$(RM) -rf doc/crossdoc.fd doc/doc.fd doc/gforth.texi doc/gforth.fns \
		doc/gforth.aux doc/gforth.cp doc/gforth.cps \
		doc/gforth.dvi doc/gforth.fn doc/gforth.ky doc/gforth.log \
		doc/gforth.pg \
		doc/gforth.toc doc/gforth.tp doc/gforth.vr html

clean:		mostlyclean
	-$(RM) -rf $(GEN) *.o engine/*.o arch/*/*.o version \
	gforth-itc-noll$(EC)$(EXE)  engine/gforth-itc-noll$(EC)$(EXE)  \
	gforth-ditc-noll$(EC)$(EXE) engine/gforth-ditc-noll$(EC)$(EXE) \
	gforth-prof-noll$(EC)$(EXE) engine/gforth-prof-noll$(EC)$(EXE) \
	engine/prim-s.i
	for i in gforth gforth-fast gforth-native; do for j in $(OPTS); do rm -f engine/$$i$${j}$(EC)$(EXE) $$i$${j}$(EC)$(EXE); done; done

distclean:	clean
		-$(RM) -rf config.cache config.log config.status \
		engine/config.h Makefile Makedist engine/Makefile \
		stamp-h engine/stamp-h \
		doc/version.texi gforthmi vmgen preforth \
		prim-fast.b $(FORTH_GEN_ENGINE_FAST)

#realclean is useless, but dangerous, so it's commented out
realclean:	distclean
		-$(RM) -rf $(GEN_PRECIOUS) `cat .cvsignore`

#mostlyclean, but also remove some of the stuff that is distributed
virtualclean:	mostlyclean
		-$(RM) -rf gforth.fns gforth.texi gforth.ps gforth.info* \
		gforth-$(VERSION).tar.gz config.cache *~ */*~

maintainer-clean: realclean

#Some makes (Ultrix, SunOS, IRIX) are so broken, they cannot read the
#Makefile if it contains our dist rules.  Therefore we have put these
#rules in Makedist (you can use them with GNU make on these systems).

dist:		Makedist FORCE
		$(MAKE) -f Makedist d$@

dosdist:	Makedist FORCE
		$(MAKE) -f Makedist d$@

srcdist:	Makedist FORCE
		$(MAKE) -f Makedist d$@

srconlydist:	Makedist FORCE
		$(MAKE) -f Makedist d$@

docdist:	Makedist FORCE
		$(MAKE) -f Makedist d$@

htmldist:	Makedist FORCE
		$(MAKE) -f Makedist d$@

bindist:	Makedist FORCE
		$(MAKE) -f Makedist d$@

binonlydist:	Makedist FORCE
		$(MAKE) -f Makedist d$@

#HPUX make breaks the cycle differently when the dates are equal, so
# touch some of the files if it acts up
hpux-workaround:
	touch $(FORTH_GEN_PRIMB)

#strip gforth, because the debugging stuff is hardly useful once
# gforth manages to execute more than a few primitives.

#install does not depend on gforth.info, because that would require
#supplying a lot of files that can be easily generated (only info is
#hard to generate).
#we rebuild gforth.fi, because it contains some path names.
#we delete $build/gforth.fi and $build/install.TAGS after installation because of ownership.
install:	gforth$(EC)$(EXE) $(FORTH_SRC) $(kernel_fi) gforth.fi gforthmi vmgen doc/gforth.1 prim install.TAGS installdirs
		$(NORMAL_INSTALL)
		touch $(DESTDIR)$(siteforthdir)/siteinit.fs
		-$(RM) $(DESTDIR)$(bindir)/gforth$(EC)$(EXE) $(DESTDIR)$(bindir)/gforth-$(VERSION)$(EC)$(EXE) $(DESTDIR)$(bindir)/gforthmi $(DESTDIR)$(bindir)/vmgen
		-$(RM) $(DESTDIR)$(bindir)/gforth-fast$(EC)$(EXE) $(DESTDIR)$(bindir)/gforth-fast-$(VERSION)$(EC)$(EXE)
		-$(RM) $(DESTDIR)$(bindir)/gforth-itc$(EC)$(EXE) $(DESTDIR)$(bindir)/gforth-itc-$(VERSION)$(EC)$(EXE)
		$(INSTALL_PROGRAM) gforth$(EC)$(EXE) $(DESTDIR)$(bindir)/gforth-$(VERSION)$(EC)$(EXE)
		-$(MASSAGE_EXE) $(DESTDIR)$(bindir)/gforth-$(VERSION)$(EC)$(EXE)
		(cd $(DESTDIR)$(bindir) && $(LN_S) gforth-$(VERSION)$(EC)$(EXE) gforth$(EC)$(EXE))
		$(INSTALL_PROGRAM) gforth-fast$(EC)$(EXE) $(DESTDIR)$(bindir)/gforth-fast-$(VERSION)$(EC)$(EXE)
		-$(MASSAGE_EXE) $(DESTDIR)$(bindir)/gforth-fast-$(VERSION)$(EC)$(EXE)
		(cd $(DESTDIR)$(bindir) && $(LN_S) gforth-fast-$(VERSION)$(EC)$(EXE) gforth-fast$(EC)$(EXE))
		$(INSTALL_PROGRAM) gforth-itc$(EC)$(EXE) $(DESTDIR)$(bindir)/gforth-itc-$(VERSION)$(EC)$(EXE)
		(cd $(DESTDIR)$(bindir) && $(LN_S) gforth-itc-$(VERSION)$(EC)$(EXE) gforth-itc$(EC)$(EXE))
		$(INSTALL_SCRIPT) gforthmi $(DESTDIR)$(bindir)/gforthmi-$(VERSION)
		$(INSTALL_SCRIPT) vmgen $(DESTDIR)$(bindir)/vmgen-$(VERSION)
		$(INSTALL_PROGRAM) gforth-ditc $(DESTDIR)$(libdir)/gforth/$(VERSION)
		(cd $(DESTDIR)$(bindir) && $(LN_S) gforthmi-$(VERSION) gforthmi)
		(cd $(DESTDIR)$(bindir) && $(LN_S) vmgen-$(VERSION) vmgen)
		-$(INSTALL_DATA) $(srcdir)/doc/gforth.1 $(DESTDIR)$(man1dir)
		-for i in $(srcdir)/doc/gforth.info* $(srcdir)/doc/vmgen.info*; do $(INSTALL_DATA) $$i $(DESTDIR)$(infodir); done
		for i in $(FORTH_SRC) $(COMPAT) prim; do \
			$(INSTALL_DATA) $(srcdir)/$$i $(DESTDIR)$(datadir)/gforth/$(VERSION)/$$i; \
		done
		$(INSTALL_DATA) $(kernel_fi) $(DESTDIR)$(datadir)/gforth/$(VERSION)
		@if test -d "$(DESTDIR)$(emacssitelispdir)"; then \
			$(INSTALL_DATA) gforth.el $(DESTDIR)$(emacssitelispdir); \
			$(INSTALL_DATA) gforth.elc $(DESTDIR)$(emacssitelispdir); \
		else \
			echo '>>>>>Please install gforth.{el,elc} in your .../emacs/site-lisp directory'; \
		fi
		$(INSTALL_DATA) gforth.fi $(DESTDIR)$(libdir)/gforth/$(VERSION)
		$(INSTALL_DATA) install.TAGS $(DESTDIR)$(datadir)/gforth/$(VERSION)/TAGS
		$(INSTALL_DATA) include/gforth/$(VERSION)/* $(DESTDIR)$(includedir)/gforth/$(VERSION)
		if test -n "$(LIBTOOL)"; then for i in $(LIBCC_BUILD_SRC); do \
		   $(LIBTOOL) --silent --mode=install $(INSTALL) lib/gforth/$(VERSION)/libcc-named/`basename $$i .fs`.la $(DESTDIR)$(libccdir)`basename $$i .fs`.la; \
		done; fi
		$(POST_INSTALL)
		$(INSTALL_INFO) --info-dir=$(DESTDIR)$(infodir) $(DESTDIR)$(infodir)/gforth.info
		$(INSTALL_INFO) --info-dir=$(DESTDIR)$(infodir) $(DESTDIR)$(infodir)/vmgen.info

install-strip:	install

installdirs:	mkinstalldirs
		$(NORMAL_INSTALL)
		for i in $(bindir) $(man1dir) $(infodir) $(libdir)/gforth/$(VERSION) $(datadir)/gforth/$(VERSION) $(libdir)/gforth/site-forth $(siteforthdir) $(includedir)/gforth/$(VERSION) $(libccdir); do \
			$(srcdir)/mkinstalldirs $(DESTDIR)$$i; \
		done
		for i in $(INSTALLDIRS); do \
			$(srcdir)/mkinstalldirs $(DESTDIR)$(datadir)/gforth/$(VERSION)/$$i; \
		done
		$(RM) -rf $(DESTDIR)$(datadir)/gforth/$(VERSION)/engine

#deinstall all files specific to this version of gforth
#to uninstall version foo, type `make uninstall VERSION=foo'
uninstall:	FORCE
		$(NORMAL_UNINSTALL)
		-$(RM) -rf $(DESTDIR)$(libdir)/gforth/$(VERSION) $(DESTDIR)$(datadir)/gforth/$(VERSION) $(DESTDIR)$(bindir)/gforth-$(VERSION)$(EC)$(EXE) $(DESTDIR)$(bindir)/gforth-fast-$(VERSION)$(EC)$(EXE) $(DESTDIR)$(bindir)/gforth-itc-$(VERSION)$(EC)$(EXE) $(DESTDIR)$(bindir)/gforthmi-$(VERSION) $(DESTDIR)(bindir)/vmgen-$(VERSION) $(DESTDIR)$(includedir)/gforth/$(VERSION)
		@echo -e "To remove Gforth completely, type\n$(RM) -rf $(DESTDIR)$(bindir)/gforth$(EC)$(EXE) $(DESTDIR)$(bindir)/gforth-fast$(EC)$(EXE) $(DESTDIR)$(bindir)/gforth-itc$(EC)$(EXE) $(DESTDIR)$(bindir)/gforthmi $(DESTDIR)$(bindir)/vmgen $(DESTDIR)$(man1dir)/gforth.1 $(DESTDIR)$(infodir)/gforth.info* $(DESTDIR)$(datadir)/gforth $(DESTDIR)$(libdir)/gforth"

build-libcc-named: $(LIBCC_BUILD_SRC) $(FORTH_GEN) $(GEN) FORCE
		$(RMTREE) lib/gforth/$(VERSION)/libcc-named/
		for i in $(LIBCC_BUILD_SRC); do ./gforth -e "s\" `pwd`/lib/gforth/$(VERSION)/libcc-named/\" libcc-named-dir-v 2! libcc-path clear-path libcc-named-dir libcc-path also-path :noname 2drop s\" $(libccdir)\" ; is replace-rpath" $(srcdir)/$$i -e bye; done

check:		gforths	gforth.fi 
		$(MAKE) checkone check-nofast ENGINE="./gforth --no-dynamic" >/dev/null 2>&1
		$(MAKE) checkone check-nofast ENGINE="./gforth-itc" >/dev/null 2>&1
		$(MAKE) checkone check-nofast ENGINE="./gforth-ditc" >/dev/null 2>&1
		$(MAKE) checkone ENGINE="./gforth-fast --no-dynamic" >/dev/null 2>&1
		$(MAKE) checkone check-nofast ENGINE="./gforth" >/dev/null 2>&1
		$(MAKE) checkone ENGINE="./gforth-fast" >/dev/null 2>&1
		@echo "*** Check successful ***"
		./gforth-fast --diag -e bye

checkone test: gforth.fi engine/prim-s.i
		$(FORTH) test/tester.fs test/coretest.fs test/postpone.fs test/dbltest.fs test/string.fs test/float.fs test/deferred.fs test/coreext.fs test/search.fs -e bye 2>&1 | tr -d '\015' | diff -c - $(srcdir)/test/coretest.out
		$(FORTH) test/other.fs -e bye
		$(FORTHS) test/signals.fs -e bye
		$(FORTHS) test/coremore.fs test/gforth.fs -e bye 2>&1 | tr -d '\015' | diff -c - $(srcdir)/test/gforth.out
		$(FORTH) code.fs test/checkans.fs -e bye | tr -d '\015' | diff -c - $(srcdir)/test/checkans.out
		$(FORTH) prims2x.fs -e \
		  "c-flag on s\" prim.i\" out-filename 2! s\" $(srcdir)/prim.b\" ' output-c ' output-c-combined process-file bye"| \
		  tr -d '\015' | grep -v '^#line '|diff -c - engine/prim-s.i

check-nofast: gforth.fi
		$(FORTHS) test/gforth-nofast.fs -e bye

test/primtest.fi: test/primtest.fs mach32l.fs cross.fs
		$(FORTHB) -e 's" mach32l.fs"' $(srcdir)/test/primtest.fs -e "save-cross $@ $(bindir)/gforth-$(VERSION) bye"

primtest:	gforth gforth-native test/primtest.fi FORCE
		(echo rs|ENVVAR=bla ./gforth -i test/primtest.fi) && (echo rs|ENVVAR=bla ./gforth-native -i test/primtest.fi); echo $$?

bench:		gforth-fast$(EC)$(EXE) gforth.fi
		@echo 'Each benchmark takes about 30s on a 486-66 (gcc-2.6.3 -DFORCE_REG)'
		time $(FORTH_FAST) siev.fs -e "main bye"
		time $(FORTH_FAST) bubble.fs -e "main bye"
		time $(FORTH_FAST) matrix.fs -e "main bye"
		time $(FORTH_FAST) fib.fs -e "main bye"

onebench one-bench:
	$(FORTH_FAST) onebench.fs

all-bench allbench:
	./gforth-fast --dynamic onebench.fs
	./gforth-fast --no-dynamic onebench.fs
	./gforth --dynamic onebench.fs
	./gforth --no-dynamic onebench.fs
	./gforth-itc onebench.fs
	./gforth-ditc onebench.fs

# -------------	Make forth images

# How to make new images:
# 1. Produce an image called kernlXYZ.fi-
#    the original kernel.fi is not touched because it's needed for creation
# 2. copy old kernlXYZ.fi to kernlXYZ.fi~
#    that's a backup copy in case the new kernels don't work
# 3. copy new kernels to kernlXYZ.fi
#    these are the ones we want to use now

kernl16l$(EC).fi-:	$(KERN_DEPS) mach16l.fs
		$(PREFORTH) -e 's" mach16l.fs"' $(srcdir)/kernel/main.fs -e "save-cross kernl16l$(EC).fi- $(bindir)/gforth-$(VERSION) bye"

kernl16b$(EC).fi-:	$(KERN_DEPS) mach16b.fs
		$(PREFORTH) -e 's" mach16b.fs"' $(srcdir)/kernel/main.fs -e "save-cross kernl16b$(EC).fi- $(bindir)/gforth-$(VERSION) bye"

kernl32l$(EC).fi-:	$(KERN_DEPS) mach32l.fs
		$(PREFORTH) -e 's" mach32l.fs"' $(srcdir)/kernel/main.fs -e "save-cross kernl32l$(EC).fi- $(bindir)/gforth-$(VERSION) bye"

kernl32b$(EC).fi-:	$(KERN_DEPS) mach32b.fs
		$(PREFORTH) -e 's" mach32b.fs"' $(srcdir)/kernel/main.fs -e "save-cross kernl32b$(EC).fi- $(bindir)/gforth-$(VERSION) bye"

kernl64l$(EC).fi-:	$(KERN_DEPS) mach64l.fs
		$(PREFORTH) -e 's" mach64l.fs"' $(srcdir)/kernel/main.fs -e "save-cross kernl64l$(EC).fi- $(bindir)/gforth-$(VERSION) bye"

kernl64b$(EC).fi-:	$(KERN_DEPS) mach64b.fs
		$(PREFORTH) -e 's" mach64b.fs"' $(srcdir)/kernel/main.fs -e "save-cross kernl64b$(EC).fi- $(bindir)/gforth-$(VERSION) bye"

#Solaris make does not like that:
kernl-%.fi:	arch/%/mach.fs arch/%/prim.fs arch/%/asm.fs $(KERN_SRC) kernel/version.fs $(FORTH_GEN0)
		$(PREFORTH) -e 's" $<"' $(srcdir)/kernel/main.fs -e "save-cross $@- $(bindir)/gforth-$(VERSION) bye"
		if [ -f `echo $< | sed s/fs/sh/` ]; \
		then sh `echo $< | sed s/fs/sh/` $@; \
		else $(CP) $@- $@; \
		fi

#SunOS make does not like that
#arch/%/mach.fs:	arch/%/prim.fs arch/%/asm.fs

kernl16b$(EC).fi:	$(KERNLS)
		-$(CP) kernl16b$(EC).fi kernl16b$(EC).fi~
		-$(CP) kernl16b$(EC).fi- kernl16b$(EC).fi

kernl16l$(EC).fi:	$(KERNLS)
		-$(CP) kernl16l$(EC).fi kernl16l$(EC).fi~
		-$(CP) kernl16l$(EC).fi- kernl16l$(EC).fi

kernl32b$(EC).fi:	$(KERNLS)
		-$(CP) kernl32b$(EC).fi kernl32b$(EC).fi~
		-$(CP) kernl32b$(EC).fi- kernl32b$(EC).fi

kernl32l$(EC).fi:	$(KERNLS)
		-$(CP) kernl32l$(EC).fi kernl32l$(EC).fi~
		-$(CP) kernl32l$(EC).fi- kernl32l$(EC).fi

kernl64b$(EC).fi:	$(KERNLS)
		-$(CP) kernl64b$(EC).fi kernl64b$(EC).fi~
		-$(CP) kernl64b$(EC).fi- kernl64b$(EC).fi

kernl64l$(EC).fi:	$(KERNLS)
		-$(CP) kernl64l$(EC).fi kernl64l$(EC).fi~
		-$(CP) kernl64l$(EC).fi- kernl64l$(EC).fi

#kernl%.fi:	kernl%.fi- $(KERNLS)
#		-$(CP) $@ $@~
#		-$(CP) $< $@

gforth.fi:	$(kernel_fi) gforthmi gforth-ditc$(EC)$(EXE) $(GFORTH_FI_SRC) comp-i.fs
		GFORTHD="./gforth-ditc -p .$(PATHSEP)$(srcdir)" GFORTH="./gforth-ditc --die-on-signal -p .$(PATHSEP)$(srcdir) -i $(kernel_fi) $(STARTUP)" includedir=`pwd`/include bindir=`pwd` libccdir=`pwd`/lib/gforth/$(VERSION)/libcc-named/ ./gforthmi gforth.fi $(FORTHSIZES) $(FORTHKFLAGS) $(STARTUP)

# -------------	Make c-engine

prim.b:		prim cache0.vmg
		(cd $(srcdir) && $(M4) -Dcondbranch_opt=0 prim) >$@
		sleep 1 #should make hpux-workaround unnecessary

prim-fast.b:	prim cache-fast$(STACK_CACHE_DEFAULT_FAST).vmg cache-regs$(STACK_CACHE_REGS).vmg peeprules.vmg Makefile
		(cd $(srcdir) && $(M4) -Dcondbranch_opt=1 -DSTACK_CACHE_FILE=cache-fast$(STACK_CACHE_DEFAULT_FAST).vmg -DSTACK_CACHE_REGS=cache-regs$(STACK_CACHE_REGS).vmg prim) >$@
		sleep 1 #should make hpux-workaround unnecessary

$(FORTH_GEN_ENGINE_FAST): prim-fast.b prims2x.fs
		GFORTH="$(PREFORTH)" $(srcdir)/gfgen -fast

$(FORTH_GEN_ENGINE): prim.b prims2x.fs
		GFORTH="$(PREFORTH)" $(srcdir)/gfgen

engine/prim-s.i: engine/prim.i
	grep -v '^#line ' $(srcdir)/engine/prim.i >$@

kernel/aliases.fs:	prim.b prims2x.fs kernel/aliases0.fs
		$(CP) kernel/aliases0.fs $@-
		$(PREFORTH) prims2x.fs -e "forth-flag on s\" prim.b\" ' output-alias ' noop process-file bye" >>$@-
		$(CP) $@- $@
		$(RM) $@-

kernel/prim.fs:	prim.b prims2x.fs kernel/prim0.fs
		$(CP) kernel/prim0.fs kernel/prim.fs-
		$(PREFORTH) prims2x.fs -e "forth-flag on s\" prim.b\" ' output-forth ' output-forth-combined process-file bye" >>$@-
		$(CP) $@- $@
		$(RM) $@-


OPTS =  -ll-reg -noll-reg -ll -noll

MAKELINE-ll-reg   = OPT=-ll-reg OPTDEFINES="-DFORCE_LL -DFORCE_REG" OPTOBJECTS=
MAKELINE-noll-reg = OPT=-noll-reg OPTDEFINES=-DFORCE_REG OPTOBJECTS=dblsub.o
MAKELINE-ll       = OPT=-ll OPTDEFINES=-DFORCE_LL OPTOBJECTS=
MAKELINE-noll     = OPT=-noll OPTDEFINES= OPTOBJECTS=dblsub.o

gforth$(OPT)$(EC)$(EXE): $(ENGINE_SOURCES) $(FORTH_GEN_ENGINE) engine/config.h 
	if test -z "$(OPT)"; then \
		for i in $(OPTS); do $(MAKE) optgforth OPT=$$i && $(CP) gforth$${i}$(EC)$(EXE) $@ && break; done; \
	else \
		( cd engine && $(MAKE) $@ ) && \
		$(CP) engine/$@ $@ && \
		$(MASSAGE_EXE) $@; \
		true; \
		$(MAKE) checkone check-nofast ENGINE=./engine/$@; \
	fi

optgforth:
	$(MAKE) gforth$(OPT)$(EC)$(EXE) $(MAKELINE$(OPT))

gforth-fast$(OPT)$(EC)$(EXE): $(ENGINE_SOURCES) $(FORTH_GEN_ENGINE_FAST) engine/config.h
	if test -z "$(OPT)"; then \
		for i in $(OPTS); do $(MAKE) optgforth-fast OPT=$$i && $(CP) gforth-fast$${i}$(EC)$(EXE) $@ && break; done; \
	else \
		( cd engine && $(MAKE) $@ ) && \
		$(CP) engine/$@ $@ && \
		$(MASSAGE_EXE) $@; \
		true; \
		$(MAKE) checkone ENGINE=./engine/$@; \
	fi

optgforth-fast:
	$(MAKE) gforth-fast$(OPT)$(EC)$(EXE) $(MAKELINE$(OPT))

gforth-native$(OPT)$(EC)$(EXE):	engines-fast
		$(CP) engine/$@ $@
		-$(MASSAGE_EXE) $@
#@GFORTHX_EXE@

gforth-itc$(EC)$(EXE): $(ENGINE_SOURCES) $(FORTH_GEN_ENGINE) engine/Makefile engine/config.h
		cd engine && $(MAKE) gforth-itc-noll$(EC)$(EXE) $(MAKELINE-noll)
		$(CP) engine/gforth-itc-noll$(EC)$(EXE) $@
		true

gforth-ditc$(EC)$(EXE): $(ENGINE_SOURCES) $(FORTH_GEN_ENGINE) engine/Makefile engine/config.h
		cd engine && $(MAKE) gforth-ditc-noll$(EC)$(EXE) $(MAKELINE-noll)
		$(CP) engine/gforth-ditc-noll$(EC)$(EXE) $@
		true

gforth-prof$(EC)$(EXE): $(ENGINE_SOURCES) $(FORTH_GEN_ENGINE) engine/Makefile engine/config.h
		cd engine && $(MAKE) gforth-prof-noll$(EC)$(EXE) $(MAKELINE-noll)
		$(CP) engine/gforth-prof-noll$(EC)$(EXE) $@

gforths: $(ENGINES) $(ENGINES_FAST)

# ------------- additional C primitives

.SUFFIXES:	.c .pri

.pri.c:		$< prim2cl.fs
		$(FORTHK) prim2cl.fs -e "file $< altogether bye" >$@

.c.so:		$<
		$(GCC) -shared $(CFLAGS) $(CPPFLAGS) $< -o $@

# -------------	Make Documentation

#TAGS is a GNU standard target
TAGS:		gforth.TAGS
		$(CP) gforth.TAGS $@

tags:		gforth.tags
		$(CP) gforth.tags $@

install.TAGS:	TAGS install-tags.fs
		sed 's;^\$(srcdir)/;;' TAGS|./gforth -e 's" '$(datadir)/gforth/$(VERSION)/'"' $(srcdir)/install-tags.fs -e bye >install.TAGS

gforth.TAGS:	kernl64l.fi gforth$(EC)$(EXE) $(GFORTH_FI_SRC) prim.TAGS kernel.TAGS
		$(FORTHK) etags.fs except.fs startup.fs -e bye
		cat TAGS prim.TAGS kernel.TAGS >gforth.TAGS
		rm TAGS

gforth.tags:	kernl64l.fi gforth$(EC)$(EXE) $(GFORTH_FI_SRC) prim.tags kernel.tags
		$(FORTHK) tags.fs except.fs startup.fs -e bye
		cat tags prim.tags kernel.tags >gforth.tags
		rm tags

prim.TAGS: 	prim.b prims2x.fs
		$(PREFORTH) prims2x.fs -e "s\" $(srcdir)/prim.b\" ' output-tag dup process-file bye"|sed 's#^./prim#prim#' >$@-
		$(CP) $@- $@
		$(RM) $@-

prim.tags: 	prim.b prims2x.fs
		#echo '2c\' >prim.TAGS.sed
		#echo $(srcdir)/prim >>prim.TAGS.sed
		#$(PREFORTH) prims2x.fs -e "s\" $(srcdir)/prim.b\" ' output-tag dup process-file bye" | sed -f prim.TAGS.sed >$@-
		$(PREFORTH) prims2x.fs -e "s\" $(srcdir)/prim.b\" ' output-vi-tag dup process-file bye" >$@-
		$(CP) $@- $@
		$(RM) $@-

kernel.TAGS:
		$(RM) kernl16l$(EC).fi-; $(MAKE) kernl64l.fi

kernel.tags:
		$(RM) kernl16l$(EC).fi-; $(MAKE) kernl64l.fi

#elc files
gforth.elc:	gforth.el
		-$(EMACS) -batch -f batch-byte-compile gforth.el

#Documentation

doc/doc.fd:	doc/makedoc.fs $(GFORTH_FI_SRC) code.fs objects.fs oof.fs moofglos.fs
		$(FORTHK) -e "s\" doc/doc.fd\"" doc/makedoc.fs except.fs startup.fs code.fs objects.fs oof.fs moofglos.fs regexp.fs fft.fs -e bye

doc/crossdoc.fd:	$(KERN_SRC) kernel/version.fs $(FORTH_GEN0)
		$(FORTHK) -e 's" mach32l.fs"' kernel/main.fs -e bye

doc/gforth.texi: doc/gforth.ds prim.b ds2texi.fs prims2x.fs \
		doc/doc.fd doc/crossdoc.fd
		$(PREFORTH) ds2texi.fs prims2x.fs -e "s\" $(srcdir)/prim.b\" ' register-doc ' noop process-file" doc/crossdoc.fd doc/doc.fd -e "s\" $(srcdir)/doc/gforth.ds\" r/o open-file throw ds2texi bye" >$@-
		$(CP) $@- $@
		$(RM) $@-

checkdoc:	doc/gforth.ds prim.b ds2texi.fs prims2x.fs doc/doc.fd doc/crossdoc.fd answords.fs doc/gforth.texi
		$(FORTH) ds2texi.fs prims2x.fs -e "s\" $(srcdir)/prim.b\" ' register-doc ' noop process-file" doc/crossdoc.fd doc/doc.fd answords.fs -e bye
		-grep unknown doc/gforth.texi
		-grep doc- doc/gforth.texi| grep -v '^@c'

dvi:		doc/gforth.dvi doc/vmgen.dvi

pdf:		doc/gforth.pdf doc/vmgen.pdf

doc/gforth.dvi doc/gforth.fns:	$(GFORTH_TEXI)
		cd doc; $(TEXI2DVI) gforth.texi

doc/gforth.pdf:	$(GFORTH_TEXI)
		cd doc; $(TEXI2PDF) gforth.texi

doc/vmgen.dvi:	$(VMGEN_TEXI)
		cd doc; $(TEXI2DVI) vmgen.texi

doc/vmgen.pdf:	$(VMGEN_TEXI)
		cd doc; $(TEXI2PDF) vmgen.texi

doc/gforth.ps:	doc/gforth.dvi
		$(DVI2PS) doc/gforth.dvi -o $@

doc/vmgen.ps:	doc/vmgen.dvi
		$(DVI2PS) doc/vmgen.dvi -o $@

info:		doc/gforth.info doc/vmgen.info

doc/gforth.info: $(GFORTH_TEXI)
		cd doc; $(MAKEINFO) gforth.texi

doc/vmgen.info: $(VMGEN_TEXI)
		cd doc; $(MAKEINFO) vmgen.texi


### need makeinfo 4.2 to generate html with these rules
doc/gforth: $(GFORTH_TEXI)
	cd doc; $(MAKEINFO) --html gforth.texi

doc/vmgen: $(VMGEN_TEXI)
	cd doc; $(MAKEINFO) --html vmgen.texi

doc/gforth.txt:	$(GFORTH_TEXI)
		-cd doc; $(MAKEINFO) --no-headers --no-split gforth.texi >gforth.txt

doc/vmgen.txt:	$(VMGEN_TEXI)
		-cd doc; $(MAKEINFO) --no-headers --no-split vmgen.texi >vmgen.txt

doc:		gforth.fi info doc/gforth doc/vmgen doc/gforth.ps doc/vmgen.ps doc/gforth.txt doc/vmgen.txt TAGS

# For an explanation of the following Makefile rules, see node
# `Automatic Remaking' in GNU Autoconf documentation.

#Note: no target "$(srcdir)/configure", because that does not trigger 
#unless $(srcdir)!="."
configure: configure.in aclocal.m4
	cd $(srcdir) && autoconf

aclocal.m4:	configure.in
		aclocal

# autoheader might not change config.h.in, so touch a stamp file.
engine/config.h.in: stamp-h.in
stamp-h.in: configure.in aclocal.m4
	cd $(srcdir) && autoheader
	echo timestamp > $(srcdir)/stamp-h.in

engine/config.h: stamp-h
stamp-h: engine/config.h.in config.status stamp-h.in
	./config.status

Makefile Makedist engine/Makefile gforthmi vmgen preforth machpc.fs doc/version.texi envos.fs build-ec:	Makefile.in Makedist.in engine/Makefile.in gforthmi.in vmgen.in preforth.in machpc.fs.in doc/version.texi.in config.status configure.in envos.fs.in build-ec.in engine/libcc.h.in
	./config.status

config.status: configure
	./config.status --recheck

#create files for DOS, because DOS cannot do it itself
makefile.dos engine/makefile.dos: mkdosmf.sed Makefile.in engine/Makefile.in
	sed -f mkdosmf.sed <Makefile.in >makefile.dos
	sed -f mkdosmf.sed <engine/Makefile.in >engine/makefile.dos

makefile.os2 engine/makefile.os2: mkos2mf.sed Makefile.in engine/Makefile.in
	sed -f mkos2mf.sed <Makefile.in >makefile.os2
	sed -f mkos2mf.sed <engine/Makefile.in >engine/makefile.os2
	echo '%.o:	%.c' >>makefile.os2
	echo '		$$(GCC) $$(CFLAGS) $$(CPPFLAGS) -c $$<' >>makefile.os2
	echo '%.o:	%.c' >>engine/makefile.os2
	echo '		$$(GCC) $$(CFLAGS) $$(CPPFLAGS) -c $$<' >>engine/makefile.os2
