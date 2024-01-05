;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname part_one_designing_with_itemizations_again_UFO_game_1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])

; A UFO is a Posn.
; interpretation (make-posn x y) is the UFO's location
; (using the top-down, lef-to-right convention)

(define-struct tank [loc vel])
; A Tank is a structure:
;   (make-tank Number Number)
; interpretation (make-tank x dx) specifies the position:
; (x, HEIGHT) and the tank's speed: dx pixels/tick

; A Missile is a Posn
; interpretation (make-posn x y) is the missile's place


; A SIGS is one of:
; - (make-aim UFO Tank)
; - (make-fired UFO Tank Missile)
; interpretation represents the complete state of a space invader game


(define example-sigs-tank-maneuvering-into-position-to-fire-missile
  (make-aim (make-posn 20 10) (make-tank 28 -3)))
; ^ instance of the first clause of data definition for SIGS since it is
;   an instance of (make-aim UFO Tank)

(define example-sigs-tank-fired-missile
  (make-fired (make-posn 20 10) (make-tank 28 -3) (make-posn 28 (- HEIGHT TANK-HEIGHT))))
; ^ instance of the second clause of data definition for SIGS since it is
;   an instance of (make-fired UFO Tank Missile)

(define example-sigs-tank-fired-missile-missile-close-to-ufo
  (make-fired (make-posn 20 100) (make-tank 100 3) (make-posn 22 103)))
; ^ same as above

; Exercise 95 ^
; Exercise 96 v

; To render example-sigs-tank-maneuvering-into-position-to-fire-missile:
;   (place-image UFO
;                (posn-x (aim-ufo example-sigs-tank-maneuvering-into-position-to-fire-missile))
;                (posn-y (aim-ufo example-sigs-tank-maneuvering-into-position-to-fire-missile))
;                (place-image TANK
;                             (tank-loc (aim-tank example-sigs-tank-maneuvering-into-position-to-fire-missile))
;                             (- BACKGROUND-HEIGHT GROUND-HEIGHT)
;                             BACKGROUND-WITH-GROUND-TREES-CLOUDS))

; To render example-sigs-tank-fired-missile
;   (place-image MISSILE
;                (posn-x (fired-missile example-sigs-tank-fired-missile))
;                (posn-y (fired-missile example-sigs-tank-fired-missile))
;                (place-image UFO
;                             (posn-x (aim-ufo example-sigs-tank-maneuvering-into-position-to-fire-missile))
;                             (posn-y (aim-ufo example-sigs-tank-maneuvering-into-position-to-fire-missile))
;                             (place-image TANK
;                                          (tank-loc (aim-tank example-sigs-tank-maneuvering-into-position-to-fire-missile))
;                                          (- BACKGROUND-HEIGHT GROUND-HEIGHT)
;                                          BACKGROUND-WITH-GROUND-TREES-CLOUDS)))