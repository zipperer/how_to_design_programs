#lang racket

(require "exercise27.rkt")

"profit at ticket-price:"
"1 dollar"
(profit 1)
"2 dollars"
(profit 2)
"3 dollars"
(profit 3)
"4 dollars"
(profit 4)
"5 dollars"
(profit 5)


"profit at ticket-price:"
"2.5 dollars"
(profit 2.5)
"2.6 dollars"
(profit 2.6)
"2.7 dollars"
(profit 2.7)
"2.8 dollars"
(profit 2.8)
"2.9 dollars" ; given these ten cent increments, maximum occurs here:
(profit 2.9)  ; 1064.1. Woflram Alpha gives x = 73/25 for
              ; "max (x * (120 + (15 * (10 * (5 - x))))) - (180 + (.04 * (120 + (15 * (10 * (5 - x)))))) from x = 0 to x = 6"
"3 dollars"
(profit 3)
"3.1 dollars"
(profit 3.1)
"3.2 dollars"
(profit 3.2)
"3.3 dollars"
(profit 3.3)
"3.4 dollars"
(profit 3.4)
"3.5 dollars"
(profit 3.5)