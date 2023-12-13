;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise39) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; Exercise 39.
;  Good programmers ensure that an image such as CAR can be enlarged or reduced via a single change to a constant definition.
;
;  Good programmers establish a single point of control for all aspects of their programs, not just the graphical constants.
;  Several chapters deal with this issue.
;
;  We started the development of our car image with a single plain definition:
;    (define WHEEL-RADIUS 5)
;
;  The definition of WHEEL-DISTANCE is based on the wheel’s radius.
;  Hence, changing WHEEL-RADIUS from 5 to 10 doubles the size of the car image.
;  This kind of program organization is dubbed single point of control, and good design employs this idea as much as possible.
;  Develop your favorite image of an automobile so that WHEEL-RADIUS remains the single point of control.

(require 2htdp/image)

; All of the fractions are magic numbers
(define WHEEL-RADIUS 30)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))
(define WHEEL (circle WHEEL-RADIUS "solid" "black"))
(define SPACE-BETWEEN-WHEELS (rectangle (* 2 WHEEL-RADIUS) WHEEL-RADIUS "solid" "transparent"))
(define BOTH-WHEELS (beside WHEEL SPACE-BETWEEN-WHEELS WHEEL))
(define CAR-BODY-BOTTOM-WIDTH (* 3/2 WHEEL-DISTANCE))
(define CAR-BODY-BOTTOM-HEIGHT (* 1/3 CAR-BODY-BOTTOM-WIDTH))
(define CAR-BODY-TOP-WIDTH (* 2/3 CAR-BODY-BOTTOM-WIDTH))
(define CAR-BODY-TOP-HEIGHT (* 1/3 CAR-BODY-TOP-WIDTH))
(define CAR-BODY-HEIGHT (+ CAR-BODY-BOTTOM-HEIGHT CAR-BODY-TOP-HEIGHT))
(define CAR-BODY-BOTTOM (rectangle CAR-BODY-BOTTOM-WIDTH CAR-BODY-BOTTOM-HEIGHT "solid" "red"))
(define CAR-BODY-TOP (rectangle CAR-BODY-TOP-WIDTH CAR-BODY-TOP-HEIGHT "solid" "red"))
(define CAR-BODY (above CAR-BODY-TOP CAR-BODY-BOTTOM))
(define CAR (underlay/xy CAR-BODY (* 1/8 CAR-BODY-BOTTOM-WIDTH) (* 3/4 CAR-BODY-HEIGHT) BOTH-WHEELS))
CAR