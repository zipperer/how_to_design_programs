;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise37) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 37. Design the function string-rest, which produces a string like the given one with the first character removed.

; data definitions
; signature, purpose statement, header
; functional examples
; take inventory, make template
; fill-in template
; write functional examples as tests and run them

; We represent:
; - a string as a string

; We will assume input string can be empty or length 1 or length greater than 1.

; String -> String
;   return string that is same as input string except returned string lacks the first 1String
; (define (string-rest input-string)
;   "ab")
; given: "hello", expect: "ello"
; given "barbaric", expect "arbaric"
; given "a", expect: ""
; given: "", expect: ""
; (define (string-rest input-string)
;   ... input-string ...)
(define (string-rest input-string)
  (cond
    ((<= (string-length input-string) 1)
     "")
    (else (substring input-string 1))))

(string-rest "hello")
"should be"
"ello"

(string-rest "barbaric")
"should be"
"arbaric"

(string-rest "a")
"should be"
""

(string-rest "")
"should be"
""