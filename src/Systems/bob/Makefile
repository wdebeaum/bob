#
# File: Systems/bob/Makefile
#

NAME = trips-bob

include ../Makefile-common

$(IMAGE):: ../../TextTagger/drum-dsl-resources.lisp ../../TextTagger/drum-mappings.lisp

CSM_DATA = events goals models

install:: install-configs install-data

install-configs:: TextTagger-*.conf
	$(INSTALL_DATA) $^ $(etcdir)

install-data:: ${CSM_DATA}
	$(INSTALL_DATA) $^ $(etcdir)
