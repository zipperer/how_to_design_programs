;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname part_one_structure_in_the_world_0) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; Consider a space invader game that consists of a UFO and a tank.
; The UFO descends along a straight vertical line and
; a tank moves horizontally at the bottom of a scene.
; If both objects move at known constant speeds, all that’s needed to describe
; these two objects is one piece of information per object:
; the y-coordinate for the UFO and
; the x-coordinate for the tank.
; Putting those together requires a structure with two fields:

(define-struct space-game [ufo tank])

; Formulate an adequate data definition for this structure type definition, including an interpretation.

; AZ: I first redefine the structure to extend the names
(define-struct space-game-world-state [ufo-y-coordinate tank-x-coordinate])
; A SpaceGameWorldState is a structure:
;   (make-space-game-world-state Number Number)
; interpretation:
;   (make-space-game-world-state ufo-y-coordinate-y0 tank-x-coordinate-x0)
;   represents a world state with
;   - ufo at y coordinate y0 and
;   - tank at x coordinate x0.
;   e.g.
;   (make-space-game-world-state 0 0) represents a world state with
;   - ufo at y coordinate 0, i.e. top of canvas -- 0 pixels from top margin.
;   - tank at x coordinate 0, i.e. left of canvas -- 0 pixels from left margin.
;   (make-space-game-world-state CANVAS-HEIGHT CANVAS-WIDTH) represnts a world state with
;   - ufo at y coordinate CANVAS-HEIGHT, i.e. bottom of canvas -- CANVAS-HEIGHT pixels from top margin
;   - tank at x coordinate CANVAS-WIDTH, i.e. right of canvas -- CANVAS-WIDTH pixels from left margin
;   (make-space-game-world-state 20 30) represnts a world state with
;   - ufo at y coordinate 20, i.e. bottom of canvas -- 20 pixels from top margin
;   - tank at x coordinate 30, i.e. right of canvas -- 30 pixels from left margin

; The selector names for the fields in the structure type are:
; space-game-world-state-ufo-y-coordinate
; space-game-world-state-tank-x-coordinate

; The predicate for this structure type is:
; space-game-world-state?


;   Aside: we could restrict the values of ufo-y-coordinate and tank-x-coordinate to fixed
;   intervals.


(define-struct space-game-with-non-vertical-ufo-world-state [ufo-posn tank-x-coordinate])
; A SpaceGameWithNonVerticalUfoWorldState is a structure:
;   (make-space-game-with-non-vertical-ufo-world-state Posn Number). 
; interpretation (make-space-game-with-non-vertical-ufo-world-state (make-posn ux uy) tx)
; describes a configuration where the UFO is 
; at (ux,uy) and the tank's x-coordinate is tx


(require 2htdp/image)
(require 2htdp/universe)

(define INITIAL-WORLD-STATE (make-space-game-world-state 0 0))

(define BACKGROUND-WIDTH 200)
(define BACKGROUND-HEIGHT BACKGROUND-WIDTH)
(define BACKGROUND (empty-scene BACKGROUND-WIDTH BACKGROUND-HEIGHT))
(define GROUND-COLOR "dark brown")
(define GROUND-WIDTH BACKGROUND-WIDTH)
(define GROUND-HEIGHT (/ BACKGROUND-HEIGHT 10))
(define GROUND (rectangle GROUND-WIDTH GROUND-HEIGHT "solid" GROUND-COLOR))
(define GROUND-X-POSITION (+ 0 (/ GROUND-WIDTH 2)))
(define GROUND-Y-POSITION (+ 0 (- BACKGROUND-HEIGHT (/ GROUND-HEIGHT 2))))
(define BACKGROUND-WITH-GROUND (place-image GROUND GROUND-X-POSITION GROUND-Y-POSITION BACKGROUND))

(define UFO-BODY-WIDTH (/ BACKGROUND-WIDTH 10))
(define UFO-BODY-HEIGHT (/ BACKGROUND-HEIGHT 10))
(define UFO-SPHERE-RADIUS (/ UFO-BODY-HEIGHT 2))
(define UFO-SPHERE (circle UFO-SPHERE-RADIUS "solid" "gray"))
(define UFO-DISK-WIDTH (* 5 UFO-BODY-WIDTH))
(define UFO-DISK (ellipse UFO-DISK-WIDTH UFO-SPHERE-RADIUS "solid" "gray"))
(define UFO (overlay UFO-SPHERE UFO-DISK))
(define UFO-X-POSITION (/ BACKGROUND-WIDTH 2))
(define UFO-SPEED-Y-DIMENSION 3)

