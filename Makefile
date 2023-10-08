PREFIX = /usr/local/lib

all: pasteboard.fasl

libpasteboard.dylib: pasteboard.m
	cc -dynamiclib -framework Cocoa -o libpasteboard.dylib pasteboard.m

pasteboard.fasl: pasteboard.lisp
	sbcl --eval '(compile-file "pasteboard.lisp")' --quit

pasteboard-test: pasteboard-test.c libpasteboard.dylib
	cc -o pasteboard-test pasteboard-test.c -L. -lpasteboard

.PHONY: clean install uninstall

install: libpasteboard.dylib
	install libpasteboard.dylib $(PREFIX)

uninstall:
	rm -f $(PREFIX)/libpasteboard.dylib

clean:
	rm -f libpasteboard.dylib pasteboard.fasl pasteboard-test
