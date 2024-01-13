;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise147) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 147
; Develop a data definition for NEList-of-Booleans, a representation of non-empty lists of Boolean values.
; Then redesign the functions all-true and one-true from exercise 140.

#|
Exercise 140
Design the function all-true, which consumes a list of Boolean values and determines whether all of them are #true.
In other words, if there is any #false on the list, the function produces #false.

Now design one-true, a function that consumes a list of Boolean values and
determines whether at least one item on the list is #true. 
|#

; A NEList-of-Booleans is one of:
; - (cons Boolean '())
; - (cons Boolean NEList-of-Booleans)
; Examples:
; (cons #true '())
; (cons #false '())
; (cons #false (cons #true '()))
; (cons #true (cons #false (cons #true '())))
; (cons #true (cons #true (cons #true '())))

; NEList-of-booleans -> Boolean
; returns #true when all elements in list are #true
; otherwise returns #false
(check-expect (all-true (cons #true '())) #true)
(check-expect (all-true (cons #false '())) #false)
(check-expect (all-true (cons #false (cons #true '()))) #false)
(check-expect (all-true (cons #true (cons #false (cons #true '())))) #false)
(check-expect (all-true (cons #true (cons #true (cons #true '())))) #true)
(define (all-true ne-list-of-booleans)
  (cond
    [(empty? (rest ne-list-of-booleans)) (first ne-list-of-booleans)]
    [else ; i.e. (cons? (rest ne-list-of-booleans))
     (and (first ne-list-of-booleans)
          (all-true (rest ne-list-of-booleans)))]))

; NEList-of-booleans -> Boolean
; returns #true when at least one element in input list is #true
; otherwise returns #false
(check-expect (one-true (cons #true '())) #true)
(check-expect (one-true (cons #false '())) #false)
(check-expect (one-true (cons #false (cons #true '()))) #true)
(check-expect (one-true (cons #true (cons #false (cons #true '())))) #true)
(check-expect (one-true (cons #true (cons #true (cons #true '())))) #true)
(define (one-true ne-list-of-booleans)
  (cond
    [(empty? (rest ne-list-of-booleans)) (first ne-list-of-booleans)]
    [else ; i.e. (cons? (rest ne-list-of-booleans))
     (or (first ne-list-of-booleans)
         (one-true (rest ne-list-of-booleans)))]))