#
# File: Systems/bob/Makefile
#

NAME = trips-bob

include ../Makefile-common

$(IMAGE):: ../../TextTagger/drum-dsl-resources.lisp ../../TextTagger/drum-mappings.lisp

install:: install-configs

install-configs:: TextTagger-*.conf
	$(INSTALL_DATA) $^ $(etcdir)

