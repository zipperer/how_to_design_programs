;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname part_one_big_bang_car_moves) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

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
(define CAR-FIRST-WHEEL-PLACEMENT-X (/ CAR-WIDTH 9))
(define CAR-FIRST-WHEEL-PLACEMENT-Y (* 2/3 CAR-HEIGHT))
(define CAR-SECOND-WHEEL-PLACEMENT-X (* 6/9 CAR-WIDTH))
;(define CAR-WITH-ONE-WHEEL (overlay/offset CAR-WHEEL-ONE CAR-FIRST-WHEEL-PLACEMENT (- CAR-BOTTOM-HEIGHT) CAR-BODY))
;(define CAR-WITH-TWO-WHEELS (overlay/offset CAR-WHEEL-TWO (- CAR-SECOND-WHEEL-PLACEMENT) (- (* 2/3 CAR-BOTTOM-HEIGHT)) CAR-WITH-ONE-WHEEL))
;(define CAR-WITH-ONE-WHEEL (overlay/xy CAR-WHEEL-ONE CAR-FIRST-WHEEL-PLACEMENT (- (* 3/2 CAR-BOTTOM-HEIGHT)) CAR-BODY))
;(define CAR-WITH-TWO-WHEELS (overlay/xy CAR-WHEEL-TWO (- CAR-SECOND-WHEEL-PLACEMENT) (- (* 3/2 CAR-BOTTOM-HEIGHT)) CAR-WITH-ONE-WHEEL))
;(define CAR-WITH-ONE-WHEEL (place-image CAR-WHEEL-ONE CAR-FIRST-WHEEL-PLACEMENT-X CAR-FIRST-WHEEL-PLACEMENT-Y CAR-BODY))
;(define CAR-WHEELS-IN-A-LINE 
(define CAR-WITH-ONE-WHEEL (underlay/xy CAR-BODY CAR-FIRST-WHEEL-PLACEMENT-X CAR-FIRST-WHEEL-PLACEMENT-Y CAR-WHEEL-ONE))
(define CAR-WITH-TWO-WHEELS (underlay/xy CAR-WITH-ONE-WHEEL CAR-SECOND-WHEEL-PLACEMENT-X CAR-FIRST-WHEEL-PLACEMENT-Y CAR-WHEEL-TWO))
(define SCENE (empty-scene SCENE-WIDTH SCENE-HEIGHT))
;(place-image CAR-WITH-TWO-WHEELS CAR-WIDTH (- SCENE-HEIGHT (* 5/8 CAR-HEIGHT)) SCENE)
(define PIXELS-PER-CLOCK-TICK 30)
; WORLD-STATE is a number
; - the number of seconds elapsed since start

(define (render world-state)
  (place-image CAR-WITH-TWO-WHEELS (+ CAR-WIDTH (* PIXELS-PER-CLOCK-TICK world-state)) (- SCENE-HEIGHT (* 5/8 CAR-HEIGHT)) SCENE))
#|
(big-bang 0
  [on-tick add1]
  [to-draw render])
|#

(define (car-nose-touches-right-of-scene world-state)
  (>= (+ (* 1.275 CAR-WIDTH) (* PIXELS-PER-CLOCK-TICK world-state)) SCENE-WIDTH)) ; the 1.275 is from twiddling/tinkering. it is not calculated from principles.

(big-bang 0
  [on-tick add1]
  [stop-when car-nose-touches-right-of-scene]
  [to-draw render])