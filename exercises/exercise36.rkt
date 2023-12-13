;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise36) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 36. Design the function image-area, which counts the number of pixels in a given image.

; We represent:
; - an image using 2htdp/image library.
; - an area with a number

; image-area: image -> number
;  returns area of input image

; (define (image-area) image)
;   10)

; given: (circle 5 "solid" "red"), expect (* (* 5 2) (* 5 2)) == 100
; given: (rectangle 10 5 "solid" "red"), expect (* 10 5) == 50

; (define (image-area image)
;   ... image ...)

(require 2htdp/image)

(define (image-area image)
  (* (image-width image)
     (image-height image)))

(image-area (circle 5 "solid" "red"))
"should be"
100

(image-area (rectangle 10 5 "solid" "red"))
"should be"
50