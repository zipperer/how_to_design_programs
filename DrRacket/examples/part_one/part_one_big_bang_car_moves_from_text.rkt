;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname part_one_big_bang_car_moves_from_text) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)
 
(define WIDTH-OF-WORLD 200)
 
(define WHEEL-RADIUS 20)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))

(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))

(define SPACE
  (rectangle WHEEL-RADIUS WHEEL-RADIUS "solid" "transparent")) ; this "transparent" is the main thing I am trying in this file

(define BOTH-WHEELS
  (beside WHEEL SPACE WHEEL))


(define SCENE-WIDTH 1000)
(define SCENE-HEIGHT (/ SCENE-WIDTH 8))
(define CAR-WIDTH (/ SCENE-WIDTH 10))
(define CAR-BOTTOM-HEIGHT (/ CAR-WIDTH 4))
(define CAR-TOP-HEIGHT (/ CAR-WIDTH 6))
(define CAR-HEIGHT (+ CAR-BOTTOM-HEIGHT CAR-TOP-HEIGHT))
(define CAR-TOP-WIDTH (* 3/5 CAR-WIDTH))
(define CAR-WHEEL-RADIUS (/ CAR-BOTTOM-HEIGHT 2))
(define CAR-WHEEL-ONE (circle CAR-WHEEL-RADIUS "solid" "black"))
(define CAR-WHEEL-TWO (circle CAR-WHEEL-RADIUS "solid" "black"))
(define CAR-TOP (rectangle CAR-TOP-WIDTH CAR-TOP-HEIGHT "solid" "red"))
(define CAR-BOTTOM (rectangle CAR-WIDTH CAR-BOTTOM-HEIGHT "solid" "red"))
(define CAR-BODY (above CAR-TOP CAR-BOTTOM))
(define CAR-WITH-WHEELS (underlay/xy CAR-BODY (* 1/8 (image-height CAR-BODY)) (* 1/4 (image-width CAR-BODY)) BOTH-WHEELS))
(define SCENE (empty-scene SCENE-WIDTH SCENE-HEIGHT))
;(place-image CAR-WITH-TWO-WHEELS CAR-WIDTH (- SCENE-HEIGHT (* 5/8 CAR-HEIGHT)) SCENE)
(define PIXELS-PER-CLOCK-TICK 30)
; WORLD-STATE is a number
; - the number of seconds elapsed since start

#|
(define (render world-state)
  (place-image CAR-WITH-TWO-WHEELS (+ CAR-WIDTH (* PIXELS-PER-CLOCK-TICK world-state)) (- SCENE-HEIGHT (* 5/8 CAR-HEIGHT)) SCENE))

(big-bang 0
  [on-tick add1]
  [to-draw render])
|#

(define (car-nose-touches-right-of-scene world-state)
  (>= (+ (* 1.275 CAR-WIDTH) (* PIXELS-PER-CLOCK-TICK world-state)) SCENE-WIDTH)) ; the 1.275 is from twiddling/tinkering. it is not calculated from principles.

#|
(big-bang 0
  [on-tick add1]
  [stop-when car-nose-touches-right-of-scene]
  [to-draw render])
|#