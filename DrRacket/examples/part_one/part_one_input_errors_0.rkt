;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname part_one_input_errors_0) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; Number -> Number
; computes the area of a disk with radius r
(define (area-of-disk r)
  (* 3.14 (* r r)))

; Any -> Number
; computes the area of a disk with radius v,
; if v is a number
(define (checked-area-of-disk v)
  (cond
    [(number? v) (area-of-disk v)]
    [else (error "area-of-disk: number expected")]))

(check-expect (area-of-disk 1) 3.14)
(check-expect (area-of-disk 2) (* 3.14 (* 2 2)))
(check-error (area-of-disk "a"))

; A PositiveNumber is a Number greater than or equal to 0.

; PositiveNumber -> PositiveNumber
; computes the area of a disk with given radius
(define (area-of-disk-alternative radius)
  (* 3.14 (* radius radius)))

; Any -> PositiveNumber
; computes the area of a disk with given radius,
; if the given radius is a PositiveNumber
(define (checked-area-of-disk-alternative radius)
  (cond
    [(and (number? radius)
          (>= radius 0))
     (area-of-disk-alternative radius)]
    [else
     (error "area-of-disk-alternative expects a number greater than 0")]))

(check-expect (checked-area-of-disk-alternative 1) 3.14)
(check-expect (checked-area-of-disk-alternative 2) (* 3.14 (* 2 2)))
(check-error (checked-area-of-disk-alternative -1))
(check-error (checked-area-of-disk-alternative "a"))