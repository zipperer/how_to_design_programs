;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise17) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)

; These images I made with BSL:
; - (rectangle 10 5 "solid" "gray")
; - (rectangle 5 10 "solid" "gray")
; - (square 5 "solid" "blue") 
; - (circle 5 "solid" "red")
; I load them here because I load them in the .py version of this exercise.
; bitmap/file documentation:
; https://docs.racket-lang.org/teachpack/2htdpimage.html#%28def._%28%28lib._2htdp%2Fimage..rkt%29._bitmap%2Ffile%29%29
(define RECTANGLE_WIDE (bitmap/file "images/racket_rectangle_width_10_height_5_solid_gray.png"))
(define RECTANGLE_TALL (bitmap/file "images/racket_rectangle_width_5_height_10_solid_gray.png"))
(define SQUARE (bitmap/file "images/racket_square_length_5_solid_blue.png"))
(define CIRCLE (bitmap/file "images/racket_circle_radius_5_solid_red.png"))

(define (image-classify-as-tall-or-wide-or-square image)
  (cond
    [(> (image-height image) (image-width image)) "tall"]
    [(< (image-height image) (image-width image)) "wide"]
    [else "square"]))

(image-classify-as-tall-or-wide-or-square RECTANGLE_WIDE)
"should be"
"wide"

(image-classify-as-tall-or-wide-or-square RECTANGLE_TALL)
"should be"
"tall"

(image-classify-as-tall-or-wide-or-square CIRCLE)
"should be"
"square"

(image-classify-as-tall-or-wide-or-square SQUARE)
"should be"
"square"
