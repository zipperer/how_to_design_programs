;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise163) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 163.
; Design convertFC.
; The function converts a list of measurements in Fahrenheit to a list of Celsius measurements.

; fahrenheit = 1.8 * celsius + 32
; so, 
; celsius = (fahrenheit - 32) / 1.8
;         = (fahrenheit - 32) / (9 / 5))
;         = (* (fahrenheit - 32) 5/9)
; Number -> Number
; computes celsius temperature from fahrenheit temperature
(check-expect (fahrenheit->celsius 212) 100)
(check-expect (fahrenheit->celsius 32) 0)
(define (fahrenheit->celsius fahrenheit)
 (* 5/9 (- fahrenheit 32)))

; List-of-numbers -> List-of-numbers
; computes list of celsius temperatures from list of fahrenheit temperatures
(check-expect (convertFC (cons 212 (cons 32 '()))) (cons 100 (cons 0 '())))
(check-expect (convertFC '()) '())
(check-expect (convertFC (cons 212 '())) (cons 100 '()))
(define (convertFC list-of-fahrenheit-temperatures)
  (cond
    [(empty? list-of-fahrenheit-temperatures) '()]
    [(cons? list-of-fahrenheit-temperatures)
     (cons (fahrenheit->celsius (first list-of-fahrenheit-temperatures))
           (convertFC (rest list-of-fahrenheit-temperatures)))]))