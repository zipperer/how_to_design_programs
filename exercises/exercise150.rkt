;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise150) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; Exercise 150
; Design the function add-to-pi.
; It consumes a natural number n and adds it to pi without using the primitive + operation.
; Here is a start:
; N -> Number
; computes (+ n pi) without using +
 
(check-within (add-to-pi 3) (+ 3 pi) 0.001)
(check-within (add-to-pi 4) (+ 4 pi) 0.001)
(check-within (add-to-pi 5) (+ 5 pi) 0.001)
 
(define (add-to-pi n)
  (cond
    [(zero? n) pi]
    [(positive? n)
     (add1 (add-to-pi (sub1 n)))]))

; Once you have a complete definition, generalize the function to add, which adds a natural number n to some arbitrary number x without using +.
; Why does the skeleton use check-within?

(check-expect (add 3 3) 6)
(check-expect (add 4 3) 7)
(check-expect (add 5 3) 8)
; N -> Number
; adds the given number to x.
(define (add n x)
  (cond
    [(zero? n) x]
    [(positive? n)
     (add1 (add (sub1 n) x))]))

; The skeleton for add-to-pi uses check-within because pi is inexact.
