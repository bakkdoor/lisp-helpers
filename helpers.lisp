(in-package :helpers)


(defun get-current-load-path (file-load-path)
  (let ((load-path-name (format nil "~a" file-load-path)))
    (string-trim (first (last (split-sequence:split-sequence #\/ load-path-name))) load-path-name)))


(defun compile-and-load (filename &key dir)
  "Compiles and loads a lisp source file."
  (let ((filepath (concatenate 'string dir filename)))
    (compile-file filepath)
    (load filepath)))


(defmacro as-string-list (&rest filenames)
  "Takes ny list of symbols and returns them as a list, each converted as a string"
    `(list ,@(loop for f in filenames collecting `(string-downcase (string ',f)))))


(defmacro ensure-type ((type (&rest variables)) &body body)
  "Executes body as long as all variables aren't of type type"
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