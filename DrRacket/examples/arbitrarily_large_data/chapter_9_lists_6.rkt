;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname chapter_9_lists_6) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; BEGIN copy-paste from chapter 9.6

; 'Son' is an abbreviation for 'Set of Numbers'

; A Son.L is one of: 
; – empty 
; – (cons Number Son.L)
; 
; Son is used when it 
; applies to Son.L and Son.R
  

; A Son.R is one of: 
; – empty 
; – (cons Number Son.R)
; 
; Constraint If s is a Son.R, 
; no number occurs twice in s

; Son
; the empty set
(define es '())
 
; Number Son -> Boolean
; is x in s
(define (in? x s)
  (member? x s))

; Number Son.L -> Son.L
; removes x from s 
(define s1.L
  (cons 1 (cons 1 '())))
 
(check-expect
  (set-.L 1 s1.L) es)
 
(define (set-.L x s)
  (remove-all x s))
  

; Number Son.R -> Son.R
; removes x from s
(define s1.R
  (cons 1 '()))
 
(check-expect
  (set-.R 1 s1.R) es)
 
(define (set-.R x s)
  (remove x s))

; Number Son -> Son
; subtracts x from s 
(define (set- x s)
  s)

(define set123-version1
  (cons 1 (cons 2 (cons 3 '()))))
 
(define set123-version2
  (cons 1 (cons 3 (cons 2 '()))))

(define set23-version1
  (cons 2 (cons 3 '())))
 
(define set23-version2
  (cons 3 (cons 2 '())))

;(check-member-of (set-.v1 1 set123.v1)
;                 set23-version1
;                 set23-version2)

; Son -> Boolean
; #true if 1 is not a member of s;  #false otherwise
(define (not-member-1? s)
  (not (in? 1 s)))

(check-satisfied (set-.L 1 set123-version1) not-member-1?) ; replaced set123 with set123-version1
(check-satisfied (set-.L 1 set123-version2) not-member-1?) ; replaced set123 with set123-version2
(check-satisfied (set-.R 1 set123-version1) not-member-1?) ; replaced set123 with set123-version1
(check-satisfied (set-.R 1 set123-version2) not-member-1?) ; replaced set123 with set123-version2
; END copy-paste from chapter 9.6


; Exercise 160
; Design the functions set+.L and set+.R,
; which create a set by adding a number x to some given set s for the left-hand and right-hand data definition, respectively.

; Recall the constraint for Son.R:If s is a Son.R, no number occurs twice in s.
; Given an instance of Son.R, set+.R could make the result not an instance of Son.R if set+.R adds a number that already occurs in the given instance.
; So, set+.R must check first whether the new element is already an instance.

; Number Son.L -> Son.L
; adds given-number to given-set
(check-expect (set+.L 1 '()) (cons 1 '()))
(check-expect (set+.L 1 (cons 1 '())) (cons 1 (cons 1 '())))
(check-member-of  (set+.L 2 (cons 1 '())) ; When we can see the implementation of the data representation (i.e. as conses) and
                  (cons 2 (cons 1 '()))   ; we see the implementation of the function (as cons to front), we know 
                  (cons 1 (cons 2 '())))  ; the result is the first option (cons 2 (cons 1 '())).
(check-member-of  (set+.L 3 (cons 2 (cons 1 '())))
                  (cons 3 (cons 2 (cons 1 '())))
                  (cons 3 (cons 1 (cons 2 '())))
                  (cons 2 (cons 1 (cons 3 '())))
                  (cons 2 (cons 3 (cons 1 '())))
                  (cons 1 (cons 2 (cons 3 '())))
                  (cons 1 (cons 3 (cons 2 '()))))
(define (set+.L given-number given-set)
  (cons given-number given-set))

; Number Son.R -> Son.R
; adds given-number to given-set -- if given-number not already in given-set
(check-expect (set+.R 1 '()) (cons 1 '()))
(check-expect (set+.R 1 (cons 1 '())) (cons 1 '())) ; do not add duplicate element
(check-member-of  (set+.R 2 (cons 1 '())) ; When we can see the implementation of the data representation (i.e. as conses) and
                  (cons 2 (cons 1 '()))   ; we see the implementation of the function (as cons to front), we know 
                  (cons 1 (cons 2 '())))  ; the result is the first option (cons 2 (cons 1 '())).
(check-member-of  (set+.R 3 (cons 2 (cons 1 '())))
                  (cons 3 (cons 2 (cons 1 '())))
                  (cons 3 (cons 1 (cons 2 '())))
                  (cons 2 (cons 1 (cons 3 '())))
                  (cons 2 (cons 3 (cons 1 '())))
                  (cons 1 (cons 2 (cons 3 '())))
                  (cons 1 (cons 3 (cons 2 '()))))
(check-member-of  (set+.R 1 (cons 3 (cons 2 (cons 1 '())))) ; do not add duplicate element
                  (cons 3 (cons 2 (cons 1 '())))
                  (cons 3 (cons 1 (cons 2 '())))
                  (cons 2 (cons 1 (cons 3 '())))
                  (cons 2 (cons 3 (cons 1 '())))
                  (cons 1 (cons 2 (cons 3 '())))
                  (cons 1 (cons 3 (cons 2 '()))))
(define (set+.R given-number given-set)
  (cond
    [(in? given-number given-set) given-set]
    [else (cons given-number given-set)]))