(define TANK-BODY-WIDTH (/ BACKGROUND-WIDTH 10))
(define TANK-BODY-HEIGHT (/ BACKGROUND-HEIGHT 15))
(define TANK-BASE (rectangle TANK-BODY-WIDTH TANK-BODY-HEIGHT "solid" " dark green"))
(define TANK-TOP-WIDTH (/ TANK-BODY-WIDTH 2))
(define TANK-TOP-HEIGHT (/ TANK-BODY-HEIGHT 2))
(define TANK-TOP (rectangle TANK-TOP-WIDTH TANK-TOP-HEIGHT "solid" "dark green"))
(define TANK (above TANK-TOP TANK-BASE))
(define TANK-Y-POSITION (- GROUND-Y-POSITION TANK-BODY-HEIGHT TANK-TOP-HEIGHT))
(define TANK-SPEED-X-DIMENSION 2)

;(define 

; SpaceGameWorldState -> Image
; places UFO image and TANK image on background
(check-expect (render-space-game (make-space-game-world-state 0 0))
              (place-image TANK 0 TANK-Y-POSITION
                           (place-image UFO UFO-X-POSITION 0 BACKGROUND-WITH-GROUND)))
(define (render-space-game space-game-world-state)
  (place-image TANK
               (space-game-world-state-tank-x-coordinate space-game-world-state)
               TANK-Y-POSITION
               (place-image UFO
                            UFO-X-POSITION
                            (space-game-world-state-ufo-y-coordinate space-game-world-state)
                            BACKGROUND-WITH-GROUND)))

; SpaceGameWorldState KeyEvent -> SpaceGameWorldState
; update position of TANK given key presses
(check-expect (move-tank (make-space-game-world-state 0 0) "left")
              (make-space-game-world-state 0 (- TANK-SPEED-X-DIMENSION)))
(check-expect (move-tank (make-space-game-world-state 0 0) "right")
              (make-space-game-world-state 0 TANK-SPEED-X-DIMENSION))
(check-expect (move-tank (make-space-game-world-state 0 0) "a")
              (make-space-game-world-state 0 0))
(define (move-tank space-game-world-state key-event)
  (make-space-game-world-state
   (space-game-world-state-ufo-y-coordinate space-game-world-state)
  (cond
    [(string=? "left" key-event)
     (- (space-game-world-state-tank-x-coordinate space-game-world-state) TANK-SPEED-X-DIMENSION)]
    [(string=? "right" key-event)
     (+ (space-game-world-state-tank-x-coordinate space-game-world-state) TANK-SPEED-X-DIMENSION)]
    [else (space-game-world-state-tank-x-coordinate space-game-world-state)])))
     

; SpaceGameWorldState -> SpaceGameWorldState
; update positions of UFO and TANK given an increment of time and their given speeds
(check-expect (update-positions-due-to-time (make-space-game-world-state 0 0))
              (make-space-game-world-state (+ 0 UFO-SPEED-Y-DIMENSION)
                                           (+ 0 TANK-SPEED-X-DIMENSION)))
(define (update-positions-due-to-time space-game-world-state)
  (make-space-game-world-state
   (+ (space-game-world-state-ufo-y-coordinate space-game-world-state) UFO-SPEED-Y-DIMENSION)
   (+ (space-game-world-state-tank-x-coordinate space-game-world-state) TANK-SPEED-X-DIMENSION)))


(define CLOCK-TICKS-EVERY-N-SECONDS (/ 1 2)) ; (/ 1 10) for mode where hard to avoid UFO

(define (space-game-main initial-world-state)
  (big-bang initial-world-state
    [to-draw render-space-game]
    [on-tick update-positions-due-to-time CLOCK-TICKS-EVERY-N-SECONDS]
    [on-key move-tank]))

(space-game-main (make-space-game-world-state 0 0))