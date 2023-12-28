;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise72) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; Exercise 72.
; Formulate a data definition for the above phone
; structure type definition that accommodates the given examples.

(define-struct phone [area number])
; A Phone is a structure:
;   (make-phone Number String)
; For example,
(check-expect (phone? (make-phone 207 "363-2421")) #true)
(check-expect (phone? (make-phone 101 "776-1099")) #true)
(check-expect (phone? (make-phone 208 "112-9981")) #true)
; interpretation: area refers to the area code -- the first 3 digits
;                 number refers to the remaining 7 digits, formatted
;                 with 3 digits, a dash, then 4 more digits.

; Next formulate a data definition for phone numbers using this
; structure type definition:
;(define-struct phone# [area switch num])

; Historically, the first three digits make up the area code,
; the next three the code for the phone switch (exchange) of
; your neighborhood, and the last four the phone with respect
; to the neighborhood. Describe the content of the three fields
; as precisely as possible with intervals.

(define-struct phone# [area switch num])
; A Phone# is a structure:
;   (make-phone# Number Number Number)
; For example,
(check-expect (phone#? (make-phone# 207 363 2421)) #true)
(check-expect (phone#? (make-phone# 101 776 1099)) #true)
(check-expect (phone#? (make-phone# 208 112 9981)) #true)
; interpretation: area refers to the area code -- the first 3 digits.
;                 switch refers to the neighborhood code -- the next 3 digits.
;                 num refers to the code for the particular phone -- the last 4 digits.
; an area is a Number in [000, 999]
; a switch is a Number in [000, 999]
; a num is a Number in [0000, 9999]
;
; Treating sequences of digits as Number is incorrect, because
; 0 |-> 0
; 00 |-> 0
; 000 |-> 0
; 0000 |-> 0
; Consider (make-phone# 000 000 0000). This will evaluate to
;          (make-phone# 0   0   0).
; That is, the sequence of digits is reduced to a single digit.
; Similar problem occurs for 0001 |-> 1.
; Some alternative ways out of the problem:
; - these are Strings rather than Numbers
; - disallow leading 0s
