;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise40) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; WorldState -> WorldState 
; moves the car by 3 pixels for every clock tick
; examples:
(check-expect (tock 20) 23) ; given: 20, expect 23
(check-expect (tock 78) 81) ; given: 78, expect 81
(define (tock cw)
  (+ cw 3))