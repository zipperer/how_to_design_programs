;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise145) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; Exercise 145
; Design the sorted>? predicate, which consumes a NEList-of-temperatures and produces #true
; if the temperatures are sorted in descending order. That is, if the second is smaller than the first,
; the third smaller than the second, and so on. Otherwise it produces #false.

; An NEList-of-temperatures is one of:
; - (cons CTemperature '())
; - (cons CTemperature NEList-of-temperatures)

; NEList-of-temperatures -> Boolean
; returns #true when the temperatures in the given list are sorted in descending order.
; otherwise returns #false
(check-expect (sorted>? (cons 1 '())) #true)
(check-expect (sorted>? (cons 2 (cons 1 '()))) #true)
(check-expect (sorted>? (cons 1 (cons 2 '()))) #false)
(check-expect (sorted>? (cons 3 (cons 2 (cons 1 '())))) #true)
(check-expect (sorted>? (cons 3 (cons 1 (cons 2 '())))) #false)
#|
(define (sorted>? ne-list-of-temperatures)
  (cond
    [(empty? (rest ne-list-of-temperatures)) ...]
    [else ; (cons? (rest ne-list-of-temperatures))
     (first ne-list-of-temperatures) ; CTemperature
     (rest ne-list-of-temperatures) ; NEList-of-temperatures
     (sorted>? (rest ne-list-of-temperatures)) ; whether (rest ne-list-of-temperatures) in descending order
     ]))
|#
(define (sorted>? ne-list-of-temperatures)
  (cond
    [(empty? (rest ne-list-of-temperatures)) #true]
    [else ; (cons? (rest ne-list-of-temperatures))
     (and
      (> (first ne-list-of-temperatures) ; CTemperature
         (first (rest ne-list-of-temperatures))) ; NEList-of-temperatures
      (sorted>? (rest ne-list-of-temperatures))) ; whether (rest ne-list-of-temperatures) in descending order
     ]))