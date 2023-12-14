#lang racket

; An AnimationState is a Number.
; interpretation the number of clock ticks 
; since the animation started

(require "exercise39.rkt") ; CAR

(require 2htdp/image)
(require 2htdp/universe)

(define CAR-HEIGHT (image-height CAR))
(define CAR-WIDTH (image-width CAR))
(define BACKGROUND-HEIGHT (* 3 CAR-HEIGHT))
(define BACKGROUND-WIDTH (* 10 CAR-WIDTH))
(define BACKGROUND (empty-scene BACKGROUND-WIDTH BACKGROUND-HEIGHT))
(define tree
  (underlay/xy (circle (* 1/2 CAR-HEIGHT) "solid" "green")
               (- (* 1/3 CAR-HEIGHT) 1) (* 1 CAR-HEIGHT)
               (rectangle (* 1/5 CAR-HEIGHT) (* 2 CAR-HEIGHT) "solid" "brown")))
(define (add-tree-to-background-at-position-of-car-lengths background car-lengths)
  (place-image tree (* car-lengths (image-width CAR)) (- BACKGROUND-HEIGHT (* 1/4 (image-height tree))) background))
(define BACKGROUND-WITH-TREE-1 (add-tree-to-background-at-position-of-car-lengths BACKGROUND 1))
(define BACKGROUND-WITH-TREE-2 (add-tree-to-background-at-position-of-car-lengths BACKGROUND-WITH-TREE-1 3/2))
(define BACKGROUND-WITH-TREE-3 (add-tree-to-background-at-position-of-car-lengths BACKGROUND-WITH-TREE-2 5/2))
(define BACKGROUND-WITH-TREE-4 (add-tree-to-background-at-position-of-car-lengths BACKGROUND-WITH-TREE-3 9/2))
(define BACKGROUND-WITH-TREE-5 (add-tree-to-background-at-position-of-car-lengths BACKGROUND-WITH-TREE-4 12/2))
(define BACKGROUND-WITH-TREE-6 (add-tree-to-background-at-position-of-car-lengths BACKGROUND-WITH-TREE-5 15/2))
(define BACKGROUND-WITH-TREE-7 (add-tree-to-background-at-position-of-car-lengths BACKGROUND-WITH-TREE-6 19/2))

; WorldState -> WorldState
;  updates WorldState on clock tick
; given 1, expect 2
(define (tock current-world-state)
  (add1 current-world-state))

(define Y-CAR (- BACKGROUND-HEIGHT (* 1/2 CAR-HEIGHT)))

(define CAR-DISTANCE-PER-TICK 9)

; WorldState -> Image
;  displays world state as image
(define (render current-world-state)
  (place-image CAR (* current-world-state CAR-DISTANCE-PER-TICK)  Y-CAR BACKGROUND-WITH-TREE-7))

; WorldState -> Boolean
; checks whether car is past right border
(define (end? current-world-state)
  (>= (- (* current-world-state CAR-DISTANCE-PER-TICK) (* 1/2 CAR-WIDTH)) BACKGROUND-WIDTH))

(define (main initial-world-state)
  (big-bang initial-world-state
    [on-tick tock]
    [on-draw render]
    [stop-when end?]))
;(main 100)

(define (render-sine-path current-world-state)
  (place-image CAR (* current-world-state CAR-DISTANCE-PER-TICK)  (- Y-CAR (* 3 (sin current-world-state)))  BACKGROUND-WITH-TREE-7))

(define (main-with-render-sine-path initial-world-state)
  (big-bang initial-world-state
    [on-tick tock]
    [on-draw render-sine-path]
    [on-mouse hyper]
    [stop-when end?]))
;(main-with-render-sine-path 0)


#|
(check-expect (hyper 21 10 20 "enter") 21)
(check-expect (hyper 42 10 20 "button-down") 10)
(check-expect (hyper 42 10 20 "move") 42)
|#

; WorldState Number Number String -> WorldState
; places the car at x-mouse
; if the given me is "button-down" 
; given: 21 10 20 "enter"
; wanted: 21
; given: 42 10 20 "button-down"
; wanted: 10
; given: 42 10 20 "move"
; wanted: 42
#|
(define (hyper x-position-of-car x-mouse y-mouse me)
  x-position-of-car)
|#
; WorldState Number Number String -> WorldState
; places the car at x-mouse
; if the given me is "button-down" 
(define (hyper x-position-of-car x-mouse y-mouse me)
  (cond
    [(string=? "button-down" me) x-mouse]
    [else x-position-of-car]))

(main-with-render-sine-path 0)