;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise139) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; Exercise 139
; Now take a look at this data definition:

; A List-of-numbers is one of: 
; – '()
; – (cons Number List-of-numbers)

; Some elements of this class of data are appropriate inputs for sum from exercise 138 and some aren’t.

; Design the function pos?, which consumes a List-of-numbers and determines whether all numbers are positive numbers.
; In other words, if (pos? l) yields #true, then l is an element of List-of-amounts.
; Use DrRacket’s stepper to understand how pos? works for (cons 5 '()) and (cons -1 '()).

; List-of-numbers -> Boolean
; checks whether all numbers in input list are positive
; #true if all are positive; #false otherwise
(check-expect (pos? '()) #true)
(check-expect (pos? (cons 1 '())) #true)
(check-expect (pos? (cons -1 '())) #false)
(check-expect (pos? (cons 2 (cons 1 '()))) #true)
(check-expect (pos? (cons 2 (cons -1 '()))) #false)
;(define (pos? list-of-numbers)
;  (cond
;    [(empty? list-of-numbers) #true]
;    [(cons? list-of-numbers?)
;     (first list-of-numbers) ; Number
;     (rest list-of-numbers) ; List-of-numbers
;     (pos? (rest list-of-numbers)) ; boolean - whether the rest of the list has only positive numbers
;     ]))
(define (pos? list-of-numbers)
  (cond
    [(empty? list-of-numbers) #true]
    [(cons? list-of-numbers)
     (and (>= (first list-of-numbers) 0)
          (pos? (rest list-of-numbers)))]))
; Also design checked-sum.
; The function consumes a List-of-numbers.
; It produces their sum if the input also belongs to List-of-amounts; otherwise it signals an error.
; Hint: Recall to use check-error.

; List-of-numbers -> Number
; computes sum if input is element of List-of-amounts; otherwise error
(check-error (checked-sum (cons -1 '())))
(check-expect (checked-sum (cons 1 '())) 1)
(check-expect (checked-sum (cons 2 (cons 1 '()))) 3)
(check-error (checked-sum (cons 2 (cons -1 '()))))
(define (checked-sum list-of-numbers)
  (if (pos? list-of-numbers)
      (sum list-of-numbers)
      (error "sum expects element of List-of-amounts, but input had negative numbers in list")))

; What does sum compute for an element of List-of-numbers?
; For an element of List-of-numbers, sum computes the sum
; of the positive numbers minus the sum of the negative numbers.

(define (sum list-of-amounts)
  (cond
    [(empty? list-of-amounts) 0]
    [(cons? list-of-amounts)
     (+ (first list-of-amounts)
     (sum (rest list-of-amounts)))]))