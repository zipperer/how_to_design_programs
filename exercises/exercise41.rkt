#lang racket

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
(define BACKGROUND-WITH-TREE-1 (place-image tree (image-width CAR) (- BACKGROUND-HEIGHT (* 1/4 (image-height tree))) BACKGROUND))
(define BACKGROUND-WITH-TREE-2 (place-image tree (* 3/2 (image-width CAR)) (- BACKGROUND-HEIGHT (* 1/4 (image-height tree))) BACKGROUND-WITH-TREE-1))
(define BACKGROUND-WITH-TREE-3 (place-image tree (* 5/2 (image-width CAR)) (- BACKGROUND-HEIGHT (* 1/4 (image-height tree))) BACKGROUND-WITH-TREE-2))
(define BACKGROUND-WITH-TREE-4 (place-image tree (* 9/2 (image-width CAR)) (- BACKGROUND-HEIGHT (* 1/4 (image-height tree))) BACKGROUND-WITH-TREE-3))
(define BACKGROUND-WITH-TREE-5 (place-image tree (* 12/2 (image-width CAR)) (- BACKGROUND-HEIGHT (* 1/4 (image-height tree))) BACKGROUND-WITH-TREE-4))
(define BACKGROUND-WITH-TREE-6 (place-image tree (* 15/2 (image-width CAR)) (- BACKGROUND-HEIGHT (* 1/4 (image-height tree))) BACKGROUND-WITH-TREE-5))
(define BACKGROUND-WITH-TREE-7 (place-image tree (* 19/2 (image-width CAR)) (- BACKGROUND-HEIGHT (* 1/4 (image-height tree))) BACKGROUND-WITH-TREE-6))
BACKGROUND-WITH-TREE-7
(define Y-CAR (- BACKGROUND-HEIGHT (* 1/2 CAR-HEIGHT)))

; WorldState -> Image
; places the car into the BACKGROUND scene,
; according to the given world state 
(define (render current-world-state)
  (place-image CAR current-world-state Y-CAR BACKGROUND-WITH-TREE-7))

; WorldState -> Boolean
; checks whether car is past right border
(define (end? current-world-state)
  (>= (- current-world-state (* 1/2 CAR-WIDTH)) BACKGROUND-WIDTH))

(define (main initial-distance-of-car-from-left-of-scene)
  (big-bang initial-distance-of-car-from-left-of-scene
    [on-tick tock]
    [to-draw render]
    [stop-when end?]))
(main CAR-WIDTH)