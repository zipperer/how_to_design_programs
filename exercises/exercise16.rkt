;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise16) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)

(define (image-area image)
  (* (image-width image)
     (image-height image)))

(image-area (circle 5 "solid" "red"))
"should be"
100

(image-area (square 5 "solid" "blue"))
"should be"
25