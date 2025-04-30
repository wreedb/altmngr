PREFIX ?= /usr/local
LOCALSTATEDIR ?= /var
SYSCONFDIR ?= /etc
ALTDIR ?= $(LOCALSTATEDIR)/lib/altmngr
ALTDATADIR ?= $(SYSCONFDIR)/altmngr
MANDIR ?= $(PREFIX)/share/man
CFLAGS = -O2 -Wall -D_GNU_SOURCE -I./src
CC ?= cc

default:
	$(CC) $(CFLAGS) -c src/altmngr.c -o src/altmngr.o
	$(CC) $(CFLAGS) src/altmngr.o -o altmngr

man:
	scdoc < doc/altmngr.8.scd > altmngr.8

clean:
	rm -f src/altmngr.o altmngr.o
	rm -f src/altmngr altmngr
	rm -f doc/altmngr.8 altmngr.8
	rm -rf build