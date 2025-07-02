# dwm version
VERSION = 6.5

# Customize below to fit your system

# paths
PREFIX = ${HOME}/.local
MANPREFIX = ${PREFIX}/share/man

X11INC = /usr/X11R6/include
X11LIB = /usr/X11R6/lib

PKG_CONFIG = pkg-config

# Xinerama, comment if you don't want it
XINERAMALIBS  = -lXinerama
XINERAMAFLAGS = -DXINERAMA

# freetype
FREETYPELIBS = -lfontconfig -lXft
FREETYPEINC = /usr/include/freetype2

# imlib2
IMLIB2INC = `$(PKG_CONFIG) --cflags imlib2`
IMLIB2LIB = `$(PKG_CONFIG) --libs imlib2`

# FreeBSD (uncomment)
#X11INC = /usr/local/include
#X11LIB = /usr/local/lib
#FREETYPEINC = /usr/local/include/freetype2
#PROCSTAT = -lprocstat
#BSDFLAGS = -D__BSD_VISIBLE

# OpenBSD (uncomment)
#FREETYPEINC = ${X11INC}/freetype2
#KVMLIB = -lkvm
#MANPREFIX = ${PREFIX}/man

# includes and libs
INCS = -I${X11INC} -I${FREETYPEINC} ${IMLIB2INC}
LIBS = -L${X11LIB} -lX11 ${XINERAMALIBS} ${FREETYPELIBS} ${IMLIB2LIB} -lXrender -lX11-xcb -lxcb -lxcb-res ${KVMLIB} ${PROCSTAT}

# flags
CPPFLAGS = -D_DEFAULT_SOURCE -D_BSD_SOURCE -D_XOPEN_SOURCE=700L -DVERSION=\"${VERSION}\" ${XINERAMAFLAGS} ${BSDFLAGS}
#CFLAGS   = -g -std=c99 -pedantic -Wall -O0 ${INCS} ${CPPFLAGS}
CFLAGS   = -std=c99 -pedantic -Wall -Wno-deprecated-declarations -O2 -ftree-vectorize -march=native ${INCS} ${CPPFLAGS}
LDFLAGS  = ${LIBS}

# Solaris
#CFLAGS = -fast ${INCS} -DVERSION=\"${VERSION}\"
#LDFLAGS = ${LIBS}

# compiler and linker
CC = cc
