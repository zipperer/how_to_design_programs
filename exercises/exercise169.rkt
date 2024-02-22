;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise169) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 169.
; Design the function legal.
;   Like translate from exercise 168, the function consumes and produces a list of Posns.
;   The result contains all those Posns whose x-coordinates are between 0 and 100 and whose y-coordinates are between 0 and 200.

; List-of-posn -> List-of-posn
; filters input list-of-posn to those posn for which the:
; - x-coordinate is between 0 and 100
; - y-coordinate is between 0 and 200
(check-expect (legal '()) '())
(check-expect (legal (cons (make-posn 0 0) '())) (cons (make-posn 0 0) '()))
(check-expect (legal (cons (make-posn 0 0) (cons (make-posn -1 0) '()))) (cons (make-posn 0 0) '()))
(check-expect (legal (cons (make-posn 0 -1) (cons (make-posn 0 0) (cons (make-posn -1 0) '())))) (cons (make-posn 0 0) '()))
(check-expect (legal (cons (make-posn 50 100) (cons (make-posn 0 -1) (cons (make-posn 0 0) (cons (make-posn -1 0) '())))))
              (cons (make-posn 50 100) (cons (make-posn 0 0) '())))
; header
;(define (legal list-of-posn)
;  '())
; template -- given list
;(define (legal list-of-posn)
;  (cond
;    [(empty? list-of-posn) ...]
;    [(cons? list-of-posn)
;     (... (first list-of-posn) ... ; instance of Posn
;      ... (legal (rest list-of-posn)) ... ); list -- result of filtering rest of input
;      ]))
; template -- given list of instances of structure
;(define (legal list-of-posn)
;  (cond
;    [(empty? list-of-posn) ...]
;    [(cons? list-of-posn)
;     (... (process-posn (first list-of-posn)) ...
;      ... (legal (rest list-of-posn)) ... ); list -- result of filtering rest of input
;      ]))
(define (legal list-of-posn)
  (cond
    [(empty? list-of-posn) '()]
    [(cons? list-of-posn)
     (cond
       [(posn-legal? (first list-of-posn))
        (cons (first list-of-posn) (legal (rest list-of-posn)))]
       [else
        (legal (rest list-of-posn))])]))

(define (posn-legal? posn)
  (and (<= 0 (posn-x posn) 100)
       (<= 0 (posn-y posn) 200)))