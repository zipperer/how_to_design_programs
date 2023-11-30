;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise18) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define (string-join input-string-left input-string-right)
  (string-append input-string-left "_" input-string-right))

(string-join "hello" "world")
"should be"
"hello_world"

(string-join "right" "on")
"should be"
"right_on"
