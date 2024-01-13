;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise142) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)

; Exercise 142
; Design the ill-sized? function, which consumes a list of images loi and a positive number n.
; It produces the first image on loi that is not an n by n square; if it cannot find such an image, it produces #false.

; Hint: Use
; ImageOrFalse is one of:
; – Image
; – #false 
; for the result part of the signature.

; A List-of-images is one of:
; - '()
; - (cons Image List-of-images)
; Examples:
; '() is a List-of-images
; (cons (empty-scene 100 110) '()) is a List-of-images
; (cons (empty-scene 100 100) (cons (empty-scene 100 110) '())) is a List-of-images
; (cons 1 '()) is NOT a List-of-images

; List-of-images Number -> ImageOrFalse
; return first image from input list of images, which image is not an (side-length x side-length) square
; side-length is the input number
(check-expect (ill-sized? '() 100) #false)
(check-expect (ill-sized? (cons (empty-scene 100 110) '())  100) (empty-scene 100 110))
(check-expect (ill-sized? (cons (empty-scene 100 100) (cons (empty-scene 100 110) '()))  100) (empty-scene 100 110))
(define (ill-sized? list-of-images side-length)
  (cond
    [(empty? list-of-images) #false]
    [(cons? list-of-images)
     (cond
       [(not (image-is-square-with-side-length? (first list-of-images) side-length))
        (first list-of-images)]
       [else
        (ill-sized? (rest list-of-images) side-length)])]))

(define (image-is-square-with-side-length? image side-length)
  (and (= (image-width image) side-length)
       (= (image-height image) side-length)))