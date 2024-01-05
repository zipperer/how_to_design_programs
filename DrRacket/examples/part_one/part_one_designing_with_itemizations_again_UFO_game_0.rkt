;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname part_one_designing_with_itemizations_again_UFO_game_0) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

; Sample Problem
; Design a game program using the 2htdp/universe teachpack for playing a
; simple space invader game. The player is in control of a tank
; (a small rectangle) that must defend our planet (the bottom of the canvas)
; from a UFO (see Intervals for one possibility) that descends from the top
; of the canvas to the bottom. In order to stop the UFO from landing,
; the player may fire a single missile (a triangle smaller than the tank) by
; hitting the space bar. In response, the missile emerges from the tank. If
; the UFO collides with the missile, the player wins; otherwise the UFO lands
; and the player loses.

; background dimensions
; background object
; backgound decorations:
;  - raised ground
;  - trees
; tank dimensions
; tank object
; missile dimensions
; missile object
; missile reference box
; ufo dimensions
; ufo object
; ufo reference box

; state object:
; missile-info
; tank-info
; ufo-info

; key events:
; - spacebar to fire missile
; - left and right arrow keys to change direction of tank

; tank should stop at margins
; UFO should stop at ground
; stop-when UFO reaches ground or missile reaches UFO

; tank moves at constant speed
; UFO descends at constant velocity
; UFO makes random jumps left and right
; missle ascends at constant speed >= (* 2 UFO-SPEED)
; 

; A PosnOrFalse is one of:
; - Posn
; - #false

; A Missile is PosnOrFalse
; - (make-posn x0 y0) represents a missile in flight at coordinates x0 and y0
; - #false represents a missle not yet launched
; For example
(define MISSILE-NOT-YET-FIRED #false)
(define MISSILE-AT-10-20 (make-posn 10 20))

; Alternatively, a Missle could be a structure:
; (define-struct missile [launched? PosnOrFalse]
; but this duplicates the info of launched? or not

; A Missile reference box is computed with:
; the posn is the center point
; the length extends from center point to a distance (* 1/2 MISSILE-HEIGHT) up and down
; the width extends from center point to a distance (* 1/2 MISSILE-WIDTH) left and right
; For example
; (define MISSILE-AT-10-20-REFERENCE-BOX
;   (rectangle MISSILE

; Need to determine whether two reference boxes overlap
; images-with-positions-overlap? image position image position
;   reference-boxes-overlap? reference-box reference-box
;     ideas: overlap when some coordinate is within both

; A reference box for a rectangle could be a struct with four posns:
; top-left-corner: posn
; top-right-corner: posn
; bottom-left-corner: posn
; bottom-right-corner: posn

; A rectangle overlaps another rectangle when:
; - order the rectangles LEFT and RIGHT and
; -- rightmost extent of LEFT >= leftmost extent of RIGHT
; - order the rectangles UP and DOWN and
; -- downmost extent of UP <= upmost extent of DOWN

; the rightmost exent is:
; go through the posns for each corner and find the one with the smallest x coordinate

; the upmost extent is:
; go through the posns for each corner and find the one with the biggest y coordinate

; a rectangle LEFT is to the left of another rectangle RIGHT when
; the leftmost extent of LEFT is <= the leftmost extent of RIGHT

; given these definition, an OUTER box that contains an INNER box is s.t.
; OUTER box is left of INNER box
; OUTER box is right of INNER box
; OUTER box is up of INNER box
; OUTER box is down of INNER box
; this is counterintuitive; for, I started out thinking one box is either
; left of another or right of another and not both.

; A Tank is a struct
; - (make-tank x0 d0) represents a tank at position x0 traveling in direction d0

; A UFO is a struct
; - (make-ufo x0 y0) represents a UFO a ufo at x-coordinate x0 and y-coordinate y0
;   traveling toward bottom of canvas

; A UFOGameWorldState is a structure:
;   (make-ufo-game-world-state Tank UFO Missile)
; interpretation:
;   (make-ufo-game-world-state t0 u0 m0) represents a tank with structure t0
;     a ufo with structure u0 and a missile with structure m0, i.e.
;   (make-ufo-game-world-state (make-tank x0 d0)
;                              (make-ufo x0 y0)
;                              (make-posn x1 y1))
;     represents (a) a tank at x-coordinate x0 travelling in direction d0,
;     (b) a ufo (make-ufo x0 y0) traveling toward bottom of canvas currently at
;     x position x0 and y position y0, and (c) a missile that has been fired and
;     has position (make-posn x1 y1).

