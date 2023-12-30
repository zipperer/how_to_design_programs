;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname part_one_designing_with_structures_1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct r3 [x y z])
; An R3 is a structure:
;   (make-r3 Number Number Number)

(define ex1 (make-r3 1 2 13))
(define ex2 (make-r3 -1 0 3))

(define check-within-tolerance-distance-to-origin .01)
; R3 -> Number
; compute distance from point in 3D space to origin
(check-within (distance-to-origin (make-r3 1 2 13))
              (sqrt (+ (sqr 1)
                       (sqr 2)
                       (sqr 13)))
              check-within-tolerance-distance-to-origin)
(check-within (distance-to-origin (make-r3 -1 0 3))
              (sqrt (+ (sqr -1)
                       (sqr 0)
                       (sqr 3)))
              check-within-tolerance-distance-to-origin)
; (define (distance-to-origin r3)
;   0)

; (define (distance-to-origin r3)
;   ... (r3-x r3) ...   ; Number
;   ... (r3-y r3) ...   ; Number
;   ... (r3-z r3) ...   ; Number
;  )

(define (distance-to-origin r3)
  (sqrt (+ (sqr (r3-x r3))
           (sqr (r3-y r3))
           (sqr (r3-z r3)))))
