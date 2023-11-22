;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define (distance-to-origin-for-point-with-x-and-y-coordinates x-coordinate y-coordinate)
  (sqrt (+ (sqr x-coordinate) (sqr y-coordinate))))

(distance-to-origin-for-point-with-x-and-y-coordinates 3 4)
"should be"
5

(distance-to-origin-for-point-with-x-and-y-coordinates 12 5)
"should be"
13

; see https://docs.racket-lang.org/htdp-langs/beginner.html for library functions