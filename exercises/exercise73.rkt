;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise73) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; Exercise 73
; Design the function posn-up-x, which consumes a Posn p and
; a Number n. It produces a Posn like p with n in the x field.

; Posn Number -> Posn
; produce Posn with n in x field and (posn-y p) in y field.
; (define (posn-up-x p n)
;   ... (posn-x p) ... n ... (posn-y p) ...)

(check-expect (posn-up-x (make-posn 10 20) 5) (make-posn 5 20))
(check-expect (posn-up-x (make-posn 30 20) 5) (make-posn 5 20))
(define (posn-up-x p n)
  (make-posn n (posn-y p)))

; A neat observation is that we can define x+ using posn-up-x:

; Posn -> Posn
; increases the x-coordinate of p by 3
(check-expect (x+ (make-posn 10 0)) (make-posn 13 0))
; (define (x+ p)
;  (... (posn-x p) ... (posn-y p) ...))

(define (x+ p)
  (posn-up-x p (+ (posn-x p) 3)))

; Note:
; Functions such as posn-up-x are often called updaters or
; functional setters. They are extremely useful when you
; write large programs. 