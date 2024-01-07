;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname part_one_designing_with_itemizations_again_UFO_game_1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

; BEGIN paste exercise94.rkt

; Exercise 94
; Draw some sketches of what the game scenery looks like at various stages.
; Use the sketches to determine the constant and the variable pieces of the game.
; For the former, develop physical and graphical constants that describe the
; dimensions of the world (canvas) and its objects.
; Also develop some background scenery.
; Finally, create your initial scene from the constants for the tank, the UFO,
; and the background.

; Constant pieces of game:
; - background
; - background scenery
; - missile dimensions and missile
; - tank dimensions and tank
; - ufo dimensions and ufo
; - speed of tank
; - speed of ufo down
; - speed of missile

; Variable pieces of game:
; - whether player has launched missile
; - x-coordinate of tank
; - y-coordinate of ufo
; - x-coordinate of ufo
; - y-coordinate of missle, once fired
; -- x-coordinate determined at firing then fixed

(define BACKGROUND-WIDTH 500);900) ; 300)
(define BACKGROUND-MIDDLE-X (/ BACKGROUND-WIDTH 2))
(define BACKGROUND-HEIGHT (* 3/2 BACKGROUND-WIDTH))
(define BACKGROUND-MIDDLE-Y (/ BACKGROUND-HEIGHT 2))
(define BACKGROUND (empty-scene BACKGROUND-WIDTH BACKGROUND-HEIGHT))
(define GROUND-HEIGHT (/ BACKGROUND-HEIGHT 10))
(define GROUND-WIDTH BACKGROUND-WIDTH)
(define GROUND (rectangle GROUND-WIDTH GROUND-HEIGHT "solid" "dark green"))
; intend to place GROUND at bottom of BACKGROUND. see uses of place-image/align
; in exercise9{2,3}.rkt
(define BACKGROUND-WITH-GROUND
  (place-image/align
   GROUND
   0
   (image-height BACKGROUND)
   "left"
   "bottom"
   BACKGROUND))

(define-struct tree [height width x-coordinate])
; A Tree is a struct:
;   (make-tree Number Number Number)
; interpretation
;   (make-tree h0 w0 x0) represents a tree with height h0, width w0, and x-coordinate
;   x0. The height and width are for the trunk. The size of the green triangle
;   on top is computed from the size of the base.
(define TREE1 (make-tree (/ BACKGROUND-HEIGHT 4)
                         (/ BACKGROUND-WIDTH 10)
                         (/ BACKGROUND-WIDTH 10)))
(define TREE2 (make-tree (/ BACKGROUND-HEIGHT 5)
                         (/ BACKGROUND-WIDTH 8)
                         (* 3/4 BACKGROUND-WIDTH)))
(define (draw-tree tree)
  (above/align
   "center"
   (draw-tree-foliage tree)
   (draw-tree-trunk tree)))

(define (draw-tree-foliage tree)
  (triangle (tree-height tree) "solid" "green"))

(define (draw-tree-trunk tree)
  (rectangle (tree-width tree) (tree-height tree) "solid" "brown"))

(define (y-coordinate-at-which-to-place-image-to-put-in-on-bottom image image-on-which-to-draw)
  (- (image-height image-on-which-to-draw)
     ;(/ (image-height image) 2) ; investigate why this does not put base of tree at base of image
     (/ (image-height image) 4))) ; stopgap

; The confusion here has to do with a difference between place-image and place-image/align

(define (draw-tree-on-image tree image-on-which-to-draw)
  (place-image/align
   (draw-tree tree)
   (tree-x-coordinate tree)
   ;(y-coordinate-at-which-to-place-image-to-put-in-on-bottom (draw-tree tree) image-on-which-to-draw)
   ;(y-coordinate-at-which-to-place-image-to-put-in-on-bottom (draw-tree-trunk tree) image-on-which-to-draw)
   (image-height image-on-which-to-draw)
   "center"
   "bottom"
   image-on-which-to-draw))

