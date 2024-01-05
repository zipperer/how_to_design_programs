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

; SIGS -> Image
; adds Tank, UFO, and possibly MISSILE to
; the BACKGROUND scene
;(define (si-render s) BACKGROUND)
;(define (si-render s)
;  (cond
;    [(aim? s) (... (aim-tank s) ... (aim-ufo s) ...)]
;    [(fired? s) (... (fired-tank s) ... (fired-ufo s) ... (fired-missile s) ...)]))

; ... (tank-render (aim-tank s)
;                  (ufo-render (aim-ufo s) BACKGROUND))

; Tank Image -> Image
; adds t to the given image im
; (define (tank-render t im) im)

; UFO Image -> Image
; adds u to the given image im
; (define (ufo-render u im) im)

; SIGS -> Image
; renders the given game state on top of BACKGROUND
; for examples see figure 32
(define (si-render s)
  (cond
    [(aim? s)
     (tank-render (aim-tank s)
                  (ufo-render (aim-ufo s) BACKGROUND))]
    [(fired? s)
     (tank-render
      (fired-tank s)
      (ufo-render (fired-ufo s)
                  (missile-render (fired-missile s)
                                  BACKGROUND)))]))

; Missile Image -> Image
; adds m to the given image im
;(define (missile-render m im) im)

; Exercise 97
;Compare this expression:
;(tank-render
;  (fired-tank s)
;  (ufo-render (fired-ufo s)
;              (missile-render (fired-missile s)
;                              BACKGROUND)))
;with this one:
;(ufo-render
;  (fired-ufo s)
;  (tank-render (fired-tank s)
;               (missile-render (fired-missile s)
;                               BACKGROUND)))
;When do the two expressions produce the same result? 

; The two expressions produce the same result when there is no overlap between
; the reference boxes for the ufo and the tank.
; The version that applies the tank to the scene last, i.e.
; (tank-render (fired-tank s) (ufo-render ...))
; will put the tank on top of any other object with which its reference box overlaps.
; The version that applies the ufo to the scene last, i.e.
; (ufo-render (fired-ufo s) (tank-render ...))
; will put the ufo on top of any other object with which its reference box overlaps.
; So, if in s the reference box of tank overlaps with the reference box of ufo, then
; with the (tank-render ...) version, the tank will be fully shown and the ufo will
; be partially blocked, and with the (ufo-render ...) version, the ufo will be
; fully shown and the tank will be partially blocked.

; Exercise 97
; Design the functions tank-render, ufo-render, and missile-render.

; Tank Image -> Image
; adds t to the given image im
;(check-expect (tank-render (make-tank 0 3) (empty-scene 100 100))
;              (place-image TANK
;                           0
;                           (- (image-height (empty-scene 100 100))
;                              (image-height TANK))
;                           (empty-scene 100 100)))                          
(define (tank-render t im)
  (place-image TANK
               (tank-loc tank)
               (- (image-height (empty-scene 100 100))
                  (image-height TANK))
               im))

; UFO Image -> Image
; adds u to the given image im
(define (ufo-render u im)
  (place-image UFO
               (posn-x u)
               (posn-y u)
               im))

; Missile Image -> Image
; adds m to the given image im
(define (missile-render m im)
  (place-image MISSILE
               (posn-x m)
               (posn-y m)
               im))

; Alternatively,
; (define (place-image-at-posn-on-image image-to-place posn image-backgroun)
;   (place-image image-to-place
;                (posn-x posn)
;                (posn-y posn)
;                image-background))

; (define (missile-render m im)
;   (place-image-at-posn-on-image MISSILE m im))

; (define (ufo-render u im)
;   (place-image-at-posn-on-image UFO u im))