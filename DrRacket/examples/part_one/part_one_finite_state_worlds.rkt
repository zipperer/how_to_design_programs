;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname part_one_finite_state_worlds) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; A TrafficLight is one of the following:
; - "green"
; - "yellow"
; - "red"

; A TrafficLight can transition from
;  green to yellow
;  yellow to red
;  red to green

; TrafficLight -> TrafficLight
; yields the next state given current state current-state
(define (tl-next current-state)
  current-state)

; TrafficLight -> Image
; renders the current state current-state as an image
(define (tl-render current-state)
  (empty-scene 90 30))

