;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname part_one_designing_with_structures_0) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; Sample Problem
; Design a function that computes the distance of objects in a 3-dimensional space
; to the origin.

; data definition
; signature, purpose statement, header
; functional examples
; function template
; fill in template
; format functional examples as tests

; data definition
; need to represent object position in 3-dimensional space
; will have three values
; each value is distance from point to origin in one dimension: x, y, z

; A PositionIn3DimensionalSpace is a structure:
;   (make-position-in-3-dimensional-space Number Number Number)
; interpretation:
;   (make-position-in-3-dimensional-space x0 y0 z0) represents the point (x0, y0, z0) in 3-D space
(define-struct position-in-3-dimensional-space [x y z])
; examples
(define origin-in-3-dimensional-space (make-position-in-3-dimensional-space 0 0 0))
(define point-1-1-1-in-3-dimensional-space (make-position-in-3-dimensional-space 1 1 1))
(define point-1-1-0-in-3-dimensional-space (make-position-in-3-dimensional-space 1 1 0))
; PositionIn3DimensionalSpace -> Number
; distance from position to origin
; (define (distance-of-object-in-3-dimensional-space-to-origin object-in-3-dimensional-space)
;  0)

; (define (distance-of-object-in-3-dimensional-space-to-origin object-in-3-dimensional-space)
;  ... (position-in-3-dimensional-space-x object-in-3-dimensional-space) ...
;  ... (position-in-3-dimensional-space-y object-in-3-dimensional-space) ...
;  ... (position-in-3-dimensional-space-z object-in-3-dimensional-space) ...)

(define made-up-tolerance-for-check-within .01)
(check-expect (distance-of-object-in-3-dimensional-space-to-origin origin-in-3-dimensional-space) 0)
(check-within (distance-of-object-in-3-dimensional-space-to-origin point-1-1-1-in-3-dimensional-space) (sqrt 3) made-up-tolerance-for-check-within)
(check-within (distance-of-object-in-3-dimensional-space-to-origin point-1-1-0-in-3-dimensional-space) (sqrt 2) made-up-tolerance-for-check-within)
(define (distance-of-object-in-3-dimensional-space-to-origin object-in-3-dimensional-space)
  (sqrt (+ (sqr (position-in-3-dimensional-space-x object-in-3-dimensional-space))
           (sqr (position-in-3-dimensional-space-y object-in-3-dimensional-space))
           (sqr (position-in-3-dimensional-space-z object-in-3-dimensional-space)))))