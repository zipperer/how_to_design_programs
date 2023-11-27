;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise13) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define (string-first non-empty-string)
  ; given non-empty string, extract first 1String
  (string-ith non-empty-string 0))

(string-first "hello")
"should be"
"h"

(string-first "world")
"should be"
"w"