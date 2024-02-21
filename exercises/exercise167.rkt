;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise167) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 167.
; Design the function sum, which consumes a list of Posns and produces the sum of all of its x-coordinates.

; List-of-posn is one of:
; '()
; (cons Posn List-of-posn)
; For example:
; (cons (make-posn 1 2) '())
; (cons (make-posn 3 4) (cons (make-posn 1 2) '()))

; List-of-posn -> Number
; computes sum of x-coordinates of posns in list
(check-expect (sum-x-coordinates '()) 0)
(check-expect (sum-x-coordinates (cons (make-posn 1 0) '())) 1)
(check-expect (sum-x-coordinates (cons (make-posn 2 2) (cons (make-posn 1 0) '()))) 3)
(check-expect (sum-x-coordinates (cons (make-posn -3 4) (cons (make-posn 2 2) (cons (make-posn 1 0) '())))) 0)
; header
;(define (sum-x-coordinates list-of-posns)
;  0)
; template -- given list 
;(define (sum-x-coordinates list-of-posns)
;  (cond
;    [(empty? list-of-posns) ...]
;    [(cons? list-of-posns)
;     (... (first list-of-posns) ...
;      ... (sum-x-coordinates (rest list-of-posns)) ...)]))
; template -- given list of instances of structure
;(define (sum-x-coordinates list-of-posns)
;  (cond
;    [(empty? list-of-posns) ...]
;    [(cons? list-of-posns)
;     (... (process-posn (first list-of-posns)) ...
;      ... (sum-x-coordinates (rest list-of-posns)) ...)]))

(define (sum-x-coordinates list-of-posns)
  (cond
    [(empty? list-of-posns) 0]
    [(cons? list-of-posns)
     (+ (posn-x (first list-of-posns))
        (sum-x-coordinates (rest list-of-posns)))]))
