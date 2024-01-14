;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname chapter_9_lists_1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Number Any -> List[Any]
(define (my-make-list number-occurrences value)
  (cond
    [(= 0 number-occurrences) '()]
    [else
     (cons value (my-make-list (sub1 number-occurrences) value))]))

(check-expect (my-make-list 2 "hello") (cons "hello" (cons "hello" '())))
(check-expect (my-make-list 3 #true) (cons #true (cons #true (cons #true '()))))
(check-expect (my-make-list 0 17) '())

; An N is one of:
; - 0
; - (add1 N)
; interpretation:
;   represents the counting numbers
; e.g.
; 0 is an N
; (add1 0) is an N
; (add1 (add1 0)) is an N

; N String -> List-of-strings
; creates a list of n copies of s
(check-expect (copier 0 "hello") '())
(check-expect (copier 2 "hello") (cons "hello" (cons "hello" '())))
;(define (copier n s)
;  '())
;(define (copier n s)
;  (cond
;    [(zero? n) ...]
;    [(positive? n) (... (copier (sub1 n) s) ...)]))
(define (copier n s)
  (cond
    [(zero? n) '()]
    [(positive? n) (cons s (copier (sub1 n) s))]))


; Exercise 149
; Does copier function properly when you apply it to a natural number and a Boolean or an image?
; Or do you have to design another function? Read Abstraction for an answer.

; `copier` does not rely on the type of s. `copier` conses `s` onto a list.
; Because `copier` does not rely on the type of `s`, yes, it would work properly on a Boolean or an image.
; We can reuse `copier` for other datatypes.

; An alternative definition of copier might use else:
(define (copier.v2 n s)
  (cond
    [(zero? n) '()]
    [else (cons s (copier.v2 (sub1 n) s))]))
; How do copier and copier.v2 behave when you apply them to 0.1 and "x"?
; Explain.
; 0.1
; `(copier.v2 0.1)` never terminates because (sub1 0.1) skips zero and goes negative and the number never satisfies the base case.
; `(copier 0.1)` terminates with an error when no cond clause applies when n = -.9
; "x"
; `(copier.v2 "x")` errors when evaluation attempts to subtract one from "x".
; `(copier "x")` errors when neither cond clause applies.

; Oops. I misinterpreted the question. copier{,.v2} takes two arguments, the question is about
; `(copier.v2 0.1 "x")` rather than (copier.v2 0.1) and (copier.v2 "x").
; And, I was wrong about (copier.v2 "x" "x"). zero? errors when not given number.

; Use DrRacket’s stepper to confirm your explanation. 

; (copier.v2 0.1 "x")
; (copier 0.1 "x")
; (copier.v2 "x" "x")
; (copier "x" "x")