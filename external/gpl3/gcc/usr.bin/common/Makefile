#	$NetBSD: Makefile,v 1.6 2018/02/04 10:16:07 mrg Exp $

LIBISPRIVATE=	yes

# For ../Makefile.inc and bsd.own.mk
.include <bsd.init.mk>

LIB=		common

SRCS=		diagnostic.c \
		diagnostic-color.c \
		diagnostic-show-locus.o \
		pretty-print.c \
		vec.c \
		intl.c \
		input.c \
		version.c \
		hash-table.c \
		ggc-none.c \
		memory-block.cc

# XXX make sure this doesn't have more than it needs
CPPFLAGS+=	-I${GCCARCH} -I${BACKENDOBJ} -I. \
		${G_ALL_CFLAGS:M-D*} ${G_INCLUDES:M-I*:N-I.*} \
		-DPREFIX=\"/usr\" \
		-DDEFAULT_TARGET_VERSION=\"${G_version}\" \
		-DDEFAULT_TARGET_MACHINE=\"${MACHINE_GNU_PLATFORM}\" \
		-DCONFIGURE_SPECS="\"\""

MKPIC:=		no
MKPICLIB:=	no

HOSTPROG_CXX=	1

COPTS.diagnostic.c=	-Wno-stack-protector
COPTS.intl.c=		-Wno-stack-protector

version.c: ${GCCARCH}/defs.mk ${TOP}/tools/gcc/gcc-version.mk

${SRCS}: ${GCCARCH}/defs.mk

.include <bsd.lib.mk>

# Force using C++ for this
HOST_CC:=	${HOST_CXX}
CC:=		${CXX}
CFLAGS:=	${CXXFLAGS}

.PATH: ${DIST}/gcc