(define CLOUD1-WIDTH (/ BACKGROUND-WIDTH 5))
(define CLOUD1-HEIGHT (/ BACKGROUND-HEIGHT 10))
(define CLOUD-COLOR "Gainsboro")
;(define CLOUD (ellipse CLOUD-WIDTH CLOUD-HEIGHT "solid" "Gainsboro"))
(define-struct cloud [height width x-coordinate y-coordinate])
(define CLOUD1 (make-cloud CLOUD1-HEIGHT
                           CLOUD1-WIDTH
                           (image-width BACKGROUND)
                           0))

(define CLOUD2 (make-cloud CLOUD1-HEIGHT
                           CLOUD1-WIDTH
                           0
                           (/ BACKGROUND-HEIGHT 4)))

(define (draw-cloud cloud)
  (ellipse (cloud-width cloud) (cloud-height cloud) "solid" CLOUD-COLOR))

(define (draw-cloud-on-image cloud image-on-which-to-draw)
  (place-image/align
   (draw-cloud cloud)
   (cloud-x-coordinate cloud)
   (cloud-y-coordinate cloud)
   "right"
   "top"
   image-on-which-to-draw))

(define (draw-cloud-on-image-at-cloud-position cloud image-on-which-to-draw)
  (place-image
   (draw-cloud cloud)
   (cloud-x-coordinate cloud)
   (cloud-y-coordinate cloud)
   image-on-which-to-draw))

(define BACKGROUND-WITH-GROUND-TREES-CLOUDS
  (draw-cloud-on-image-at-cloud-position CLOUD2 (draw-cloud-on-image CLOUD1 (draw-tree-on-image TREE2 (draw-tree-on-image TREE1 BACKGROUND-WITH-GROUND)))))

(define TANK-WIDTH (/ BACKGROUND-WIDTH 10))
(define TANK-HEIGHT (* 1/2 TANK-WIDTH))
(define TANK-BODY (rectangle TANK-WIDTH TANK-HEIGHT "solid" "cornflower blue"))
(define TANK-TOP-WIDTH (/ TANK-WIDTH 2))
(define TANK-TOP-HEIGHT (/ TANK-HEIGHT 3))
(define TANK-TOP-COLOR "orchid")
(define TANK-TOP (rectangle TANK-TOP-WIDTH TANK-TOP-HEIGHT "solid" TANK-TOP-COLOR))
(define TANK-CANNON-COLOR "dim gray")
(define TANK-CANNON-HEIGHT (* 2 TANK-TOP-HEIGHT))
(define TANK-CANNON-WIDTH (/ TANK-CANNON-HEIGHT 5))
(define TANK-CANNON (rectangle TANK-CANNON-WIDTH TANK-CANNON-HEIGHT "solid" TANK-CANNON-COLOR))
(define TANK (above/align "middle" TANK-CANNON TANK-TOP TANK-BODY))

(define UFO-BODY-RADIUS (/ BACKGROUND-HEIGHT 20))
(define UFO-DISK-WIDTH (/ BACKGROUND-WIDTH 4))
(define UFO-DISK-HEIGHT (/ BACKGROUND-HEIGHT 20))
(define UFO-DISK (ellipse UFO-DISK-WIDTH UFO-DISK-HEIGHT "solid" "pale turquoise"))
(define UFO-BODY (circle UFO-BODY-RADIUS "solid" "pale turquoise"))
(define UFO (overlay UFO-DISK UFO-BODY))

(define MISSILE-SIDE-LENGTH (/ BACKGROUND-HEIGHT 20))
(define MISSILE (triangle MISSILE-SIDE-LENGTH "solid" "fuchsia"))

(define PIXELS-TANK-MOVES-PER-CLOCK-TICK 3)
(define PIXELS-UFO-MOVES-DOWN-PER-CLOCK-TICK 1)
(define PIXELS-MISSILE-MOVES-UP-PER-CLOCK-TICK (* 4 PIXELS-UFO-MOVES-DOWN-PER-CLOCK-TICK))

(define BACKGROUND-WITH-GROUND-TREES-CLOUDS-TANK-AND-UFO-EXAMPLE
  (place-image
   UFO
   (/ BACKGROUND-WIDTH 2)
   (* 1/4 BACKGROUND-HEIGHT)
   (place-image
    TANK
    (/ BACKGROUND-WIDTH 3)
    (- BACKGROUND-HEIGHT GROUND-HEIGHT)
    BACKGROUND-WITH-GROUND-TREES-CLOUDS)))
