;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname chapter_9_lists_3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

; Sample Problem
; Design a world program that simulates firing shots.
; Every time the “player” hits the space bar, the program adds a shot to the bottom of the canvas.
; These shots rise vertically at the rate of one pixel per tick.

; AZ version

(define NUMBER-PIXELS-SHOTS-RISE-PER-CLOCK-TICK 1)
(define BACKGROUND-WIDTH 100)
(define BACKGROUND-HEIGHT 100)
(define BACKGROUND-MIDDLE-X (/ BACKGROUND-WIDTH 2))
(define BACKGROUND (empty-scene BACKGROUND-WIDTH BACKGROUND-HEIGHT))
(define MISSILE-WIDTH (/ BACKGROUND-WIDTH 5))
(define MISSILE-HEIGHT (/ BACKGROUND-WIDTH 10))
(define MISSILE (rectangle MISSILE-WIDTH MISSILE-HEIGHT "solid" "red"))
; A Missile is a Posn

; A ShotsFiredWorldState is a list of Missiles. So, it is a list of Posns. So, it is one of:
; - '()
; - (cons Posn ShotsFiredWorldState)

; ShotsFiredWorldState -> Image
; draws missiles on screen
(define (render-shots-fired-world-state shots-fired-world-state)
  (cond
    [(empty? shots-fired-world-state) BACKGROUND]
    [(cons? shots-fired-world-state)
     (place-image MISSILE
                  (posn-x (first shots-fired-world-state))
                  (posn-y (first shots-fired-world-state))
                  (render-shots-fired-world-state (rest shots-fired-world-state)))]))

; ShotsFiredWorldState KeyEvent -> ShotsFiredWorldState
; on space bar, create missile and add it to world state
(check-expect (shots-fired-world-state-handle-key '() " ") (cons (make-posn BACKGROUND-MIDDLE-X BACKGROUND-HEIGHT) '()))
(check-expect (shots-fired-world-state-handle-key (cons (make-posn BACKGROUND-MIDDLE-X (/ BACKGROUND-HEIGHT 2)) '()) " ")
              (cons (make-posn BACKGROUND-MIDDLE-X BACKGROUND-HEIGHT) (cons (make-posn BACKGROUND-MIDDLE-X (/ BACKGROUND-HEIGHT 2)) '())))
(check-expect (shots-fired-world-state-handle-key '() "a") '())
(check-expect (shots-fired-world-state-handle-key '() "b") '())
(define (shots-fired-world-state-handle-key shots-fired-world-state key-event)
  (cond
    [(key=? key-event " ")
     (cons (make-posn BACKGROUND-MIDDLE-X BACKGROUND-HEIGHT) shots-fired-world-state)]
    [else
     shots-fired-world-state]))

; ShotsFiredWorldState -> ShotsFiredWorldState
(define (shots-fired-world-state-update-due-to-time shots-fired-world-state)
  (cond
    [(empty? shots-fired-world-state) '()]
    [else
     (cons (make-posn
            (posn-x (first shots-fired-world-state))
            (- (posn-y (first shots-fired-world-state))
               NUMBER-PIXELS-SHOTS-RISE-PER-CLOCK-TICK))
           (shots-fired-world-state-update-due-to-time (rest shots-fired-world-state)))]))

(define (shots-fired initial-shots-fired-world-state)
  (big-bang initial-shots-fired-world-state
    [to-draw render-shots-fired-world-state]
    [on-key shots-fired-world-state-handle-key]
    [on-tick shots-fired-world-state-update-due-to-time]))