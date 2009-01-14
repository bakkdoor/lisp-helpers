(in-package :helpers)

(defun get-current-load-path (file-load-path)
  (let ((load-path-name (format nil "~a" file-load-path)))
    (string-trim (first (last (split-sequence:split-sequence #\/ load-path-name))) load-path-name)))
    
    


;; compiles and loads a lisp source file.
(defun compile-and-load (filename &key dir)
  (let ((filepath (concatenate 'string dir filename)))
    (compile-file filepath)
    (load filepath)))


;; takes ny list of symbols and returns them as a list,
;; each converted as a string 
(defmacro as-string-list (&rest filenames)
    `(list ,@(loop for f in filenames collecting `(string-downcase (string ',f)))))


;; führt body solange aus, wie alle variablen in variables nicht vom typ type sind.
(defmacro ensure-type ((type (&rest variables)) &body body)
  (let* ((type-name (if (equal type 'string)
			'symbol
			type))
	 (type-fn (intern (concatenate 'string (string-upcase type-name) "P"))))
    `(progn
       ,@body
       (loop while (or ,@(loop for v in variables
			    collect `(not (,type-fn ,v)))) do
	  ;; fehlermeldung ausgeben, dass typ nicht korrekt ist
	    (format t "~a~%" (concatenate 'string "falscher typ (" ,(string type) ") für variablen: "
					  ,@(loop for v in variables
					       collect `,(concatenate 'string (string v) " "))))
	    ,@body))))