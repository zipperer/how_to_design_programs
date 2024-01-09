;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise113) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image) ; image-color?

; Exercise 113
; Design predicates for the following data definitions from the preceding section:
; - SIGS
; - Coordinate (exercise 105), and
; - VAnimal.

(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])

; A UFO is a Posn. 
; interpretation (make-posn x y) is the UFO's location 
; (using the top-down, left-to-right convention)
 
(define-struct tank [loc vel])
; A Tank is a structure:
;   (make-tank Number Number). 
; interpretation (make-tank x dx) specifies the position:
; (x, HEIGHT) and the tank's speed: dx pixels/tick 
 
; A Missile is a Posn. 
; interpretation (make-posn x y) is the missile's place

(define (ufo? value)
  (posn? value))

(define (make-ufo x-coordinate y-coordinate)
  (make-posn x-coordinate y-coordinate))

(define (missile? value)
  (posn? value))

(define (make-missile x-coordinate y-coordinate)
  (make-posn x-coordinate y-coordinate))

; A SIGS is one of: 
; – (make-aim UFO Tank)
; – (make-fired UFO Tank Missile)
; interpretation represents the complete state of a 
; space invader game

(check-expect (sigs? (make-aim (make-ufo 1 2) (make-tank 0 3))) #true)
(check-expect (sigs? (make-aim (make-ufo 1 2) (make-tank 0 -3))) #true)
(check-expect (sigs? (make-fired (make-ufo 1 2) (make-tank 0 3) (make-missile 2 10))) #true)
(check-expect (sigs? #false) #false)
; in next check-expect, tank and ufo arguments are in incorrect positions
(check-expect (sigs? (make-fired (make-tank 0 3) (make-ufo 1 2) (make-missile 2 10))) #false)
(define (sigs? value)
  (or (and (aim? value)
           (ufo? (aim-ufo value))
           (tank? (aim-tank value)))
      (and (fired? value)
           (ufo? (fired-ufo value))
           (tank? (fired-tank value))
           (posn? (fired-missile value)))))

; A Coordinate is one of: 
; – a NegativeNumber 
; interpretation on the y axis, distance from top
; – a PositiveNumber 
; interpretation on the x axis, distance from left
; – a Posn
; interpretation an ordinary Cartesian point
(check-expect (coordinate? 1) #true)
(check-expect (coordinate? -1) #true)
(check-expect (coordinate? (make-posn 1 -1)) #true)
(check-expect (coordinate? "a") #false)
(check-expect (coordinate? #true) #false)
(define (coordinate? value)
  (or (negative-number? value)
      (positive-number? value)
      (posn? value)))

(define (negative-number? value)
  (and (number? value)
           (< value 0)))

(define (positive-number? value)
  (and (number? value)
           (<= 0 value)))

(define-struct cat-position-and-happiness [x-coordinate happiness direction])
; A VCat is a structure:
;   (make-cat-position-and-happiness Number Number String)
; interpretation
;   (make-cat-position-and-happiness x0 h0 d0) represents a cat at
;   - x-coordinate x0 with
;   - happiness h0
;   - direction d0
; h0 is in interval [0, 100]
; d0 is one of 'right', 'left'

(define-struct virtual-chameleon-world-state [x-position
                                              happiness
                                              background-color])
; A VCham is a structure:
;   (make-virtual-chameleon-world-state Number Number Color)
; interpretation:
;   (make-virtual-chameleon-world-state x0 h0 c0) represents
;   a world state with a chameleon at x-position x0 with happiness h0
;   where the background-color is c0.
;   x0 is in interval [0, BACKGROUND_WIDTH]
;   h0 is in interval [0, 100]

; A VAnimal is either
; – a VCat
; – a VCham
(define (vanimal? value)
  (or (vcat? value)
      (vcham? value)))

(check-expect (vcat? (make-cat-position-and-happiness 0 100 "right")) #true)
; 200 exceeds interval for happiness-number?
(check-expect (vcat? (make-cat-position-and-happiness 0 200 "right")) #false)
; "blue" is not one of the directions ("left" or "right")
(check-expect (vcat? (make-cat-position-and-happiness 0 100 "blue")) #false)
(check-expect (vcat? #true) #false)
(define (vcat? value)
  (and (cat-position-and-happiness? value)
       (number? (cat-position-and-happiness-x-coordinate value))
       (happiness-number? (cat-position-and-happiness-happiness value))
       (vcat-direction? (cat-position-and-happiness-direction value))))

(define (happiness-number? value)
  (and (number? value)
       (<= 0 value 100)))

(define (vcat-direction? value)
  (and (string? value)
       (or (string=? value "left")
           (string=? value "right"))))

(check-expect (vcham? (make-virtual-chameleon-world-state 0 100 "red")) #true)
(check-expect (vcham? (make-virtual-chameleon-world-state 100 50 "green")) #true)
; "pink" is not one of the background colors ("red", "green", or "blue")
(check-expect (vcham? (make-virtual-chameleon-world-state 0 100 "pink")) #false)
(check-expect (vcham? #true) #false)
(define (vcham? value)
  (and (virtual-chameleon-world-state? value)
       (number? (virtual-chameleon-world-state-x-position value))
       (happiness-number? (virtual-chameleon-world-state-happiness value))
       (background-color-for-vcham? (virtual-chameleon-world-state-background-color value))))

(define (background-color-for-vcham? value)
  (and (image-color? value)
       (or (string=? value "red")
           (string=? value "green")
           (string=? value "blue"))))
           