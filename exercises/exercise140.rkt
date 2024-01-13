;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise140) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; Exercise 140
; Design the function all-true, which consumes a list of Boolean values and determines whether all of them are #true.
; In other words, if there is any #false on the list, the function produces #false.

; A List-of-booleans is one of:
; - '()
; - (cons Boolean List-of-booleans)
; <arrow from List-of-booleans in second clause to List-of-booleans in definition>
; Examples:
; '() is a List-of-booleans
; (cons #true '()) is a List-of-booleans
; (cons #false (cons #true '())) is a List-of-booleans

; List-of-booleans -> Boolean
; determines whether each entry in list is #true
(check-expect (all-true '()) #true)
(check-expect (all-true (cons #true '())) #true)
(check-expect (all-true (cons #false '())) #false)
(check-expect (all-true (cons #true (cons #false '()))) #false)
(check-expect (all-true (cons #true (cons #true '()))) #true)
(check-expect (all-true (cons #true (cons #true (cons #true '())))) #true)
(define (all-true list-of-booleans)
  (cond
    [(empty? list-of-booleans) #true]
    [(cons? list-of-booleans)
     (and (first list-of-booleans)
          (all-true (rest list-of-booleans)))]))

; Now design one-true, a function that consumes a list of Boolean values and determines whether at
; least one item on the list is #true.

; List-of-booleans -> Boolean
; determines whether at least one element in list is #true
(check-expect (one-true '()) #false)
(check-expect (one-true (cons #true '())) #true)
(check-expect (one-true (cons #false '())) #false)
(check-expect (one-true (cons #true (cons #false '()))) #true)
(check-expect (one-true (cons #true (cons #true '()))) #true)
(check-expect (one-true (cons #true (cons #true (cons #true '())))) #true)
(check-expect (one-true (cons #false (cons #false (cons #false '())))) #false)
(define (one-true list-of-booleans)
  (cond
    [(empty? list-of-booleans) #false]
    [(cons? list-of-booleans)
     (or (first list-of-booleans)
         (one-true (rest list-of-booleans)))]))

;(all-true (cons #true '()))
;(one-true (cons #true '()))
;(all-true (cons #false '()))
;(one-true (cons #false '()))
;(all-true (cons #true (cons #false '())))
;(one-true (cons #true (cons #false '())))
