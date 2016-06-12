INSTALLDIR = $(DESTDIR)/usr/share/icons
INSTALL = install -d
RM = rm -rf
CP = cp -Rf

all:

install: local

clear:
	$(RM) $(INSTALLDIR)/Papirus{,-Dark,-Arc-Dark}-GTK
local:
	$(INSTALL) $(INSTALLDIR)
	$(CP) Papirus{,-Dark,-Arc-Dark}-GTK $(INSTALLDIR)

uninstall: clear
