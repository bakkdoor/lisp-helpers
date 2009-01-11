(in-package :common-lisp-user)

(defpackage :helpers
  (:use :common-lisp :split-sequence)
  (:export :get-current-load-path
	   :compile-and-load
	   :as-string-list))