;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise34) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 34.
; Design the function string-first, which extracts the first character from a non-empty string.
; Don’t worry about empty strings.

; 1. Express how you wish to represent information as data.

; We use Strings to represent strings.

; 2. Write down a signature, a statement of purpose, and a function header.

; Signature:
; String-NonEmpty -> 1String

; Purpose statement: (i.e. what does the function compute)
; return first character from input string-non-empty

; Header: (i.e. a simplistic function definition. also called a stub)
; (define (string-first string-non-empty)
;   ... string-non-empty ...)

; Functional examples:
; "hello" |-> "h"
; "goodbye" |-> "g"


; Reformat above as:
; Signature
; Purpose Statement
; Functional Examples
; Stub

; String-NonEmpty -> 1String
; return first character from input string-non-empty
; given: "hello", expect: "h"
; given: "goodbye", expect: "g"
; (define (string-first string-non-empty)
;   ... string-non-empty ...)

; use the inventory to compute result
(define (string-first string-non-empty)
  (string-ith string-non-empty 0))

(string-first "hello")
"should be"
"h"

(string-first "goodbye")
"should be"
"g"