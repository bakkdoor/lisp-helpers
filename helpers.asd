(defpackage :helpers-system (:use :asdf :cl))
(in-package :helpers-system)

(defsystem helpers
  :serial t
  :name "helpers"
  :author "Christopher Bertels"
  :version "0.1"
  :maintainer "Christopher Bertels"
  :licence "GNU GPL v3"
  :description "Some helper functions I regularly use."
  :long-description "Some helper functions I regularly use."
  :depends-on (:split-sequence)
  :components ((:file "packages")
  	       (:file "helpers")))
