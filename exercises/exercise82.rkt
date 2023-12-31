;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise82) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; Exercise 82.
; Design the function compare-word.
; The function consumes two three-letter words (see exercise 78).
; It produces a word that indicates where the given ones agree and disagree.
; The function retains the content of the structure fields if the two agree;
; otherwise it places #false in the field of the resulting word.
; Hint:
; The exercises mentions two tasks: the comparison of words and the comparison of “letters.”


; Exercise 78
; Provide a structure type and a data definition for representing three-letter words.
; A word consists of lowercase letters, represented with the 1Strings "a" through "z"
; plus #false.
; Note:
; This exercise is a part of the design of a hangman game; see exercise 396.

; A 1StringOrFalse is one of:
; - 1String
; - #false
; e.g. "a" is a 1StringOrFalse since "a" is a 1String
;      #false is a 1StringOrFalse since #false is #false
;      #true is not a 1StringOrFalse since #true is not a 1String and #true is not #false.

(define-struct three-letter-word [first-letter second-letter third-letter])
; A ThreeLetterWord is a structure:
;   (make-three-letter-word 1StringOrFalse 1StringOrFalse 1StringOrFalse)
; interpretation:
;   (make-three-letter-word f s t) represents the three letter word with
;     first letter f, second letter s, and third letter t.
;   e.g. (make-three-letter-word "a" "i" "r") represents the word "air".
;   e.g. (make-three-letter-word "f" "i" "g") represents the word "fig".
;   f, s, and t are all in Union[[a-z],#false]. 
;   That is, f, s, and t are each (a) a lowercase letter between a and z or (b) #false.
;   The syntax [a-z] is suggestive (not grammatical). This data definition does not
;   not enforce lowercase.

; ThreeLetterWord ThreeLetterWord -> ThreeLetterWord
; produces ThreeLetterWord that shows where input ThreeLetterWords agree and disagree
; The function retains the content of the structure fields if the two agree;
; otherwise it places #false in the field of the resulting word.
; stub/header:
; (define (compare-word three-letter-word-a three-letter-word-b)
;   (make-three-letter-word "a" "i" "r"))
(check-expect (compare-word
               (make-three-letter-word "a" "i" "r")
               (make-three-letter-word "a" "i" "r")) (make-three-letter-word "a" "i" "r"))
(check-expect (compare-word
               (make-three-letter-word "f" "i" "r")
               (make-three-letter-word "a" "i" "r")) (make-three-letter-word #false "i" "r"))
(check-expect (compare-word
               (make-three-letter-word "f" "i" "t")
               (make-three-letter-word "a" "i" "r")) (make-three-letter-word #false "i" #false))

(check-expect (compare-word
               (make-three-letter-word "f" "o" "g")
               (make-three-letter-word "a" "i" "r")) (make-three-letter-word #false #false #false))
; template:
; (define (compare-word three-letter-word-a three-letter-word-b)
;   ...
;   make-three-letter-word
;   ...
;   (three-letter-word-first-letter three-letter-word-a) ; 1StringOrFalse
;   ...
;   (three-letter-word-second-letter three-letter-word-a) ; 1StringOrFalse
;   ...
;   (three-letter-word-third-letter three-letter-word-a) ; 1StringOrFalse
;   ...
;   (three-letter-word-first-letter three-letter-word-b) ; 1StringOrFalse
;   ...
;   (three-letter-word-second-letter three-letter-word-b) ; 1StringOrFalse
;   ...
;   (three-letter-word-third-letter three-letter-word-b) ; 1StringOrFalse
;   )

; compare-letter
; 1StringOrFalse 1StringOrFalse -> 1StringOrFalse
; returns 1String when both inputs are 1String and the inputs match
; otherwise, returns #false
; stub/header:
; (define (compare-letter one-string-or-false-a one-string-or-false-b)
;   #false)
(check-expect (compare-letter #false #false) #false)
(check-expect (compare-letter "a" #false) #false)
(check-expect (compare-letter #false "a") #false)
(check-expect (compare-letter "a" "b") #false)
(check-expect (compare-letter "a" "a") "a")
; template:
; (define (compare-letter one-string-or-false-a one-string-or-false-b)
;   ...
;   one-string-or-false-a
;   ...
;   one-string-or-false-b
;   ...
;   #false
;   ...)

; systematic version before simplifying.
; check whether one-string-or-false-a 1String or #false
; if 1String, check whether one-string-or-false-b 1String or #false
; when one-string-or-false-a #false, could expand this further and
; check whether one-string-or-false-b 1String or #false
;(define (compare-letter one-string-or-false-a one-string-or-false-b)
;  (cond
;    [(string? one-string-or-false-a)
;     (cond
;       [(string? one-string-or-false-b)
;        (cond
;          [(string=? one-string-or-false-a one-string-or-false-b) one-string-or-false-a]
;          [else #false])]
;       [else #false])]
;    [else #false]))

(define (compare-letter one-string-or-false-a one-string-or-false-b)
  (cond
    [(and (string? one-string-or-false-a)
          (string? one-string-or-false-b)
          (string=? one-string-or-false-a one-string-or-false-b))
     one-string-or-false-a]
    [else #false]))

(define (compare-word three-letter-word-a three-letter-word-b)
  (make-three-letter-word
   (compare-letter
    (three-letter-word-first-letter three-letter-word-a)
    (three-letter-word-first-letter three-letter-word-b))
   (compare-letter
    (three-letter-word-second-letter three-letter-word-a)
    (three-letter-word-second-letter three-letter-word-b))
   (compare-letter
    (three-letter-word-third-letter three-letter-word-a)
    (three-letter-word-third-letter three-letter-word-b))))