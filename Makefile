#
# Makefile
#
# Makefile for fbv

include Make.conf

CC	= gcc 
#CC	= clang

LOCALBASE	?= /usr/local

PNG_CFLAGS	!= $(LOCALBASE)/bin/libpng15-config --cflags
PNG_LIBS	!= $(LOCALBASE)/bin/libpng15-config --libs

CFLAGS  = -O2 -Wall -D_GNU_SOURCE $(PNG_CFLAGS) -I$(LOCALBASE)/include

SOURCES	= main.c jpeg.c gif.c png.c bmp.c fb_display.c transforms.c
OBJECTS	= ${SOURCES:.c=.o}

OUT	= fbv
LIBS	= -L$(LOCALBASE)/lib -lgif -ljpeg $(PNG_LIBS)

all: $(OUT)
	@echo Build DONE.

$(OUT): $(OBJECTS)
	$(CC) $(LDFLAGS) -o $(OUT) $(OBJECTS) $(LIBS)

clean:
	rm -f $(OBJECTS) *~ $$$$~* *.bak core config.log $(OUT)

distclean: clean
	@echo -e "error:\n\t@echo Please run ./configure first..." >Make.conf
	rm -f $(OUT) config.h

install: $(OUT)
	cp $(OUT) $(DESTDIR)$(bindir)
	gzip -9c $(OUT).1 > $(DESTDIR)$(mandir)/man1/$(OUT).1.gz

uninstall: $(DESTDIR)$(bindir)/$(OUT)
	rm -f $(DESTDIR)$(bindir)/$(OUT)
	rm -f $(DESTDIR)$(mandir)/man1/$(OUT).1.gz
