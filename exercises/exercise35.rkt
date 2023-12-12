;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise35) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; 35. Design the function string-last, which extracts the last character from a non-empty string.

; data definitions
; signature, purpose statement, header
; functional examples
; template / take inventory
; write the body
; write functional examples as tests and run them

; we represent:
; - string as String
; - single character as 1String

; String-NonEmpty -> 1String
; returns the last character from an input non-empty-string
; "hello" |-> "o"
; "goodbye" |-> "e"
; (define (string-last string-non-empty)
;   ... string-non-empty ... )

(define (string-last string-non-empty)
  (string-ith string-non-empty (- (string-length string-non-empty) 1)))

(string-last "hello")
"should be"
"o"

(string-last "goodbye")
"should be"
"e"