; BACKGROUND-WITH-GROUND-TREES-CLOUDS-TANK-AND-UFO-EXAMPLE

; END paste exercise94.rkt

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
  (make-fired (make-posn 20 10) (make-tank 28 -3) (make-posn 28 (- BACKGROUND-HEIGHT TANK-HEIGHT))))
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
                  (ufo-render (aim-ufo s) BACKGROUND-WITH-GROUND-TREES-CLOUDS))] ; BACKGROUND
    [(fired? s)
     (tank-render
      (fired-tank s)
      (ufo-render (fired-ufo s)
                  (missile-render (fired-missile s)
                                  BACKGROUND-WITH-GROUND-TREES-CLOUDS)))]))

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
               (tank-loc t)
               (- (image-height BACKGROUND-WITH-GROUND-TREES-CLOUDS)
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
(define (si-ufo-landed? space-invander-game-state)
  (cond
    [(aim? space-invander-game-state)
     (>= (posn-y (aim-ufo space-invander-game-state))
         (image-height BACKGROUND))]
    [(fired? space-invander-game-state)
     (>= (posn-y (fired-ufo space-invander-game-state))
         (image-height BACKGROUND))])) 

; SIGS -> Boolean
; si-missile-hit-ufo?
; - # true if missile hits the UFO
(define (si-missile-hit-ufo? space-invander-game-state)
  (cond
    [(aim? space-invander-game-state) #false] ; missile can hit ufo only after fired
    [(fired? space-invander-game-state)
     (and
      (si-missile-y-overlaps-ufo-body space-invander-game-state)
      (si-missile-x-overlaps-ufo-body space-invander-game-state))]))

(define (si-missile-y-overlaps-ufo-body space-invander-game-state)
  (and
   ; missile above bottom of UFO body
   (<= (posn-y (fired-missile space-invander-game-state))
       (+ (posn-y (fired-ufo space-invander-game-state))
          (/ (image-height UFO) 2)))
   ; missile below top of UFO body
   (>= (posn-y (fired-missile space-invander-game-state))
       (- (posn-y (fired-ufo space-invander-game-state))
          (/ (image-height UFO) 2)))))

(define (si-missile-x-overlaps-ufo-body space-invander-game-state)
  (and
   ; missile to the right of the left-most extent of ufo
   (>= (posn-x (fired-missile space-invander-game-state))
       (- (posn-x (fired-ufo space-invander-game-state))
          (/ (image-width UFO) 4)))
   ; missile to the left of the right-most extent of ufo
   (<= (posn-x (fired-missile space-invander-game-state))
       (+ (posn-x (fired-ufo space-invander-game-state))
          (/ (image-width UFO) 4)))))

(define FINAL-TEXT-SIZE 30)
(define FINAL-TEXT-COLOR "red")

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

; currently nothing prevents {UFO|tank} from going off-screen

; SIGS -> SIGS
; given SIGS is an aim, make new SIGS with updated ufo and tank
(define (make-aim-space-invander-game-state space-invander-game-state)
  (make-aim (make-aim-space-invander-game-state-update-ufo-state space-invander-game-state)
            (make-aim-space-invander-game-state-update-tank-state space-invander-game-state)))

(define DISTANCE-UFO-CAN-JUMP-HORIZONTALLY (floor (/ UFO-DISK-WIDTH 4))) ; 8

; SIGS -> ufo
; given that SIGS is an aim, update ufo
; ufo is posn so use make-posn rather than make-ufo
(define (make-aim-space-invander-game-state-update-ufo-state space-invander-game-state)
  (make-posn (+ (posn-x (aim-ufo space-invander-game-state))
                (* (random DISTANCE-UFO-CAN-JUMP-HORIZONTALLY)
                   (ufo-direction-to-move 0)))
             (+ (posn-y (aim-ufo space-invander-game-state))
                PIXELS-UFO-MOVES-DOWN-PER-CLOCK-TICK)))

; SIGS -> ufo
; given that SIGS is an aim, update tanks
(define (make-aim-space-invander-game-state-update-tank-state space-invander-game-state)
  (make-tank (+ (tank-loc (aim-tank space-invander-game-state))
                (tank-vel (aim-tank space-invander-game-state)))
             (tank-vel (aim-tank space-invander-game-state))))

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
                (* (random DISTANCE-UFO-CAN-JUMP-HORIZONTALLY)
                   (ufo-direction-to-move 0)))
             (+ (posn-y (fired-ufo space-invander-game-state))
                PIXELS-UFO-MOVES-DOWN-PER-CLOCK-TICK)))

