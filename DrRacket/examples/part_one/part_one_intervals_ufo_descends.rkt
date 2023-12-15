;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname part_one_intervals_ufo_descends) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

; A WorldState is a Number.
; interpretation number of pixels between the top and the UFO
 
(define WIDTH 300) ; distances in terms of pixels 
(define HEIGHT 100)
(define CLOSE (/ HEIGHT 3))
(define MTSCN-MIDDLE-X (* 1/2 WIDTH))
(define MTSCN (empty-scene WIDTH HEIGHT)) ; short for empty scene 
(define UFO (overlay (circle 10 "solid" "green") (ellipse 30 30 "solid" "grey")))
 
; WorldState -> WorldState
(define (main y0)
  (big-bang y0
     [on-tick nxt 1]
     [to-draw render]))
 
; WorldState -> WorldState
; computes next location of UFO 
(check-expect (nxt 11) 14)
(define (nxt y)
  (+ y 3))

(define TEXT-POSITION-X (/ WIDTH 5))
(define TEXT-POSITION-Y (/ HEIGHT 5))

; WorldState -> Image
; places UFO at given height into the center of MTSCN
(check-expect (render 11) (place-image (text "descending" 10 "black") TEXT-POSITION-X TEXT-POSITION-Y (place-image UFO MTSCN-MIDDLE-X 11 MTSCN)))
(define (render y)
  (place-image (text (cond [(< y (- HEIGHT CLOSE)) "descending"]
                           [(and (>= y (- HEIGHT CLOSE)) (< y (- HEIGHT 10))) "closing in"]
                           [else "landed"]) 10 "black")
                     TEXT-POSITION-X
                     TEXT-POSITION-Y
                     (place-image UFO
                                  MTSCN-MIDDLE-X
                                  (cond [(< y (- HEIGHT 10)) y] [else (- HEIGHT 10)])
                                  MTSCN)))