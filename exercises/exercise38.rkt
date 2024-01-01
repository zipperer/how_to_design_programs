#lang racket
(provide string-remove-last)
; Exercise 38. Design the function string-remove-last, which produces a string like the given one with the last character removed.

; data definitions
; signature, purpose statement, header
; functional examples
; take inventory, make template
; fill in template
; write functional examples as tests and run them

; We represent:
; - Strings and Strings

; We assume:
; - input String can have any length >= 0

; string-remove-last: String -> String
;  return string identical to input string except returned string lacks last 1String from input string
; (define (string-remove-last input-string)
;   "abc")
; given: "hello", expect: "hell"
; given: "barbaric", expect: "barbari"
; given: "a", expect: ""
; given: "", expect: ""
; (define (string-remove-last input-string)
;   ... input-string ...)

(define (string-remove-last input-string)
  (cond
    ((<= (string-length input-string) 1)
     "")
    (else (substring input-string 0 (- (string-length input-string) 1)))))

(string-remove-last "hello")
"should be"
"hell"

(string-remove-last "barbaric")
"should be"
"barbari"

(string-remove-last "a")
"should be"
""

(string-remove-last "")
"should be"
""
