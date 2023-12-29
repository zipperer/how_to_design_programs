;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname part_one_programming_with_structures_1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

; Sample Problem
; Your team is designing an interactive game program
; that moves a red dot across a 100 x 100 canvas and allows
; players to use the mouse to reset the dot.

; world program -- big-bang expression
; canvas with dimensions -- (empty-scene 100 100)
; image on canvas -- (circle CIRCLE-RADIUS "solid" "red")
;                 -- draw dot at location
;                 -- (place-image IMAGE X Y SCENE)
; key handler - respond to "left" "right" "up" "down"
; click handler - reset dot -- draw dot at default location

; draft 1

; A WorldState is a Posn
;   (make-posn X Y)
; describes a dot X pixels from left margin
;                 Y pixels from top margin

; wish-list:


; BACKGROUND
(define BACKGROUND-WIDTH 100)
(define BACKGROUND-HEIGHT BACKGROUND-WIDTH)
(define BACKGROUND-MIDDLE-X (/ BACKGROUND-WIDTH 2))
(define BACKGROUND-MIDDLE-Y (/ BACKGROUND-HEIGHT 2))
(define BACKGROUND (empty-scene BACKGROUND-WIDTH BACKGROUND-HEIGHT))


; DOT
(define DOT-RADIUS (/ BACKGROUND-WIDTH 20))
(define DOT-BORDER "solid")
(define DOT-COLOR "red")
(define DOT (circle DOT-RADIUS DOT-BORDER DOT-COLOR))

; DOT DEFAULT LOCATION
(define DOT-DEFAULT-LOCATION (make-posn BACKGROUND-MIDDLE-X
                                        BACKGROUND-MIDDLE-Y))
(define WORLD-STATE-INITIAL DOT-DEFAULT-LOCATION)

; draw-dot
; WorldState -> Image
; draws dot on canvas at position given by world-state
(check-expect (draw-dot (make-posn 20 30)) (place-image DOT 20 30 BACKGROUND))
(check-expect (draw-dot (make-posn 40 20)) (place-image DOT 40 20 BACKGROUND))
(define (draw-dot world-state)
  (place-image DOT
               (posn-x world-state)
               (posn-y world-state)
               BACKGROUND))

; KeyEvent is one of
; - 1String
; - ArrowKey
; This is not complete, see https://docs.racket-lang.org/teachpack/2htdpuniverse.html#%28tech._world._keyevent%29

; ArrowKey is one of
; - "left"
; - "right"
; - "up"
; - "down"

(define (1string? key-event)
  (cond
    [(= (string-length key-event) 1) #true]
    [else #false]))

(define (arrow-key? key-event)
  (or (string=? "left" key-event)
      (string=? "right" key-event)
      (string=? "up" key-event)
      (string=? "down" key-event)))

; key-handler
; WorldState KeyEvent -> WorldState
; responds to KeyEvent and possibly updates WorldState
; responds to "left" "right" "up" "down" by moving dot
(check-expect (move-dot (make-posn 20 30) "left") (make-posn 19 30))
(check-expect (move-dot (make-posn 20 30) "right") (make-posn 21 30))
(check-expect (move-dot (make-posn 20 30) "up") (make-posn 20 29))
(check-expect (move-dot (make-posn 20 30) "down") (make-posn 20 31))
(check-expect (move-dot (make-posn 20 30) "a") (make-posn 20 30))
(define (move-dot world-state key-event)
  (cond
    [(1string? key-event) world-state]
    [(arrow-key? key-event) (move-dot-given-arrow-key world-state key-event)]))

(define (move-dot-given-arrow-key world-state key-event)
  (cond
    [(string=? "left" key-event) (make-posn
                                  (- (posn-x world-state) 1)
                                  (posn-y world-state))]
    [(string=? "right" key-event) (make-posn
                                   (+ (posn-x world-state) 1)
                                   (posn-y world-state))]
    [(string=? "up" key-event) (make-posn
                                (posn-x world-state)
                                (- (posn-y world-state) 1))]
    [(string=? "down" key-event) (make-posn
                                  (posn-x world-state)
                                  (+ (posn-y world-state) 1))]))


; mouse-handler
; WorldState MouseCoordinateX MouseCoordinateY MouseEvent -> WorldState
(check-expect (mouse-handler (make-posn 20 30) 10 10 "button-up") WORLD-STATE-INITIAL)
(check-expect (mouse-handler (make-posn 30 20) 10 10 "button-up") WORLD-STATE-INITIAL)
(check-expect (mouse-handler (make-posn 20 30) 10 10 "enter") (make-posn 20 30))
(check-expect (mouse-handler (make-posn 30 20) 10 10 "enter") (make-posn 30 20))
(define (mouse-handler world-state mouse-coordinate-x mouse-coordinate-y mouse-event)
  (cond
    [(string=? "button-up" mouse-event) WORLD-STATE-INITIAL]
    [else world-state]))

(check-expect (mouse-handler-set-to-mouse-position-on-click (make-posn 10 20)
                                                            30
                                                            40
                                                            "button-up")
              (make-posn 30 40))
(check-expect (mouse-handler-set-to-mouse-position-on-click (make-posn 30 40)
                                                            10
                                                            20
                                                            "button-up")
              (make-posn 10 20))

(check-expect (mouse-handler-set-to-mouse-position-on-click (make-posn 30 40)
                                                            10
                                                            20
                                                            "enter")
              (make-posn 30 40))

(define (mouse-handler-set-to-mouse-position-on-click world-state
                                                      mouse-coordinate-x
                                                      mouse-coordinate-y
                                                      mouse-event)
  (cond
    [(string=? "button-up" mouse-event) (make-posn mouse-coordinate-x
                                                   mouse-coordinate-y)]
    [else world-state]))

(define (main placeholder)
  (big-bang WORLD-STATE-INITIAL
    [on-key move-dot]
    [to-draw draw-dot]
    [on-mouse mouse-handler-set-to-mouse-position-on-click] ; mouse-handler]
    ))

(main WORLD-STATE-INITIAL)