;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise164) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 164.
; Design the function convert-euro, which converts a list of US$ amounts into a list of € amounts.
; Look up the current exchange rate on the web.

(define CURRENT-DOLLAR-TO-EURO-EXCHANGE-RATE .93)

; Number -> Number
; converts a US$ amount into a € amount
(check-expect (convert-us-dollar-amount-to-euro-amount 1) (* CURRENT-DOLLAR-TO-EURO-EXCHANGE-RATE 1))
(check-expect (convert-us-dollar-amount-to-euro-amount 2) (* CURRENT-DOLLAR-TO-EURO-EXCHANGE-RATE 2))
(define (convert-us-dollar-amount-to-euro-amount us-dollar-amount)
  (* CURRENT-DOLLAR-TO-EURO-EXCHANGE-RATE us-dollar-amount))

; List-of-Numbers -> List-of-Numbers
; converts a list of US$ amounts into a list of € amounts
(check-expect (convert-euro '()) '())
(check-expect (convert-euro (cons 1 '())) (cons (convert-us-dollar-amount-to-euro-amount 1) '()))
(check-expect (convert-euro (cons 1 (cons 2 '()))) (cons (convert-us-dollar-amount-to-euro-amount 1)
                                                         (cons (convert-us-dollar-amount-to-euro-amount 2) '())))
(define (convert-euro list-of-us-dollar-amounts)
  (cond
    [(empty? list-of-us-dollar-amounts) '()]
    [(cons? list-of-us-dollar-amounts)
     (cons
      (convert-us-dollar-amount-to-euro-amount (first list-of-us-dollar-amounts))
      (convert-euro (rest list-of-us-dollar-amounts)))]))
; template 
;(define (convert-euro list-of-us-dollar-amounts)
;  (cond
;    [(empty? list-of-us-dollar-amounts) '()]
;    [(cons? list-of-us-dollar-amounts)
;     ...
;     (first list-of-us-dollar-amounts) ; Number that represents a US dollar amount
;     ...
;     (convert-euro (rest list-of-us-dollar-amounts)) ; List-of-Numbers that represents list of € amounts that
;                                                     ;   results from converting (rest list-of-us-dollar-amounts)
;     ...
;     ]))

; Generalize convert-euro to the function convert-euro*,
; which consumes an exchange rate and a list of US$ amounts
; and converts the latter into a list of € amounts.
(check-expect (convert-us-dollar-amount-to-euro-dollar-amount-given-exchange-rate 1 CURRENT-DOLLAR-TO-EURO-EXCHANGE-RATE)
              (* CURRENT-DOLLAR-TO-EURO-EXCHANGE-RATE 1))
(check-expect (convert-us-dollar-amount-to-euro-dollar-amount-given-exchange-rate 2 CURRENT-DOLLAR-TO-EURO-EXCHANGE-RATE)
              (* CURRENT-DOLLAR-TO-EURO-EXCHANGE-RATE 2))
(define (convert-us-dollar-amount-to-euro-dollar-amount-given-exchange-rate
         us-dollar-amount
         us-dollar-to-euro-exchange-rate)
  (* us-dollar-to-euro-exchange-rate us-dollar-amount))

; Number List-of-Numbers -> List-of-Numbers
; takes exchange rate (USD->€) and list of USD amounts
; returns list of € amounts that result from converting each USD amount
(check-expect (convert-euro* CURRENT-DOLLAR-TO-EURO-EXCHANGE-RATE '()) '())
(check-expect (convert-euro* CURRENT-DOLLAR-TO-EURO-EXCHANGE-RATE
                             (cons 1 '()))
              (cons (convert-us-dollar-amount-to-euro-dollar-amount-given-exchange-rate 1 CURRENT-DOLLAR-TO-EURO-EXCHANGE-RATE)
                    '()))
(check-expect (convert-euro* CURRENT-DOLLAR-TO-EURO-EXCHANGE-RATE
                             (cons 1 (cons 2 '())))
              (cons (convert-us-dollar-amount-to-euro-dollar-amount-given-exchange-rate 1 CURRENT-DOLLAR-TO-EURO-EXCHANGE-RATE)
                    (cons (convert-us-dollar-amount-to-euro-dollar-amount-given-exchange-rate 2 CURRENT-DOLLAR-TO-EURO-EXCHANGE-RATE)
                          '())))
(define (convert-euro* exchange-rate-us-dollar-amount-to-euro-amount list-of-us-dollar-amounts)
  (cond
    [(empty? list-of-us-dollar-amounts) '()]
    [(cons? list-of-us-dollar-amounts)
     (cons
      (convert-us-dollar-amount-to-euro-dollar-amount-given-exchange-rate
       (first list-of-us-dollar-amounts)
       exchange-rate-us-dollar-amount-to-euro-amount)
      (convert-euro* exchange-rate-us-dollar-amount-to-euro-amount (rest list-of-us-dollar-amounts)))]))

; template
;(define (convert-euro* exchange-rate-us-dollar-amount-to-euro-amount list-of-us-dollar-amounts)
;  (cond
;    [(empty? list-of-us-dollar-amounts) '()]
;    [(cons? list-of-us-dollar-amounts)
;     ...
;     (first list-of-us-dollar-amounts) ; Number that represents a US dollar amount
;     ...
;     exchange-rate-us-dollar-amount-to-euro-amount ; Number that represents the exchange rate from dollars to euros
;     ...
;     (convert-euro* exchange-rate-us-dollar-amount-to-euro-amount
;        exchange-rate-us-dollar-amount-to-euro-amount
;        (rest list-of-us-dollar-amounts)) ; List-of-Numbers that
;     ...                                  ; represents the list of euro amounts that results from converting
;     ]                                    ; the rest of the input us dollar amounts into euro amounts
;    ))