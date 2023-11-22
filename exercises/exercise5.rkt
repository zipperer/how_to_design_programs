;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)

; plan for tree:
; - rectangle trunk and triangle above trunk
; - height of trunk greater than width of trunk
; - place trunk at middle of x axis
; - place trunk at top of y axis, i.e. the base of the scene
; - place tree above trunk at top of trunk
;
; change TREE-HEIGHT to scale picture

(define TREE-HEIGHT 100) ; this is not exactly 'height' since it is: trunk height + length of side of isoceles triangle
(define TREE-TRUNK-HEIGHT (/ TREE-HEIGHT 4))
(define TREE-TRUNK-WIDTH (/ TREE-TRUNK-HEIGHT 2))
(define TREE-TRUNK (rectangle TREE-TRUNK-WIDTH TREE-TRUNK-HEIGHT "solid" "saddle brown"))
(define TREE-ABOVE-TRUNK-SIDE-LENGTH (- TREE-HEIGHT TREE-TRUNK-HEIGHT))
(define TREE-ABOVE-TRUNK (triangle TREE-ABOVE-TRUNK-SIDE-LENGTH "solid" "forest green"))
(define EMPTY-SCENE-FOR-TREE-WIDTH (* TREE-ABOVE-TRUNK-SIDE-LENGTH 3))
(define EMPTY-SCENE-FOR-TREE-HEIGHT (* TREE-ABOVE-TRUNK-SIDE-LENGTH 3))
(define EMPTY-SCENE-FOR-TREE (empty-scene EMPTY-SCENE-FOR-TREE-WIDTH EMPTY-SCENE-FOR-TREE-HEIGHT))
(define EMPTY-SCENE-FOR-TREE-MIDDLE-ON-X-AXIS (/ EMPTY-SCENE-FOR-TREE-WIDTH 2))
(define EMPTY-SCENE-FOR-TREE-BASE-ON-Y-AXIS EMPTY-SCENE-FOR-TREE-HEIGHT)
(define TREE-TRUNK-BASE-POSITION-X-AXIS EMPTY-SCENE-FOR-TREE-MIDDLE-ON-X-AXIS)
(define TREE-TRUNK-BASE-POSITION-Y-AXIS EMPTY-SCENE-FOR-TREE-BASE-ON-Y-AXIS)
(define TREE-TRUNK-ON-EMPTY-SCENE (place-image TREE-TRUNK
                                               TREE-TRUNK-BASE-POSITION-X-AXIS
                                               TREE-TRUNK-BASE-POSITION-Y-AXIS
                                               EMPTY-SCENE-FOR-TREE
                                               ))
(define TREE-ABOVE-TRUNK-BASE-POSITION-X-AXIS TREE-TRUNK-BASE-POSITION-X-AXIS)
(define TREE-ABOVE-TRUNK-BASE-POSITION-Y-AXIS (- TREE-TRUNK-BASE-POSITION-Y-AXIS
                                                 (* TREE-TRUNK-HEIGHT 2))) ; multiplying by 2 is a hack. place-image puts image center at position, and I did not calculate the center.
(define TREE-ON-EMPTY-SCENE (place-image TREE-ABOVE-TRUNK
                                         TREE-ABOVE-TRUNK-BASE-POSITION-X-AXIS
                                         TREE-ABOVE-TRUNK-BASE-POSITION-Y-AXIS
                                         TREE-TRUNK-ON-EMPTY-SCENE))
                                         
TREE-ON-EMPTY-SCENE

; plan for boat:
; - circle with tangent at base of image
; - overlay on circle a rectangle with same color as background
; -- so, circle becomes half circle
; - put rectangle in middle of boat for mast
; - put triangle to right of mast
; - rotate triangle so flat side against mast
; e.g.
;     |\
;     |/
;  ___|___
;  \__|__/
;
; change BOAT-HULL-LENGTH to scale picture


(define BOAT-HULL-LENGTH 100)
(define BOAT-HULL-RADIUS (/ BOAT-HULL-LENGTH 2))
(define BOAT-HULL-COLOR "saddle brown")
(define BOAT-HULL-BEFORE-COVER-TOP-HALF (circle BOAT-HULL-RADIUS "solid" BOAT-HULL-COLOR))
(define EMPTY-SCENE-FOR-BOAT-HULL-WIDTH (* BOAT-HULL-RADIUS 4))
(define EMPTY-SCENE-FOR-BOAT-HULL-HEIGHT (* BOAT-HULL-RADIUS 3))
(define EMPTY-SCENE-FOR-BOAT-HULL-X-AXIS-MIDDLE (/ EMPTY-SCENE-FOR-BOAT-HULL-WIDTH 2))
(define EMPTY-SCENE-FOR-BOAT-HULL-Y-AXIS-BASE EMPTY-SCENE-FOR-BOAT-HULL-HEIGHT)
(define EMPTY-SCENE-FOR-BOAT-HULL-BACKGROUND-COLOR "blue")
(define EMPTY-SCENE-FOR-BOAT-HULL (empty-scene EMPTY-SCENE-FOR-BOAT-HULL-WIDTH
                                               EMPTY-SCENE-FOR-BOAT-HULL-HEIGHT
                                               EMPTY-SCENE-FOR-BOAT-HULL-BACKGROUND-COLOR))
