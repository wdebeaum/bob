#
# File: Makefile for CollaborativeStateManager
# Creator: Ian Perera
#

MAIN    = CollaborativeStateManager
PACKAGE = TRIPS.CollaborativeStateManager
USES    = TRIPS.TripsModule TRIPS.KQML TRIPS.util TRIPS.JavaWrapper

JFLAGS	= -cp .:src

SRCS = 	CollaborativeStateManager.java

CLASSES = $(SRCS:.java=.class) 

CONFIGDIR=../config
include $(CONFIGDIR)/defs.mk
# HACK to work around stuff in ./src/ being in the wrong place in TRIPS.Causalizer.jar
EXTRA_CLASSPATH = $(prefix)/src/CollaborativeStateManager/src:$(etcdir)/java/TRIPS.JavaWrapper.jar
include $(CONFIGDIR)/java/prog.mk


