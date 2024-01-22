;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname chapter_10_functions_that_produce_lists_0) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; Number -> Number
; computes the wage of h hours of work
(define (wage h)
  (* WAGE-PER-HOUR h))

; List-of-numbers -> List-of-numbers
; computes wages for each employeee given list of hours each employee worked
(check-expect (wage* (list 1 3 4)) (list (* 1 WAGE-PER-HOUR)
                                         (* 3 WAGE-PER-HOUR)
                                         (* 4 WAGE-PER-HOUR)))
(check-expect (wage* (list 10 8 7)) (list (* 10 WAGE-PER-HOUR)
                                          (* 8 WAGE-PER-HOUR)
                                          (* 7 WAGE-PER-HOUR)))
(define (wage* list-of-hours-each-employee-worked)
  (cond
    [(empty? list-of-hours-each-employee-worked) (list)]
    [(cons? list-of-hours-each-employee-worked)
     (cons (wage (first list-of-hours-each-employee-worked))
           (wage* (rest list-of-hours-each-employee-worked)))]))

; Exercise 161.
; Translate the examples into tests and make sure they all succeed.
(check-expect (wage* '()) '())
(check-expect (wage* (cons 28 '())) (cons (* 28 WAGE-PER-HOUR) '()))
(check-expect (wage* (cons 4 (cons 2 '()))) (cons (* 4 WAGE-PER-HOUR) (cons (* 2 WAGE-PER-HOUR) '())))
; Then change the function in figure 64 so that everyone gets $14 per hour.
; AZ:
; - change 12 to 14 in wage
; - change each expected-value in each check-expect to reflect new value    
; Now revise the entire program so that changing the wage for everyone is a single change to the entire program and not several. 
; AZ:
; - replace occurrence of 14 in wage by WAGE-PER-HOUR
; - factor 14 from expected-value in each check expect and replace the 14 with WAGE-PER-HOUR
(define WAGE-PER-HOUR 14)