;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname part_one_programming_with_structures_0) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct posn-new [x y])
; A PosnNew is a structure:
;   (make-posn Number Number)
; interpretation: a point x pixels from left, y from top

(define-struct entry [name phone email])
; An Entry is a structure:
;   (make-entry String String String)
; interpretation: a contact's name, phone#, and email

(define-struct ball [location velocity])
; A Ball-1d is a structure:
;   (make-ball Number Number)
; interpretation alternative 1: distance to top and velocity
; interpretation alternative 2: distance to left and velocity

(define-struct vel    [deltax deltay])
; A Vel is a structure:
;   (make-vel Number Number)
; interpretation: (make-vel dx dy) means a velocity of
;   dx pixels [per tick] along the horizontal and
;   dy pixels [per tick] along the vertical direction

(define-struct ball2d [location velocity])
; A Ball2D is a structure:
;   (make-ball2d Posn Vel)
; interpretation: a 2-dimensional position and velocity