;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise51) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)
(require 2htdp/batch-io)

; WorldState is a Number
; - the number represents the number of seconds remaining in the world
; -- so, the program decrements the number on each clock tick
; -- and clock ticks once per second

(define NUMBER-OF-STATES-FOR-TRAFFIC-LIGHT 3)
(define BACKGROUND-HEIGHT 100)
(define BACKGROUND-WIDTH 100)
(define BACKGROUND (empty-scene BACKGROUND-WIDTH BACKGROUND-HEIGHT))
(define LIGHT-POSITION-X (* 1/2 BACKGROUND-WIDTH))
(define LIGHT-POSITION-Y (* 1/2 BACKGROUND-HEIGHT))

; I claim: this is not what the book authors expect.
; I think WorldState should include both the current seconds remaining and also the current state of the light.
; If the current world state included the current state of the light, then
; - it could always start with red, and 
; - we could use the function traffic-light-next from the text
(define (traffic-light-from-current-world-state current-world-state-modded-by-number-of-states-of-traffic-light)
  (cond
    [(= 0 current-world-state-modded-by-number-of-states-of-traffic-light) "yellow"]
    [(= 1 current-world-state-modded-by-number-of-states-of-traffic-light) "green"]
    [(= 2 current-world-state-modded-by-number-of-states-of-traffic-light) "red"]))
(define (render current-world-state)
  (place-image (circle 10
                       "solid"
                       (traffic-light-from-current-world-state (modulo current-world-state NUMBER-OF-STATES-FOR-TRAFFIC-LIGHT)))
               LIGHT-POSITION-X
               LIGHT-POSITION-Y
               BACKGROUND))

(define (tock current-world-state)
   (sub1 current-world-state))

(define TICKS-PER-SECOND 1)

(define (simulate-traffic-light-for-duration duration)
  (big-bang duration
    [stop-when zero?]
    [to-draw render]
    [on-tick tock TICKS-PER-SECOND]))

(simulate-traffic-light-for-duration 10)