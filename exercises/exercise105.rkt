;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise105) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; Exercise 105
; Some program contains the following data definition:

; A Coordinate is one of: 
; – a NegativeNumber 
; interpretation: on the y axis, distance from top
; – a PositiveNumber 
; interpretation: on the x axis, distance from left
; – a Posn
; interpretation an ordinary Cartesian point

; Make up at least two data examples per clause in the data definition.
; For each of the examples, explain its meaning with a sketch of a canvas.


(define example-coordinate-0 -1)
; Point on y axis 1 unit below top
;_____________
;.            |
;             |
;             |
;             |
;             |
;_____________|

(define example-coordinate-1 -5)
; Point on y axis 5 units below top
;_____________
;             |
;             |
;             |
;             |
;.            |
;_____________|

(define example-coordinate-2 1)
; Point on x axis 1 unit right of left-margin
;_____________
;             |
;             |
;             |
;             |
;             |
;_.___________|

(define example-coordinate-3 5)
; Point on x axis 5 units right of left-margin
;_____________
;             |
;             |
;             |
;             |
;             |
;______.______|

(define example-coordinate-4 (make-posn 1 1))
; Point at (1, 1)
;_____________
;             |
;             |
;             |
;             |
; .           |
;_____________|

(define example-coordinate-5 (make-posn 5 5))
; Point at (5, 5)
;_____________
;             |
;     .       |
;             |
;             |
;             |
;_____________|

(define example-coordinate-6 (make-posn 7 2))
; Point at (7, 2)
;_____________
;             |
;             |
;             |
;       .     |
;             |
;_____________|
