;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise141) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; Exercise 141
; If you are asked to design the function cat, which consumes a list of strings and appends them all into one long string,
; you are guaranteed to end up with this partial definition:

; List-of-string -> String
; concatenates all strings in l into one long string
 
(check-expect (cat '()) "")
(check-expect (cat (cons "a" (cons "b" '()))) "ab")
(check-expect
  (cat (cons "ab" (cons "cd" (cons "ef" '()))))
  "abcdef")
 
;(define (cat l)
;  (cond
;    [(empty? l) ""]
;    [else (... (first l) ... (cat (rest l)) ...)]))
#|
l            (first l)   (rest l)      (cat (rest l))    (cat l)
(cons "a"      "a"                           "b"          "ab"
 (cons "b"               (cons "b"
  '()))                        '())

(cons         "ab"                         "cdef"         "abcdef"
 "ab"
 (cons "cd"               (cons "cd"       
   (cons "ef"               (cons "ef"
     '())))                   '()))
Figure 57: A table for cat
|#

;Fill in the table in figure 57.
;Guess a function that can create the desired result from the values computed by the sub-expressions.

;Use DrRacket’s stepper to evaluate (cat (cons "a" '())). 

; A List-of-strings is one of:
; - '()
; - (cons String List-of-strings)
; <arrow from List-of-strings in second clause to List-of-strings in data definition first line>

; List-of-strings -> String
; make one string from elements in input list
; append all strings together in order
(check-expect (cat '()) "")
(check-expect (cat (cons "hot" '())) "hot")
(check-expect (cat (cons "hot" (cons " dog" '()))) "hot dog")
(check-expect (cat (cons "spicy " (cons "hot" (cons " dog" '())))) "spicy hot dog")
(define (cat list-of-strings)
  (cond
    [(empty? list-of-strings) ""]
    [(cons? list-of-strings)
     (string-append (first list-of-strings)
                    (cat (rest list-of-strings)))]))

;(cat (cons "a" '()))