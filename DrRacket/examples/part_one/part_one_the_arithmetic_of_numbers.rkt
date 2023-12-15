;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname part_one_the_arithmetic_of_numbers) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define x 3)
(define y 4)

(sqrt (+ (sqr x) (sqr y)))

(define (distance-to-origin point)
 (sqrt (+ (sqr (point-x x)) (sqr (point-y y)))))