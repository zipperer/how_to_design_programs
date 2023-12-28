;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise67) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 67.
; Here is another way to represent bouncing balls:

(define SPEED 3)
(define-struct balld [location direction])
(make-balld 10 "up")

; Interpret this code fragment and create other instances of balld.

; This code fragment represents bouncing balls.
; Each ball has the same speed, 3 -- interpreted as 3 pixels per second.
; (make-balld 10 "up") makes a ball with speed 3 at location
; 10 pixels below the top of the canvas moving toward the top of the canvas.

(make-balld 41 "down") ; makes a ball with speed 3 at 41 pixels
                       ; below the top of the canvas moving
                       ; toward the bottom of the canvas.
