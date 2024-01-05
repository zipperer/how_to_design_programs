;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise94) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)

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

(define BACKGROUND-WIDTH 300)
(define BACKGROUND-HEIGHT (* 3/2 BACKGROUND-WIDTH))
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
(define TANK (rectangle TANK-WIDTH TANK-HEIGHT "solid" "cornflower blue"))

(define UFO-BODY-RADIUS (/ BACKGROUND-HEIGHT 20))
(define UFO-DISK-WIDTH (/ BACKGROUND-WIDTH 4))
(define UFO-DISK-HEIGHT (/ BACKGROUND-HEIGHT 20))
(define UFO-DISK (ellipse UFO-DISK-WIDTH UFO-DISK-HEIGHT "solid" "pale turquoise"))
(define UFO-BODY (circle UFO-BODY-RADIUS "solid" "pale turquoise"))
(define UFO (overlay UFO-DISK UFO-BODY))

(define MISSILE-SIDE-LENGTH (/ BACKGROUND-HEIGHT 20))
(define MISSILE (triangle MISSILE-SIDE-LENGTH "solid" "fuchsia"))

(define PIXELS-TANK-MOVES-PER-CLOCK-TICK 1)
(define PIXELS-UFO-MOVES-DOWN-PER-CLOCK-TICK 1)
(define PIXELS-MISSILE-MOVES-UP-PER-CLOCK-TICK (* 2 PIXELS-UFO-MOVES-DOWN-PER-CLOCK-TICK))

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
BACKGROUND-WITH-GROUND-TREES-CLOUDS-TANK-AND-UFO-EXAMPLE