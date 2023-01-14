LISP ?= sbcl

all: clean build 

clean:
	rm -rf ~/.lisp-bin/hn

build:
	$(LISP) \
		--eval '(ql:quickload :hn/bin)' \
		--eval '(asdf:make :hn/bin)'
