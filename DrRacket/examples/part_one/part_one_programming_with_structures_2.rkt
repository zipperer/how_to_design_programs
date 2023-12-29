;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname part_one_programming_with_structures_2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct vel [deltax deltay])
; A Vel is a structure:
;   (make-vel Number Number)
; interpretation:
;   (make-vel dx dy) is a velocity where dx is speed in x dimension
;                                        dy is speed in y dimension

(define-struct ufo [loc vel])
; A UFO is a structure:
;   (make-ufo Posn Vel)
; interpretation:
;   (make-ufo p v) is at location p moving at velocity v

; It is your task to develop ufo-move-1.
; The function computes the location of a given UFO after one clock tick passes.

; AZ
;(check-expect (ufo-move-1 (make-ufo (make-posn X Y)
;                                    (make-vel DELTAX DELTAY)))
;              (make-ufo (make-posn NEWX NEWY)
;                        (make-vel NEWDELTAX NEWDELTAY)))
(check-expect (ufo-move-1 (make-ufo (make-posn 10 20)
                                    (make-vel 3 -4)))
              (make-ufo (make-posn 13 16)
                        (make-vel 3 -4)))
(check-expect (ufo-move-1 (make-ufo (make-posn 20 10)
                                    (make-vel 3 -4)))
              (make-ufo (make-posn 23 6)
                        (make-vel 3 -4)))
(define (ufo-move-1 ufo)
  (make-ufo (make-posn (+ (posn-x (ufo-loc ufo)) (vel-deltax (ufo-vel ufo)))
                       (+ (posn-y (ufo-loc ufo)) (vel-deltay (ufo-vel ufo))))
            (ufo-vel ufo)))