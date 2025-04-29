PREFIX ?= /usr/local
LOCALSTATEDIR ?= /var
SYSCONFDIR ?= /etc
ALTDIR ?= $(LOCALSTATEDIR)/lib/altmngr
ALTDATADIR ?= $(SYSCONFDIR)/altmngr
MANDIR ?= $(PREFIX)/share/man
CFLAGS = -O2 -Wall -D_GNU_SOURCE -I./src
CC ?= cc

default: build

build:
	$(CC) $(CFLAGS) -c src/altmngr.c
	$(CC) $(CFLAGS) altmngr.o -o altmngr

man:
	scdoc < doc/altmngr.8.scd > altmngr.8

clean:
	rm -f altmngr.o altmngr altmngr.8