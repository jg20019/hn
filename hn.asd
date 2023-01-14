;;;; hn.asd

(asdf:defsystem #:hn
  :description "TUI for reading Hacker News"
  :author "John Gibson <jg20019@gmail.com>"
  :license  "MIT"
  :version "0.0.1"
  :serial t
  :depends-on (:dexador :plump :lquery)
  :components ((:file "package")
               (:file "hn")))

(asdf:defsystem #:hn/bin
  :depends-on (:hn :adopt :with-user-abort)
  :build-operation program-op
  :build-pathname #p"~/.lisp-bin/hn"
  :entry-point "hn:main"
  :components ((:file "main")))
