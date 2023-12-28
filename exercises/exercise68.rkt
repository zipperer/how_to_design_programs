;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise68) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct ball [location velocity])

(define-struct vel [deltax deltay])

(define ball1
  (make-ball (make-posn 30 40)
             (make-vel -10 5)))

; Interpretation of ball1:
; One way to interpret this instance is to
; think of a ball that is 30 pixels from the
; left and 40 pixels from the top. It moves 10
; pixels toward the left per clock tick, because
; subtracting 10 pixels from the x-coordinate
; brings it closer to the left. As for the
; vertical direction, the ball drops at 5 pixels
; per clock tick, because adding positive numbers
; to a y-coordinate increases the distance from the top.


; Exercise 68.
; An alternative to the nested data representation of balls uses four fields to keep track of the four properties:
(define-struct ballf [x y deltax deltay])

; Programmers call this a flat representation.
; Create an instance of ballf that has the same
; interpretation as ball1.

(define ballf1
  (make-ballf
   30 ; x
   40 ; y
   10 ; deltax
   -5 ; deltay
   ))

(check-expect (ball-velocity ball1) (make-vel -10 5))
(check-expect (vel-deltax (ball-velocity ball1)) -10)