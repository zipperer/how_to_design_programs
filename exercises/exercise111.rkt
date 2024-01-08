;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise111) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; Exercise 111
; Take a look at these definitions:
(define-struct vec [x y])
; A vec is
;   (make-vec PositiveNumber PositiveNumber)
; interpretation represents a velocity vector

; Develop the function checked-make-vec,
; which is to be understood as a checked version of the primitive operation
; make-vec. It ensures that the arguments to make-vec are positive numbers.
; In other words, checked-make-vec enforces our informal data definition.

(define (positive-number? value)
  (and (number? value)
       (>= value 0)))

(define (checked-make-vec x y)
  (cond
    [(and (positive-number? x)
          (positive-number? y))
     (make-vec x y)]
    [else
     (error "make-vec expects positive-number positive-number")]))