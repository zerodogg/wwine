# wwine makefile

VERSION=$(shell ./wwine --version|head -n1|perl -pi -e 's/^\D+//; s/\s.*$$//; chomp')

ifndef prefix
# This little trick ensures that make install will succeed both for a local
# user and for root. It will also succeed for distro installs as long as
# prefix is set by the builder.
prefix=$(shell perl -e 'if($$< == 0 or $$> == 0) { print "/usr" } else { print "$$ENV{HOME}/.local"}')

# Some additional magic here, what it does is set BINDIR to ~/bin IF we're not root
# AND ~/bin exists, if either of these checks fail, then it falls back to the standard
# $(prefix)/bin. This is also inside ifndef prefix, so if a prefix is supplied
# (ie. meaning this is a packaging), we won't run this at all
BINDIR ?= $(shell perl -e 'if(($$< > 0 && $$> > 0) and -e "$$ENV{HOME}/bin") { print "$$ENV{HOME}/bin";exit; } else { print "$(prefix)/bin"}')
endif

BINDIR ?= $(prefix)/bin
DATADIR ?= $(prefix)/share

DISTFILES=NEWS COPYING Makefile README wwine wwine.1

# Install wwine
install:
	mkdir -p "$(BINDIR)"
	cp wwine "$(BINDIR)"
	chmod 755 "$(BINDIR)/wwine"
	mkdir -p "$(DATADIR)/man/man1" && cp wwine.1 "$(DATADIR)/man/man1" || true
localinstall:
	mkdir -p "$(BINDIR)"
	ln -sf $(shell pwd)/wwine $(BINDIR)/
	mkdir -p "$(DATADIR)/man/man1" && ln -sf $(shell pwd)/wwine.1 "$(DATADIR)/man/man1" || true
# Uninstall an installed wwine
uninstall:
	rm -f "$(BINDIR)/wwine"
	rm -f "$(DATADIR)/man/man1/wwine.1"
# Clean up the tree
clean:
	rm -f `find|egrep '~$$'`
	rm -f wwine-*.tar.bz2 wwine-*.gem
	rm -rf wwine-$(VERSION)
# Verify syntax
test:
	@ruby -c wwine
# Generate the manpage from the POD
man:
	pod2man --center "" --release "wwine $(VERSION)" ./wwine.pod ./wwine.1
	perl -ni -e 'if(not $$seen) { if(not /Title/) { next } $$seen = 1 }; s/\.Sp//; print' ./wwine.1
# Generate files for distribution
distrib: clean test gem tarball
# Create the tarball
tarball: clean test
	mkdir -p wwine-$(VERSION)
	cp -r $(DISTFILES) ./wwine-$(VERSION)
	rm -rf `find wwine-$(VERSION) -name \\.git`
	tar -jcvf wwine-$(VERSION).tar.bz2 ./wwine-$(VERSION)
	rm -rf wwine-$(VERSION)
# Build the gem
TESTGEM?=testgem
gem: clean test $(TESTGEM)
	gem build wwine.gemspec
testgem:
	if ! grep '"$(VERSION)"' wwine.gemspec 2>&1 >/dev/null; then echo;echo "Update s.version in wwine.gemspec";exit 1;fi
