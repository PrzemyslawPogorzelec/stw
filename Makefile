.POSIX:
.SUFFIXES:
PREFIX ?= /usr/local
MAN     = $(PREFIX)/share/man
NAME    = stw
CC      = cc
INCS    = -I/usr/include/X11 -I/usr/include/freetype2
LIBS    = -lX11 -lfontconfig -lXft -lXrender
CFLAGS  = -std=c99 -pedantic -Wall -Werror -D_DEFAULT_SOURCE -D_BSD_SOURCE -D_POSIX_C_SOURCE=2 $(INCS)
LDFLAGS = $(LIBS)
SRC     = $(NAME).c
OBJ     = ${SRC:.c=.o}

all: $(NAME)

$(NAME): $(OBJ)
	$(CC) $(LDFLAGS) -o $@ $^

.SUFFIXES: .c .o
$(OBJ):
.c.o:
	$(CC) $(CFLAGS) -c $<

install: all
	mkdir -p $(PREFIX)/bin
	cp -f $(NAME) $(PREFIX)/bin
	chmod 755 ${DESTDIR}${PREFIX}/bin/$(NAME)
	mkdir -p ${DESTDIR}${MAN}/man1
	cp stw.1 ${DESTDIR}${MAN}/man1/stw.1

clean:
	rm -f -- $(NAME) $(OBJ)

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/$(NAME)
	rm -f ${DESTDIR}${MAN}/man1/stw.1

.PHONY: clean
