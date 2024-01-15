;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname chapter_9_lists_4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

; Sample Problem
; Design a world program that simulates firing shots.
; Every time the “player” hits the space bar, the program adds a shot to the bottom of the canvas.
; These shots rise vertically at the rate of one pixel per tick.

(define HEIGHT 220) ; distances in terms of pixels ; 80 -> 220 for exercise 157
(define WIDTH 30) ; 100 -> 30 for exercise 157
(define XSHOTS (/ WIDTH 3)) ; (/ WIDTH 2) -> (/ WIDTH 3) for exercise 157
 
; graphical constants 
(define BACKGROUND (empty-scene WIDTH HEIGHT "green")) ; (empty-scene WIDTH HEIGHT) -> (empty-scene WIDTH HEIGHT "green") for exercise 157
(define SHOT (rectangle 6 18 "solid" "black")) ; (triangle 3 "solid" "red") -> (rectangle 3 9 "solid" "red") for exercise 157
;                                                                           -> (rectangle 6 18 "solid" "red")
;                                                                           -> (rectangle 6 18 "solid" "black")

; A List-of-shots is one of: 
; – '()
; – (cons Shot List-of-shots)
; interpretation:
;   the collection of shots fired

; A Shot is a Number.
; interpretation represents the shot's y-coordinate

; Alternative data definition for world state:
; A ShotWorld is List-of-numbers. 
; interpretation each number on such a list
;   represents the y-coordinate of a shot

; Exercise 156
; Equip the program in figure 61 with tests and make sure it passes those.

; ShotWorld -> ShotWorld 
(define (main w0)
  (big-bang w0
    [on-tick tock-alternative]
    [on-key keyh]
    [to-draw to-image]))
 
; ShotWorld -> ShotWorld 
; moves each shot up by one pixel
(check-expect (tock '()) '())
(check-expect (tock (cons 9 '())) (cons 8 '()))
(check-expect (tock (cons 10 (cons 9 '()))) (cons 9 (cons 8 '())))
(define (tock w)
  (cond
    [(empty? w) '()]
    [else (cons (sub1 (first w)) (tock (rest w)))]))

; ShotWorld -> ShotWorld 
; moves each shot up by one pixel
(check-expect (tock-alternative '()) '())
(check-expect (tock-alternative (cons 9 '())) (cons 8 '()))
(check-expect (tock-alternative (cons 10 (cons 9 '()))) (cons 9 (cons 8 '())))
(check-expect (tock-alternative (cons 0 '())) '())
(define (tock-alternative w)
  (cond
    [(empty? w) '()]
    [else
     (if (updated-y-position-is-on-screen? w)
         (cons (sub1 (first w)) (tock-alternative (rest w)))
         (tock-alternative (rest w)))]))

(define (updated-y-position-is-on-screen? w)
  (>= (sub1 (first w)) 0))

;(define (add-updated-first-element-to-world-state-unless-element-is-off-screen w)
  


 
; ShotWorld KeyEvent -> ShotWorld 
; adds a shot to the world if the space bar is hit
(check-expect (keyh '() " ") (cons HEIGHT '()))
(check-expect (keyh (cons (/ HEIGHT 2) '()) " ") (cons HEIGHT (cons (/ HEIGHT 2) '())))
(check-expect (keyh (cons (/ HEIGHT 2) '()) "a") (cons (/ HEIGHT 2) '()))
(define (keyh w ke)
  (if (key=? ke " ") (cons HEIGHT w) w))
 
; ShotWorld -> Image 
; adds each shot y on w at (XSHOTS,y} to BACKGROUND
(check-expect (to-image '()) BACKGROUND)
(check-expect (to-image (cons 9 '())) (place-image SHOT XSHOTS 9 BACKGROUND))
(check-expect (to-image (cons 12 (cons 9 '()))) (place-image SHOT XSHOTS 12 (place-image SHOT XSHOTS 9 BACKGROUND)))
(define (to-image w)
  (cond
    [(empty? w) BACKGROUND]
    [else (place-image SHOT XSHOTS (first w)
                       (to-image (rest w)))]))

; Explain what main does. Then run the program via main.
; main:
; - takes an initial ShotWorld world state
; - registers handler functions for clock ticks and key events
; - registers a handler function to render the world state as an image
; - starts a world with world state and clock ticks and key press listeners and a render-on-upate procedure

(main '())

; Exercise 158
; If you run main, press the space bar (fire a shot), and wait for a goodly amount of time, the shot disappears from the canvas.
; When you shut down the world canvas, however, the result is a world that still contains this invisible shot.

; Design an alternative tock function that doesn’t just move shots one pixel per clock tick but also eliminates those whose
; coordinates place them above the canvas.
; Hint: You may wish to consider the design of an auxiliary function for the recursive cond clause. 