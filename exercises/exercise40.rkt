#lang racket
(provide tock)

; WorldState -> WorldState 
; moves the car by 3 pixels for every clock tick
; examples:
(define (tock cw)
  (+ cw 3))
;(check-expect (tock 20) 23) ; given: 20, expect 23
;(check-expect (tock 78) 81) ; given: 78, expect 81