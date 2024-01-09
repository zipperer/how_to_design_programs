;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise112) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; Exercise 112
; Reformulate the predicate (missile-or-not?-cond)
; using an or expression. 

(define (missile-or-not?-cond v)
  (cond
    [(false? v) #true]
    [(posn? v) #true]
    [else #false]))     

(define (missile-or-not? v)
  (or (false? v)
      (posn? v)))