(define INTENDED-DISTANCE-FROM-BOAT-HULL-CENTER-POINT-TO-BASE-OF-SCENE BOAT-HULL-RADIUS)
(define BOAT-HULL-POSITION-Y-AXIS (- EMPTY-SCENE-FOR-BOAT-HULL-Y-AXIS-BASE BOAT-HULL-RADIUS))
(define EMPTY-SCENE-WITH-BOAT-HULL (place-image BOAT-HULL-BEFORE-COVER-TOP-HALF
                                                EMPTY-SCENE-FOR-BOAT-HULL-X-AXIS-MIDDLE
                                                BOAT-HULL-POSITION-Y-AXIS
                                                EMPTY-SCENE-FOR-BOAT-HULL))
;EMPTY-SCENE-WITH-BOAT-HULL

(define RECTANGLE-TO-BLOCK-TOP-HALF-OF-HULL-COLOR "deep sky blue")
(define RECTANGLE-TO-BLOCK-TOP-HALF-OF-HULL-WIDTH EMPTY-SCENE-FOR-BOAT-HULL-WIDTH)
(define RECTANGLE-TO-BLOCK-TOP-HALF-OF-HULL-HEIGHT (- EMPTY-SCENE-FOR-BOAT-HULL-HEIGHT BOAT-HULL-RADIUS))
(define RECTANGLE-TO-BLOCK-TOP-HALF-OF-HULL-POSITION-X-AXIS (/ RECTANGLE-TO-BLOCK-TOP-HALF-OF-HULL-WIDTH 2))
(define RECTANGLE-TO-BLOCK-TOP-HALF-OF-HULL-POSITION-Y-AXIS (/ RECTANGLE-TO-BLOCK-TOP-HALF-OF-HULL-HEIGHT 2))
(define RECTANGLE-TO-BLOCK-TOP-HALF-OF-HULL (rectangle RECTANGLE-TO-BLOCK-TOP-HALF-OF-HULL-WIDTH
                                                       RECTANGLE-TO-BLOCK-TOP-HALF-OF-HULL-HEIGHT
                                                       "solid"
                                                       RECTANGLE-TO-BLOCK-TOP-HALF-OF-HULL-COLOR))
(define EMPTY-SCENE-WITH-BOAT-HULL-HALVED (place-image RECTANGLE-TO-BLOCK-TOP-HALF-OF-HULL
                                                       RECTANGLE-TO-BLOCK-TOP-HALF-OF-HULL-POSITION-X-AXIS
                                                       RECTANGLE-TO-BLOCK-TOP-HALF-OF-HULL-POSITION-Y-AXIS
                                                       EMPTY-SCENE-WITH-BOAT-HULL))

;EMPTY-SCENE-WITH-BOAT-HULL-HALVED

(define MAST-COLOR BOAT-HULL-COLOR)
(define MAST-HEIGHT BOAT-HULL-RADIUS)
(define MAST-WIDTH (/ MAST-HEIGHT 5))
(define MAST (rectangle MAST-WIDTH MAST-HEIGHT "solid" MAST-COLOR))
(define MAST-CENTER-POSITION-X-AXIS EMPTY-SCENE-FOR-BOAT-HULL-X-AXIS-MIDDLE)
(define MAST-CENTER-POSITION-Y-AXIS (- BOAT-HULL-POSITION-Y-AXIS (/ MAST-HEIGHT 2)))
(define EMPTY-SCENE-WITH-BOAT-HULL-HALVED-AND-MAST (place-image MAST
                                                                MAST-CENTER-POSITION-X-AXIS
                                                                MAST-CENTER-POSITION-Y-AXIS
                                                                EMPTY-SCENE-WITH-BOAT-HULL-HALVED))

;EMPTY-SCENE-WITH-BOAT-HULL-HALVED-AND-MAST

(define SAIL-SIDE-LENGTH MAST-HEIGHT)
(define SAIL-COLOR "red")
(define SAIL (triangle SAIL-SIDE-LENGTH "solid" SAIL-COLOR))
(define SAIL-ROTATED (rotate 30 SAIL))
(define SAIL-CENTER-POSITION-X-AXIS (+ MAST-CENTER-POSITION-X-AXIS (/ SAIL-SIDE-LENGTH 2)))
(define SAIL-CENTER-POSITION-Y-AXIS MAST-CENTER-POSITION-Y-AXIS)

(define EMPTY-SCENE-WITH-BOAT-HULL-HALVED-AND-MAST-AND-SAIL (place-image SAIL-ROTATED
                                                                         SAIL-CENTER-POSITION-X-AXIS
                                                                         SAIL-CENTER-POSITION-Y-AXIS
                                                                         EMPTY-SCENE-WITH-BOAT-HULL-HALVED-AND-MAST))

EMPTY-SCENE-WITH-BOAT-HULL-HALVED-AND-MAST-AND-SAIL
