;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname chapter_9_lists_2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)

;(overlay/align "middle" "middle"
;               (triangle 15 "solid" "red")
;               (overlay/align "middle" "middle"
;                              (triangle 30 "solid" "orange")
;                              (triangle 60 "solid" "purple")))


(define-struct layer [color doll])

; An RD (short for Russian doll) is one of:
; - String
; - (make-layer String RD)
; interpretation:
; - "yellow" is a yellow doll with no doll inside
; - (make-layer "green" "yellow") is a green doll with a yellow doll inside
; - (make-layer "pink" (make-layer "green" "yellow")) is a pink doll with a green doll inside, which green doll as a yellow doll inside

; BEGIN AZ
(define OUTERMOST-TRIANGLE-SIDE-LENGTH 100)
(define RATIO-SIDE-LENGTHS-CONTAINING-DOLL-CONTAINED-DOLL .6) ; .8
; RD -> Image
; depicts RD as triangles overlain on each other
;(check-expect (draw-dolls "yellow") (triangle OUTERMOST-TRIANGLE-SIDE-LENGTH "solid" "yellow"))
;(check-expect (draw-dolls (make-layer "green" "yellow"))
;              (overlay/align "middle" "middle"
;                             (triangle (* RATIO-SIDE-LENGTHS-CONTAINING-DOLL-CONTAINED-DOLL
;                                          OUTERMOST-TRIANGLE-SIDE-LENGTH)
;                                       "solid" "yellow")
;                             (triangle OUTERMOST-TRIANGLE-SIDE-LENGTH "solid" "green"))
;              
;(check-expect (draw-dolls (make-layer "pink" (make-layer "green" "yellow")))
;              (overlay/align "middle" "middle"
;                             (triangle (* RATIO-SIDE-LENGTHS-CONTAINING-DOLL-CONTAINED-DOLL
;                                          RATIO-SIDE-LENGTHS-CONTAINING-DOLL-CONTAINED-DOLL
;                                          OUTERMOST-TRIANGLE-SIDE-LENGTH)
;                                       "solid" "yellow")
;                            (overlay/align "middle" "middle"
;                                           (triangle (* RATIO-SIDE-LENGTHS-CONTAINING-DOLL-CONTAINED-DOLL
;                                                        OUTERMOST-TRIANGLE-SIDE-LENGTH)
;                                                     "solid" "green")
;                                           (triangle OUTERMOST-TRIANGLE-SIDE-LENGTH "solid" "pink"))))

; get list of colors to draw
; get length of list of colors to draw
; for entry in list, side-length is (* (ratio ^ index) OUTERMOST-SIDE-LENGTH)
;(define (draw-dolls dolls)
;  (draw-dolls-given-current-depth-and-dolls-to-draw-so-far dolls 0))

; maybe more natural thing is to increase the size each time rather than decrease

;(define (draw-dolls dolls)
;  (draw-dolls-given-current-depth-and-dolls-to-draw-so-far dolls 0 '()))

; RD Number List-of-doll-colors -> Image
;(define (draw-dolls-given-current-depth-and-dolls-to-draw-so-far dolls 0 '())
;  (cond
;    [(string? dolls) ]))

(define (draw-dolls doll)
  (draw-doll-colors-overlain-at-depth (doll-colors doll) 0))

; colors in order outer to inner
(define (doll-colors doll)
  (cond
    [(string? doll) (cons doll '())]
    [(layer? doll)
     (cons (layer-color doll) (doll-colors (layer-doll doll)))]))

(define (triangle-side-length-at-depth depth)
  (* (expt RATIO-SIDE-LENGTHS-CONTAINING-DOLL-CONTAINED-DOLL depth)
     OUTERMOST-TRIANGLE-SIDE-LENGTH))

(define (draw-doll-with-color-at-depth color depth)
  (triangle (triangle-side-length-at-depth depth) "solid" color))

(define (draw-doll-colors-overlain doll-colors)
  (draw-doll-colors-overlain-at-depth doll-colors 0))

(define (draw-doll-colors-overlain-at-depth doll-colors depth)
  (cond
    [(empty? (rest doll-colors)) (draw-doll-with-color-at-depth (first doll-colors) depth)]
    [(cons? doll-colors) (underlay/align "middle" "middle"
                                       (draw-doll-with-color-at-depth (first doll-colors) depth)
                                       (draw-doll-colors-overlain-at-depth (rest doll-colors) (add1 depth)))]))

(draw-dolls "yellow")
(draw-dolls (make-layer "green" "yellow"))
(draw-dolls (make-layer "pink" (make-layer "green" "yellow")))
(draw-dolls (make-layer "red" (make-layer "pink" (make-layer "green" "yellow"))))
; END AZ

; RD -> Number
; how many dolls are part of an-rd
(define (depth an-rd)
  (cond
    [(string? an-rd) ...]
    [(layer? an-rd)
     (... (layer-color an-rd) ...
      ... (depth (layer-doll an-rd)) ...)]))

(define (count-dolls an-rd)
  (cond
    [(string? an-rd) 1]
    [(layer? an-rd)
     (+ 1 (count-dolls (layer-doll an-rd)))]))

; Exercise 154
; Design the function colors.
; It consumes a Russian doll and produces a string of all colors, separated by a comma and a space.
; Thus our example should produce "yellow, green, red"

; RD -> String
; produces string of colors separated by a comma and a space
(check-expect (colors "yellow") "yellow")
(check-expect (colors (make-layer "green" "yellow")) "green, yellow")
(check-expect (colors (make-layer "yellow" (make-layer "green" "red"))) "yellow, green, red")
(define (colors an-rd)
  (cond
    [(string? an-rd) an-rd]
    [(layer? an-rd)
     (string-append (layer-color an-rd) ", " (colors (layer-doll an-rd)))]))

; Exercise 155
; Design the function inner, which consumes an RD and produces the (color of the) innermost doll.
; Use DrRacket’s stepper to evaluate (inner rd) for your favorite rd.

; RD -> String
; return color of innermost doll
(check-expect (inner "yellow") "yellow")
(check-expect (inner (make-layer "yellow" "green")) "green")
(check-expect (inner (make-layer "green" (make-layer "yellow" "red"))) "red")
(define (inner an-rd)
  (cond
    [(string? an-rd) an-rd]
    [(layer? an-rd)
     (inner (layer-doll an-rd))]))

; (inner (make-layer "green" (make-layer "yellow" "red")))