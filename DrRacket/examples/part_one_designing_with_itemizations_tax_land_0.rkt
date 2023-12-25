;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname part_one_designing_with_itemizations_tax_land_0) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Sample Problem
; The state of Tax Land has created a three-stage
; sales tax to cope with its budget deficit. Inexpensive items,
; those costing less than $1,000, are not taxed. Luxury items,
; with a price of more than $10,000, are taxed at the rate of
; eight percent (8.00%). Everything in between comes with a five
; percent (5.00%) markup.

; Design a function for a cash register that,
; given the price of an item, computes the sales tax.

; data definition
; signature, purpose statement, header
; functional examples
; function template
; fill in template
; format functional examples as tests and run them

; data definition
; An ItemCostCategory is an itemization with three ranges:
; - < 1000$
; - [1000$, 10000$]
; - > 10000$

; An ItemCostBeforeTax is a Nonnegative Number

; An ItemCostSalesTax is a Nonnegative Number

; ItemCostBeforeTax -> ItemCostSalesTax
; 'given the price of an item, computes the sales tax for that item'
; (define (item-cost-sales-tax item-cost-before-tax)
;   1)

; (define (item-cost-sales-tax item-cost-before-tax)
;   ... item-cost-before-tax ...)

(check-expect (item-cost-sales-tax 999) 0)
(check-expect (item-cost-sales-tax 1000) (* 1000 .05))
(check-expect (item-cost-sales-tax 9999) (* 9999 .05))
(check-expect (item-cost-sales-tax 10000) (* 10000 .05))
(check-expect (item-cost-sales-tax 10001) (* 10001 .08))
(check-expect (item-cost-sales-tax 100000) (* 100000 .08))

(define (item-cost-sales-tax item-cost-before-tax)
  (cond
    [(< item-cost-before-tax 1000) 0]
    [(<= 1000 item-cost-before-tax 10000) (* item-cost-before-tax .05)]
    [(< 10000 item-cost-before-tax) (* item-cost-before-tax .08)]))


(check-expect (item-total-cost-after-tax 999) (+ 999 0))
(check-expect (item-total-cost-after-tax 1000) (+ 1000 (* 1000 .05)))
(check-expect (item-total-cost-after-tax 9999) (+ 9999 (* 9999 .05)))
(check-expect (item-total-cost-after-tax 10000) (+ 10000 (* 10000 .05)))
(check-expect (item-total-cost-after-tax 10001) (+ 10001 (* 10001 .08)))
(check-expect (item-total-cost-after-tax 100000) (+ 100000 (* 100000 .08)))
(define (item-total-cost-after-tax item-cost-before-tax)
  (+ item-cost-before-tax (item-cost-sales-tax item-cost-before-tax)))


; The text interprets 'more than $10000' as (>= x 10000).
; Given that, our second cond clause:
; (<= 1000 item-cost-before-tax 10000)
; would change to
; (and (<= 1000 item-cost-before-tax) (< item-cost-before-tax 10000))
; Our third cond clause:
; (< 10000 item-cost-before-tax)
; would change to
; (<= 10000 item-cost-before-tax)
; With that interpretation, the intervals are:
; [0, 1000)
; [1000, 10000)
; [10000, POSITIVE_INFINITY)
; rather than
; [0, 1000)
; [1000, 10000]
; (10000, POSITIVE_INFINITY)

; Test cases from text:
(check-expect (sales-tax 0) 0)
(check-expect (sales-tax 537) 0)
(check-expect (sales-tax 1000) (* 0.05 1000))
(check-expect (sales-tax 1282) (* 0.05 1282))
(check-expect (sales-tax 10000) (* 0.08 10000))
(check-expect (sales-tax 12017) (* 0.08 12017))

; There are more test cases than intervals (/ sub-classes) in the
; data definition because we make test cases for each boundary
; between intervals and for values within each interval.

(define (sales-tax p)
  (cond
    [(and (<= 0 p) (< p 1000)) 0]
    [(and (<= 1000 p) (< p 10000)) (* .05 p)]
    [(<= 10000 p) (* .08 p)]))


; Exercise 58
(check-expect (sales-tax-using-thresholds 0) 0)
(check-expect (sales-tax-using-thresholds 537) 0)
(check-expect (sales-tax-using-thresholds 1000) (* 0.05 1000))
(check-expect (sales-tax-using-thresholds 1282) (* 0.05 1282))
(check-expect (sales-tax-using-thresholds 10000) (* 0.08 10000))
(check-expect (sales-tax-using-thresholds 12017) (* 0.08 12017))
(define EXPENSIVE-ITEM-THRESHOLD 1000)
(define LUXURY-ITEM-THRESHOLD 10000)
(define (sales-tax-using-thresholds p)
  (cond
    [(and (<= 0 p) (< p EXPENSIVE-ITEM-THRESHOLD)) 0]
    [(and (<= EXPENSIVE-ITEM-THRESHOLD p) (< p LUXURY-ITEM-THRESHOLD)) (* .05 p)]
    [(<= LUXURY-ITEM-THRESHOLD p) (* .08 p)]))