;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise9) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)

(define (convert-to-non-negative-number value-with-type-unknown-to-program-designer)
  (cond
    [(string? value-with-type-unknown-to-program-designer)
     (string-length value-with-type-unknown-to-program-designer)]
    [(image? value-with-type-unknown-to-program-designer)
     (* (image-width value-with-type-unknown-to-program-designer)
        (image-height value-with-type-unknown-to-program-designer))]
    [(number? value-with-type-unknown-to-program-designer)
     (abs value-with-type-unknown-to-program-designer)]
    [(boolean? value-with-type-unknown-to-program-designer)
     (if value-with-type-unknown-to-program-designer
         10
         20)]
    [else
     "convert-to-non-negative-number failed to recognize type"])) ; the message is not a non-negative number
         
(convert-to-non-negative-number "hello")
"should be"
5

(convert-to-non-negative-number (circle 5 "solid" "white"))
"should be"
100 ; radius is 5. so, diameter is (* 2 5). so width is 10, and height is 10. So area is 100.

(convert-to-non-negative-number -4)
"should be"
4

; The number case is not yet specific enough, because it does not handle complex numbers
; (convert-to-non-negative-number (sqrt -1))
; yields error 'abs: expects a real, given 0+1i'

(convert-to-non-negative-number #true)
"should be"
10

(convert-to-non-negative-number #false)
"should be"
20
