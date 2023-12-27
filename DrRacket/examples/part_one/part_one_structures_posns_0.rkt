;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname part_one_structures_posns_0) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(make-posn 3 4)

(define one-posn (make-posn 8 6))

; posn is a datatype.
; interpretation of (make-posn 8 6):
; a position on the world canvas with
; x-coordinate 8 and
; y-coordinate 6
; i.e. a position 8 pixels from the left margin and
;                 6 pixels from the top margin

(define p (make-posn 31 26))
(posn-x p)
(posn-y p)

; (posn-x (make-posn x0 y0)) == x0
; (posn-y (make-posn x0 y0)) == y0