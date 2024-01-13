;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname chapter_9_lists_0) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; A List-of-temperatures is one of: 
; – '()
; – (cons CTemperature List-of-temperatures)
 
(define ABSOLUTE0 -272)
; A CTemperature is a Number greater than ABSOLUTE0.

; List-of-temperatures -> Number
; return average of temperatures in input list-of-temperatures
(check-expect (average-temperature (cons 50 '())) 50)
(check-expect (average-temperature (cons 100 (cons 50 '()))) 75)
(check-expect (average-temperature (cons 75 (cons 100 (cons 50 '())))) 75)
(check-expect (average-temperature (cons 1 (cons 2 (cons 3 '())))) 2)
#|
(define (average-temperature list-of-temperatures)
  (cond
    [(empty? (rest list-of-temperatures))
     (first list-of-temperatures)]
    [(cons? list-of-temperatures)
     ...]))
|#
(define (average-temperature list-of-temperatures)
  (/ (sum list-of-temperatures)
     (how-many list-of-temperatures)))

(check-expect (sum (cons 50 '())) 50)
(check-expect (sum (cons 100 (cons 50 '()))) 150)
(check-expect (sum (cons 75 (cons 100 (cons 50 '())))) 225)
(check-expect (sum (cons 1 (cons 2 (cons 3 '())))) 6)
(define (sum list-of-amounts)
  (cond
    [(empty? list-of-amounts) 0]
    [(cons? list-of-amounts)
     (+ (first list-of-amounts)
     (sum (rest list-of-amounts)))]))

(check-expect (how-many (cons 50 '())) 1)
(check-expect (how-many (cons 100 (cons 50 '()))) 2)
(check-expect (how-many (cons 75 (cons 100 (cons 50 '())))) 3)
(check-expect (how-many (cons 1 (cons 2 (cons 3 '())))) 3)
(define (how-many alos)
  (cond
    [(empty? alos) 0]
    [else
     (add1 (how-many (rest alos)))]))

; Exercise 143
; Determine how average behaves in DrRacket when applied to the empty list.
#|
> (average-temperature '())
/: division by zero
|#
; Then design checked-average, a function that produces an informative error message when it is applied to '().

; List-of-temperatures -> Union[Number, Error]
; computes average for non-empty lists
; for empty lists, returns error
(check-error (checked-average '()))
(check-expect (checked-average (cons 50 '())) 50)
(check-expect (checked-average (cons 100 (cons 50 '()))) 75)
(check-expect (checked-average (cons 75 (cons 100 (cons 50 '())))) 75)
(check-expect (checked-average (cons 1 (cons 2 (cons 3 '())))) 2)             
(define (checked-average list-of-temperatures)
  (if (empty? list-of-temperatures)
      (error "Average expects a non-empty list")
      (average-temperature list-of-temperatures)))