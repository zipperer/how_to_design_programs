;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise14) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define (string-last non-empty-string)
  ; compute last character in non-empty-string
  (string-ith non-empty-string 
	      (- (string-length non-empty-string) 1)))

(string-last "hello")
"should be"
"o"

(string-last "world")
"should be"
"d"
