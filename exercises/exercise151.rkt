;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise151) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 151
; Design the function multiply.
; It consumes a natural number n and multiplies it with a number x without using *.

; N Number -> Number
; multiples given-number by n
(check-expect (multiply 0 1) 0)
(check-expect (multiply 0 2) 0)
(check-expect (multiply 1 0) 0)
(check-expect (multiply 3 3) 9)
(check-expect (multiply 3 4) 12)
(define (multiply n given-number)
  (cond
    [(zero? n) 0]
    [(equal? n 1) given-number]
    [(positive? n) (+ given-number (multiply (sub1 n) given-number))]))

(check-expect (multiply-alternative 0 1) 0)
(check-expect (multiply-alternative 0 2) 0)
(check-expect (multiply-alternative 1 0) 0)
(check-expect (multiply-alternative 3 3) 9)
(check-expect (multiply-alternative 3 4) 12)
(define (multiply-alternative n given-number)
  (cond
    [(zero? n) 0]
    [(positive? n) (+ given-number (multiply (sub1 n) given-number))]))

; Use DrRacket’s stepper to evaluate (multiply 3 x) for any x you like.
; (multiply-alternative 3 4)

; How does multiply relate to what you know from grade school? 
; Multiplication is repeated addition.
