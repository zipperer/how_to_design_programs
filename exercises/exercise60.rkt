;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise60) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 60: An alternative data representation for a traffic
; light program may use numbers instead of strings:

; An N-TrafficLight is one of:
; - 0 interpretation the traffic light shows red
; - 1 interpretation the traffic light show green
; - 2 interpretation the traffic light shows yellow

; It greatly simplifies the definition of tl-next:
; N-TrafficLight -> N-TrafficLight
; yields the next state, given current state cs
(define (tl-next-numeric cs)
  (modulo (+ cs 1) 3))

; Reformulate tl-next's tests for tl-next-numeric.

; (check-expect (tl-next "red") "green")
; (check-expect (tl-next "green") "yellow")
; (check-expect (tl-next "yellow") "red")

(check-expect (tl-next-numeric 0) 1)
(check-expect (tl-next-numeric 1) 2)
(check-expect (tl-next-numeric 2) 0)

; Does the tl-next function convey its intention
; more clearly than the tl-next-numeric function?
; If so, why? If not, why not?

; The tl-next function conveys its intention more
; clearly to me than the tl-next-numeric function.
; The N-TrafficLight data definition implicitly
; contains a mapping from 0 to red, 1 to green,
; and 2 to yellow. I, the reader, have to carry
; that mapping in my head or consult it when I
; forget. So too for TrafficLight is there a mapping
; from "red" to red, "green" to green, and "yellow" to
; yellow. However, this latter mapping is more
; self-documenting and so is easier to remember.

; I am familiar with American traffic lights.
; If the domain were more foreign to me, then
; an abstract representation that uses numbers
; and modulo may help me see the progression
; from 0 to 1 to ... N to 0. 