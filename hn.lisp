;;;; hn.lisp

(in-package #:hn)

;;;; Colors 

(defparameter *red* 1)
(defparameter *magenta* 5)
(defparameter *blue* 4)

(defun color-start (color) 
  (format nil "~C[3~dm" #\Escape color))

(defun color-end () 
  (format nil "~C[0m" #\Escape))

(defun colorize-string (string color) 
  (format nil "~a~a~a" (color-start color) 
                       string
                       (color-end)))


;;;; Hacker News

(defparameter *url* "https://news.ycombinator.com/")
(defvar *submissions* (make-hash-table :test #'equal))

(defun fetch-submissions (page-number) 
  (cond ((gethash page-number *submissions*) (gethash page-number *submissions*)) 
        (t (let* ((url (format nil "~a?p=~d" *url* page-number))
                  (request (dex:get url))
                  (content (lquery:$ (initialize request)))
                  (submissions (lquery:$ content ".titleline > a" (combine (text) (attr :href)))))
             (setf (gethash page-number *submissions*) submissions)))))

(defun view-submissions (submissions) 
  (dotimes (i (length submissions))
    (let* ((submission (aref submissions i))
           (title (first submission))
           (url (second submission)))
      (format t "~d ~a~%   ~a~%" (+ i 1) (colorize-string title *magenta*) (colorize-string url *blue*)))))

(defun hn () 
  (write-line (colorize-string "Hacker News" *red*))
  (view-submissions (fetch-submissions 1)))
