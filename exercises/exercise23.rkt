;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise23) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define (string-first s)
  (substring s 0 1))

(string-first "hello world")

; From https://docs.racket-lang.org/htdp-langs/beginner.html#%28def._htdp-beginner._%28%28lib._lang%2Fhtdp-beginner..rkt%29._substring%29%29

;(substring s i j) → string

;  s : string
;  i : natural?
;  j : natural?

; Extracts the substring starting at i up to j (or the end if j is not provided).

; > (substring "hello world" 1 5)
; "ello" ;      012345

; > (substring "hello world" 1 8)
; "ello wo" ;   012345678

; > (substring "hello world" 4)
; "o world" ;   0123456789    

; So, 
; > (substring s 0 1)
; ==
;   (substring "hello world")
;               01
; ==
;   "h"
;
; the substring that starts at (index) 0 up to (index) 1 is "h"
; 