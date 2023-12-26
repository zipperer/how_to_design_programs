;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise61) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 61
; As From Functions to Programs says, programs must define
; constants and use names instead of actual constants (i.e.
; literal numbers, literal strings). In this spirit, a
; data definition for traffic lights must use constants
; too.

(define RED 0)
(define GREEN 1)
(define YELLOW 2)

; An S-TrafficLight is one of:
; - RED
; - GREEN
; - YELLOW

; If the names are chosen properly, the data definition
; does not need an interpretation statement.

; S-TrafficLight -> S-TrafficLight
; yields the next state given current state current-state
(check-expect (tl-next-symbolic RED) GREEN)
(check-expect (tl-next-symbolic GREEN) YELLOW)
(check-expect (tl-next-symbolic YELLOW) RED)

(define (tl-next-symbolic current-state)
  (cond
    [(equal? RED current-state) GREEN]
    [(equal? GREEN current-state) YELLOW]
    [(equal? YELLOW current-state) RED]))

; tl-next-symbolic is properly designed using the recipe
; for itemization. In contrast, tl-next-numeric is not:

(define (tl-next-numeric current-state)
  (modulo (+ current-state 1) 3))

; tl-next-symbolic continues to work if we change the
; constants to
; (define RED "red")
; (define YELLOW "yellow")
; (define GREEN "green")
; and tl-next-numeric fails to work after that change.

; Aside: The equal? function in tl-next-symbolic compares
; two arbitrary values, regardless of what these values
; are. Equality is a complicated topic in the world of
; programming.