#lang racket

; A WorldState is a Number.
; interpretation the number of pixels between
; the left border of the scene and the right-most edge of the car

(require "exercise39.rkt") ; CAR
(require "exercise40.rkt") ; tock
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

(define Y-CAR (- BACKGROUND-HEIGHT (* 1/2 CAR-HEIGHT)))

; WorldState -> Image
; places the car into the BACKGROUND scene,
; according to the given world state 
(define (render current-world-state)
  (place-image CAR current-world-state Y-CAR BACKGROUND-WITH-TREE-7))

; WorldState -> Boolean
; checks whether car is past right border
(define (end? current-world-state)
  (>= (- current-world-state CAR-WIDTH) BACKGROUND-WIDTH))

(define (main initial-distance-of-car-from-left-of-scene)
  (big-bang initial-distance-of-car-from-left-of-scene
    [on-tick tock]
    [to-draw render]
    [stop-when end?]))
(main CAR-WIDTH)