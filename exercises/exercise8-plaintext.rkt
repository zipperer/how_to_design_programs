;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise8-plaintext) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)

(define (image-is-tall-or-wide image)
  (if (>= (image-height image) (image-width image))
      "tall"
      "wide"))

(define (image-is-tall-wide-or-square image)
  (if (> (image-height image) (image-width image))
      "tall"
      (if (= (image-height image) (image-width image))
          "square"
          "wide")))

(image-is-tall-wide-or-square (rectangle 1 2 "solid" "black"))
"should be"
"tall"

(image-is-tall-wide-or-square (square 2 "solid" "black"))
"should be"
"square"

(image-is-tall-wide-or-square (rectangle 2  1 "solid" "black"))
"should be"
"wide"
