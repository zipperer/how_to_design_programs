;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise168) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 168.
; Design the function translate.
;   It consumes and produces lists of Posns.
;   For each (make-posn x y) in the former, the latter contains (make-posn x (+ y 1)).

; We borrow the word “translate” from geometry, where the movement of a point by a constant distance along a straight line
;   is called a translation.

; A List-of-posn is one of:
; - '()
; - (cons Posn List-of-posn)
; For example:
; '()
; (cons (make-posn 1 1) '())
; (cons (make-posn 2 4) (cons (make-posn 1 1) '()))

; List-of-posn -> List-of-posn
(check-expect (translate '()) '())
(check-expect (translate (cons (make-posn 1 1) '())) (cons (make-posn 1 (+ 1 1)) '()))
(check-expect (translate (cons (make-posn 2 4) (cons (make-posn 1 1) '()))) (cons (make-posn 2 (+ 4 1)) (cons (make-posn 1 (+ 1 1)) '())))
; header
;(define (translate list-of-posn)
;  '())
; template -- given list
;(define (translate list-of-posn)
;  (cond
;    [(empty? list-of-posn) ...]
;    [(cons? list-of-posn)
;     (... (first list-of-posn) ...
;      ... (translate (rest list-of-posn)))]))
; template -- given list of instances of structure
;(define (translate list-of-posn)
;  (cond
;    [(empty? list-of-posn) ...]
;    [(cons? list-of-posn)
;     (... (process-posn (first list-of-posn)) ...
;      ... (translate (rest list-of-posn)))]))

(define (translate list-of-posn)
  (cond
    [(empty? list-of-posn) '()]
    [(cons? list-of-posn)
     (cons (translate-posn (first list-of-posn))
           (translate (rest list-of-posn)))]))

; Posn -> Posn
; translates (make-posn x y) to (make-posn x (+ 1 y))
(check-expect (translate-posn (make-posn 0 0)) (make-posn 0 1))
(check-expect (translate-posn (make-posn 0 -1)) (make-posn 0 0))
(check-expect (translate-posn (make-posn 10 3)) (make-posn 10 4))
(define (translate-posn posn)
  (make-posn (posn-x posn)
             (+ (posn-y posn) 1)))