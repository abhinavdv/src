#	$NetBSD: Makefile,v 1.22 2019/01/22 23:55:54 mrg Exp $

.include <bsd.init.mk>

.include "${.CURDIR}/../../arch/${GCC_MACHINE_ARCH}/defs.mk"

.cc: # disable .cc->NULL transform

GNUHOSTDIST=	${DIST}

BUILDINCS=	basic_file.h c++allocator.h c++io.h c++locale.h
BUILDINCS+=	messages_members.h time_members.h opt_random.h

INCS=		${G_bits_headers} ${G_c_base_headers_extra} ${G_host_headers}
INCS+=		gthr.h gthr-single.h gthr-posix.h
INCS+=		${BUILDINCS}

# libsupc++
# XXX use bits_sup_headers from libstdc++/include/Makefile.am
INCS+=		atomic_lockfree_defines.h \
		cxxabi_forced.h \
		cxxabi_init_exception.h \
		exception.h \
		exception_defines.h \
		exception_ptr.h \
		hash_bytes.h \
		nested_exception.h

.if ${MKCOMPAT} != no && !empty(MACHINE_ARCH:M*64*)
SUBDIR+=	arch
.else
INCS+=		c++config.h
.endif

INCSDIR=	/usr/include/g++/bits

INCSYMLINKS+=	gthr-posix.h ${INCSDIR}/gthr-default.h

.include "${.CURDIR}/../Makefile.includes"

CLEANFILES+=	${BUILDINCS}

CXXDIST=			${DIST}/libstdc++-v3
COPYHEADERS= \
	opt_random.h		${CXXDIST}/${G_CPU_OPT_BITS_RANDOM} \
	basic_file.h		${CXXDIST}/${G_BASIC_FILE_H} \
	c++allocator.h		${CXXDIST}/${G_ALLOCATOR_H} \
	c++locale.h		${CXXDIST}/${G_CLOCALE_H} \
	c++io.h			${CXXDIST}/${G_CSTDIO_H} \
	messages_members.h	${CXXDIST}/${G_CMESSAGES_H} \
	time_members.h		${CXXDIST}/${G_CTIME_H}

.for _h _s in ${COPYHEADERS}
${_h}: ${_s}
	cp -pf ${.ALLSRC} ${.TARGET}
.endfor

# Get default targets including <bsd.inc.mk>.
.include <bsd.prog.mk>

.PATH: ${.CURDIR}/../../arch/${GCC_MACHINE_ARCH} \
	${DIST}/libstdc++-v3/include \
	${DIST}/libstdc++-v3/config \
	${DIST}/libstdc++-v3/ \
	${DIST}/libstdc++-v3/libsupc++

.include <bsd.subdir.mk>