(define (make-fired-space-invander-game-state-update-tank space-invander-game-state)
  (make-tank (+ (tank-loc (fired-tank space-invander-game-state))
                (tank-vel (fired-tank space-invander-game-state)))
             (tank-vel (fired-tank space-invander-game-state))))

(define (make-fired-space-invander-game-state-update-missile space-invander-game-state)
  (make-posn (posn-x (fired-missile space-invander-game-state))
             (- (posn-y (fired-missile space-invander-game-state))
                PIXELS-MISSILE-MOVES-UP-PER-CLOCK-TICK)))

(define INITIAL-SPACE-INVADER-GAME-STATE
  (make-aim (make-posn BACKGROUND-MIDDLE-X
                       0)
            (make-tank 0
                       PIXELS-TANK-MOVES-PER-CLOCK-TICK)))

; Exercise 100
; Design the function si-control, which plays the role of the key-event handler.
; As such, it consumes a game state and a KeyEvent and produces a new game state.
; It reacts to three different keys:
; - pressing the left arrow ensures that the tank moves left;
; - pressing the right arrow ensures that the tank moves right; and
; - pressing the space bar fires the missile if it hasn’t been launched yet.

; Once you have this function, you can define the si-main function,
; which uses big-bang to spawn the game-playing window. Enjoy!

; SIGS KeyEvent -> SIGS
(define (si-control space-invader-game-state key-event)
  (cond
    [(or (string=? key-event "left")
         (string=? key-event "right"))
     (make-space-invader-game-state-respond-to-arrow-key space-invader-game-state key-event)]
    [(string=? key-event " ")
     (make-space-invader-game-state-possibly-update-missile space-invader-game-state)]
    [else space-invader-game-state]))

; SIGS KeyEvent ("left" or "right") -> SIGS
(define (make-space-invader-game-state-respond-to-arrow-key space-invader-game-state key-event)
  (cond
    [(aim? space-invader-game-state)
     (make-aim (aim-ufo space-invader-game-state)
               (make-tank (tank-loc (aim-tank space-invader-game-state))
                          (update-tank-velocity-given-key-event (tank-vel (aim-tank space-invader-game-state)) key-event)))]
    [(fired? space-invader-game-state)
     (make-fired
      (fired-ufo space-invader-game-state)
      (make-tank (tank-loc (fired-tank space-invader-game-state))
                 (update-tank-velocity-given-key-event (tank-vel (fired-tank space-invader-game-state)) key-event))
      (fired-missile space-invader-game-state))]))

; Number KeyEvent ("left" or "right") -> Number
(define (update-tank-velocity-given-key-event tank-velocity key-event)
  (cond
    [(string=? "left" key-event)
     (cond
       [(> tank-velocity 0)
        (- tank-velocity)]
       [else tank-velocity])]
    [(string=? "right" key-event)
     (cond
       [(< tank-velocity 0)
        (- tank-velocity)]
       [else tank-velocity])]))

; SIGS -> SIGS
; space-invader-game-state starts as an aim and create fired
(define (make-space-invader-game-state-possibly-update-missile space-invader-game-state)
  (cond
    [(fired? space-invader-game-state)
     space-invader-game-state]
    [(aim? space-invader-game-state)
     (make-fired
      (aim-ufo space-invader-game-state)
      (aim-tank space-invader-game-state)
      (make-posn (tank-loc (aim-tank space-invader-game-state))
                 (- BACKGROUND-HEIGHT GROUND-HEIGHT TANK-HEIGHT)))]))
  

(define (main initial-space-invader-game-state)
  (big-bang initial-space-invader-game-state
    [to-draw si-render]
    [stop-when si-game-over? si-render-final]
    [on-tick si-move]
    [on-key si-control]))


; (main INITIAL-SPACE-INVADER-GAME-STATE)