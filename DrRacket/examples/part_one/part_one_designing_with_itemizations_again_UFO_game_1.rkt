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


; Exercise 98
; Design the function si-game-over? for use as the stop-when handler.
; The game stops if the UFO lands or if the missile hits the UFO.
; For both conditions, we recommend that you check for proximity of one
; object to another.

; The stop-when clause allows for an optional second sub-expression,
; namely a function that renders the final state of the game.
; Design si-render-final and use it as the second part for your stop-when
; clause in the main function of exercise 100.

; SIGS -> Boolean
; si-game-over?
; - #true if UFO lands
; - #true if missile hits the UFO
; - else false
(define (si-game-over? space-invander-game-state)
  (or (si-ufo-landed? space-invander-game-state)
      (si-missile-hit-ufo? space-invander-game-state)))

; SIGS -> Boolean
; si-ufo-landed?
; - # true if UFO lands
;(define (si-ufo-landed? space-invander-game-state)
;  (cond
;    [(aimed? space-invander-game-state) _]   ; collapse these since both
;    [(fired? space-invander-game-state) _])) ;   cases have ufo and check same condition
(define (si-ufo-landed? space-invander-game-state)
  (>= (posn-y (space-invader-game-state-ufo space-invander-game-state))
      (image-height BACKGROUND)))

; SIGS -> Boolean
; si-missile-hit-ufo?
; - # true if missile hits the UFO
(define (si-missile-hit-ufo? space-invander-game-state)
  (cond
    [(aimed? space-invander-game-state) #false] ; missile can hit ufo only after fired
    [(fired? space-invander-game-state)
     (and
      (si-missile-y-overlaps-ufo-body space-invander-game-state)
      (si-missile-x-overlaps-ufo-body space-invander-game-state))]))

(define (si-missile-y-overlaps-ufo-body space-invander-game-state)
  (and
   ; missile above bottom of UFO body
   (<= (posn-y (space-invander-game-state-missile space-invander-game-state))
       (+ (posn-y (space-invander-game-state-ufo space-invander-game-state))
          (image-height UFO)))
   ; missile below top of UFO body
   (>= (posn-y (space-invander-game-state-missile space-invander-game-state))
       (- (posn-y (space-invander-game-state-ufo space-invander-game-state))
          (image-height UFO)))))

(define (si-missile-x-overlaps-ufo-body space-invander-game-state)
  (and
   ; missile to the right of the left-most extent of ufo
   (>= (posn-x (space-invander-game-state-missile space-invander-game-state))
       (- (posn-x (space-invander-game-state-ufo space-invander-game-state))
          (image-width UFO)))       
   ; missile to the left of the right-most extent of ufo
   (<= (posn-x (space-invander-game-state-missile space-invander-game-state))
       (+ (posn-x (space-invander-game-state-ufo space-invander-game-state))
          (image-width UFO)))))

; SIGS -> Image
(define (si-render-final space-invander-game-state)
  (cond
    [(si-ufo-landed? space-invander-game-state)
     (place-image (text "Aliens conquered Earth!" FINAL-TEXT-SIZE FINAL-TEXT-COLOR)
                  BACKGROUND-MIDDLE-X
                  BACKGROUND-MIDDLE-Y
                  BACKGROUND)]
    [(si-missile-hit-ufo? space-invander-game-state)
     (place-image (text "Humans repelled Aliens!" FINAL-TEXT-SIZE FINAL-TEXT-COLOR)
                  BACKGROUND-MIDDLE-X
                  BACKGROUND-MIDDLE-Y
                  BACKGROUND)]))
; ^ since everything is same except text, could put cond expression inside
; place-image expression. But, since we may want to have different text size,
; text color, background for the two cases, we keep the cond expression
; outside the place-image expression.

; Exercise 99
; Design si-move.
; This function is called for every clock tick to determine to which
; position the objects move now. Accordingly, it consumes an element
; of SIGS and produces another one.

; SIGS -> SIGS
; update position for each object
(define (si-move space-invander-game-state)
  (cond
    [(aim? space-invander-game-state)
     (make-aim-space-invander-game-state space-invander-game-state)]
    [(fired? space-invander-game-state)
     (make-fired-space-invander-game-state space-invander-game-state)]))

; SIGS -> SIGS
; given SIGS is an aim, make new SIGS with updated ufo and tank
(define (make-aim-space-invander-game-state space-invander-game-state)
  (make-aim (make-aim-space-invander-game-state-update-ufo-state space-invander-game-state)
            (make-aim-space-invander-game-state-update-tank-state space-invander-game-state)))

; SIGS -> ufo
; given that SIGS is an aim, update ufo
; ufo is posn so use make-posn rather than make-ufo
(define (make-aim-space-invander-game-state-update-ufo-state space-invander-game-state)
  (make-posn (+ (posn-x (aim-ufo space-invander-game-state))
                (* (random (/ UFO-DISK-WIDTH 4))
                   (ufo-direction-to-move 0)))
             (+ (posn-y (aim-ufo space-invander-game-state))
                UFO-SPEED))

; SIGS -> ufo
; given that SIGS is an aim, update tanks
(define (make-aim-space-invander-game-state-update-tank-state space-invander-game-state)
  (make-tank (+ (tank-loc (aim-tank space-invander-game-state))
                (tank-vel (aim-tank space-invander-game-state)))
             (tank-vel (aim-tank space-invander-game-state)))

; SIGS -> SIGS
; given that SIGS is a fired, update ufo and tank
(define (make-fired-space-invander-game-state space-invander-game-state)
  (make-fired (make-fired-space-invander-game-state-update-ufo space-invander-game-state)
              (make-fired-space-invander-game-state-update-tank space-invander-game-state)
              (make-fired-space-invander-game-state-update-missile space-invander-game-state)))

; -1 is left, 1 is right
(define (ufo-direction-to-move n)
  (if (= 1 (random 2))
      -1
      1))
    
; ufo is posn, so use make-posn rather than make-ufo
(define (make-fired-space-invander-game-state-update-ufo space-invander-game-state)
  (make-posn (+ (posn-x (fired-ufo space-invander-game-state))
                (* (random (/ UFO-DISK-WIDTH 4))
                   (ufo-direction-to-move 0)))))

(define (make-fired-space-invander-game-state-update-tank space-invander-game-state)
  (make-tank (+ (tank-loc (fired-tank space-invander-game-state))
                (tank-vel (fired-tank space-invander-game-state)))
             (tank-vel (fired-tank space-invander-game-state))))

(define (make-fired-space-invander-game-state-update-missile space-invander-game-state)
  (make-posn (posn-x (fired-missile space-invander-game-state))
             (- (posn-y (fired-missile space-invander-game-state))
                MISSILE-SPEED)))