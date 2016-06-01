INSTALLDIR = $(DESTDIR)/usr/share/icons/
INSTALL = install -d
RM = rm -rf
CP = cp -rf

all:

install: local

clear:
	$(RM) $(INSTALLDIR) Papirus{,-Dark}-GTK
local:
	$(INSTALL) $(INSTALLDIR)
	$(CP) Papirus{,-Dark}-GTK $(INSTALLDIR)

uninstall: clear
