;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise165) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 165.                                                                                       
; Design the function subst-robot,                                                                    
; which consumes a list of toy descriptions (one-word strings) and                                    
; replaces all occurrences of "robot" with "r2d2";                                                    
; all other descriptions remain the same.                                                             
                                                                                                      
; Generalize subst-robot to substitute.                                                               
; The latter consumes two strings, called new and old, and a list of strings.                         
; It produces a new list of strings by substituting all occurrences of old with new.

; List-of-strings -> List-of-strings
;  constraint: input List-of-strings: each string is one word long
; takes a list of toy descriptions
; returns list of toy descriptions where each occurrence of "robot" in input list is replaced with "r2d2"
(check-expect (subst-robot '()) '())
(check-expect (subst-robot (cons "robot" '())) (cons "r2d2" '()))
(check-expect (subst-robot (cons "robot" (cons "songbox" '()))) (cons "r2d2" (cons "songbox" '())))
(check-expect (subst-robot (cons "lego" (cons "robot" (cons "songbox" '())))) (cons "lego" (cons "r2d2" (cons "songbox" '()))))
(define (subst-robot list-of-toy-descriptions)
  (cond
    [(empty? list-of-toy-descriptions) '()]
    [(cons? list-of-toy-descriptions)
     (cond
       [(string=? "robot" (first list-of-toy-descriptions))
        (cons "r2d2" (subst-robot (rest list-of-toy-descriptions)))]
       [else (cons (first list-of-toy-descriptions) (subst-robot (rest list-of-toy-descriptions)))])]))

; String String List-of-strings -> List-of-strings
; takes two strings, new and old, and a list of strings
; returns new list of strings where each occurence of old is replaced by an occurrece of new
(check-expect (substitute "new" "old" '()) '())
(check-expect (substitute "new" "old" (cons "new" '())) (cons "new" '()))
(check-expect (substitute "new" "old" (cons "old" '())) (cons "new" '()))
(check-expect (substitute "r2d2" "robot" (cons "robot" '())) (cons "r2d2" '()))
(check-expect (substitute "r2d2" "robot" (cons "robot" (cons "songbox" '()))) (cons "r2d2" (cons "songbox" '())))
(check-expect (substitute "r2d2" "robot" (cons "lego" (cons "robot" (cons "songbox" '())))) (cons "lego" (cons "r2d2" (cons "songbox" '()))))
(define (substitute new old list-of-strings)
  (cond
    [(empty? list-of-strings) '()]
    [(cons? list-of-strings)
     (cond
       [(string=? old (first list-of-strings))
        (cons new (substitute new old (rest list-of-strings)))]
       [else
        (cons (first list-of-strings) (substitute new old (rest list-of-strings)))])]))