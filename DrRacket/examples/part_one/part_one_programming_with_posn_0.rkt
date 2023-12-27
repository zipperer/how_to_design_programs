;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname part_one_programming_with_posn_0) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; posn -> Number
; computes the distance of given-posn to the origin
;(define (distance-to-0 given-posn)
;  0)

;(define (distance-to-0 given-posn)
;  ... (posn-x given-posn) ... (posn-y given-posn ... )

(check-expect (distance-to-0 (make-posn 0 5)) 5)
(check-expect (distance-to-0 (make-posn 7 0)) 7)
(check-expect (distance-to-0 (make-posn 3 4)) 5)
(check-expect (distance-to-0 (make-posn 8 6)) 10)
(check-expect (distance-to-0 (make-posn 5 12)) 13)

(define (distance-to-0 given-posn)
  (sqrt
   (+
    (sqr (posn-x given-posn))
    (sqr (posn-y given-posn)))))

(distance-to-0 (make-posn 3 4))
; ==
; (sqrt (+ (sqr (posn-x (make-posn 3 4))) (sqr (posn-y (make-posn 3 4)))))
; ==
; (sqrt (+ (sqr 3) (sqr 4)))
; ==
; (sqrt (+ 9 16))
; ==
; 5
(distance-to-0 (make-posn 6 (* 2 4)))
; ==
; (distance-to-0 (make-posn 6 8))
; ==
; (sqrt (+ (sqr (posn-x (make-posn 6 8))) (sqr (posn-y (make-posn 6 8)))))
; ==
; (sqrt (+ (sqr 6) (sqr 8)))
; ==
; (sqrt (+ 36 64))
; ==
; 10
(+ (distance-to-0 (make-posn 12 5)) 10)
; ==
; (+ (sqrt (+ (sqr (posn-x (make-posn 12 5))) (sqr (posn-y (make-posn 12 5)))))
;    10)
; ==
; (+ (sqrt (+ (sqr 12) (sqr 5)))
;    10)
; ==
; (+ (sqrt (+ 144 25))
;    10)
; ==
; (+ 13 10)
; ==
; 23