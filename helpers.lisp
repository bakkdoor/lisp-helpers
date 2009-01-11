(in-package :helpers)

(defun get-current-load-path (file-load-path)
  (let ((load-path-name (format nil "~a" file-load-path)))
    (string-trim (first (last (split-sequence:split-sequence #\/ load-path-name))) load-path-name)))


;; compiles and loads a lisp source file.
(defun compile-and-load (filename &optional &key (dir nil))
  (let ((current-dir *current-dir*))
    (if dir
	(setf current-dir dir))
    (let ((filepath (concatenate 'string current-dir filename)))
      (compile-file filepath)
      (load filepath))))


;; takes ny list of symbols and returns them as a list,
;; each converted as a string 
(defmacro as-string-list (&rest filenames)
    `(list ,@(loop for f in filenames collecting `(string-downcase (string ',f)))))


