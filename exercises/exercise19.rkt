;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise19) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; (require "exercise18.rkt") ; for string-join -- this works in #lang racket but not Beginning Student Language

; Define the function string-insert, which consumes a string str plus a number i
; and inserts "_" at the ith position of str.
; Assume i is a number between 0 and the length of the given string (inclusive).
; See exercise 3 for ideas. Ponder how string-insert copes with ""

(define (string-join input-string-left input-string-right)
  (string-append input-string-left "_" input-string-right))

(define (string-insert-valid-index str i)
  (and (<= i (string-length str))
       (>= i 0)))

(define (string-insert str i)
  (cond
    [(string-insert-valid-index str i)
     (string-join (substring str 0 i)
                  (substring str i))]
    [else str]))


(string-insert "hi" 0)
"should be"
"_hi"

(string-insert "hi" 1)
"should be"
"h_i"

(string-insert "hi" 2)
"should be"
"hi_"

(string-insert "" 0)
"should be"
"_"

(string-insert "hi" -1)
"should be"
"hi"
