(defpackage :pasteboard
  (:use :cl :sb-alien)
  (:export
   #:copy
   #:paste))

(in-package :pasteboard)

(load-shared-object "libpasteboard.dylib")

(defun copy (s)
  (alien-funcall (extern-alien "pasteboard_copy" (function int c-string))
                 s))

(defun paste ()
  (with-alien ((str c-string
                    (alien-funcall (extern-alien "pasteboard_paste" (function c-string)))))
    str))

