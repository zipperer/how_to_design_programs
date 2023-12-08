#lang racket

(define (profit-no-factoring price)
  (- (* (+ 120
           (* (/ 15 0.1)
              (- 5.0 price)))
        price)
     (+ 180
        (* 0.04
           (+ 120
              (* (/ 15 0.1)
                 (- 5.0 price)))))))


(require "exercise27.rkt")

"profit at ticket-price:"
"1 dollar"
(profit-no-factoring 1)
(profit 1)
"2 dollars"
(profit-no-factoring 2)
(profit 2)
"3 dollars"
(profit-no-factoring 3)
(profit 3)
"4 dollars"
(profit-no-factoring 4)
(profit 4)
"5 dollars"
(profit-no-factoring 5)
(profit 5)


"profit at ticket-price:"
"2.5 dollars"
(profit-no-factoring 2.5)
(profit 2.5)
"2.6 dollars"
(profit-no-factoring 2.6)
(profit 2.6)
"2.7 dollars"
(profit-no-factoring 2.7)
(profit 2.7)
"2.8 dollars"
(profit-no-factoring 2.8)
(profit 2.8)
"2.9 dollars" 
(profit-no-factoring 2.9)  
(profit 2.9)  
"3 dollars"
(profit-no-factoring 3)
(profit 3)
"3.1 dollars"
(profit-no-factoring 3.1)
(profit 3.1)
"3.2 dollars"
(profit-no-factoring 3.2)
(profit 3.2)
"3.3 dollars"
(profit-no-factoring 3.3)
(profit 3.3)
"3.4 dollars"
(profit-no-factoring 3.4)
(profit 3.4)
"3.5 dollars"
(profit-no-factoring 3.5)
(profit 3.5)
