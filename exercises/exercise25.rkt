;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise25) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)

(define (image-classify img) ; incorrect -- use stepper to suggest fix
  (cond
    [(>= (image-height img) (image-width img)) "tall"]
    [(=  (image-height img) (image-width img)) "square"]
    [(<= (image-height img) (image-width img)) "wide"]))

(image-classify (rectangle 10 10 "solid" "red"))
; the author of image-classify expects the rectangle will satisfy
; this clause (=  (image-height img) (image-width img)) of the cond
; and so the function will return "square".
; However, the rectangle satisfies a clause (>= (image-height img) (image-width img))
; before the (= y x) clause. So, the cond returns "tall".
; Stepping through the evaluation shows the rectangle satisfy the (>= y x) clause, and so
; suggests that the author replace >= with >, so that the rectangle does not satisfy a clause
; before evaluation reaches the (= y x) clause.