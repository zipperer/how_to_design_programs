;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise12) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define (cube-volume cube-side-length)
  ; accepts length of side of an equilateral cube and computes volume of cube
  (* cube-side-length
     cube-side-length
     cube-side-length))

(define (cube-surface cube-side-length)
  ; accepts length of side of an equilateral cube and computes surface area
  (* 6
     (* cube-side-length cube-side-length)))

(cube-volume 1)
"should be"
1

(cube-volume 2)
"should be"
8

(cube-surface 1)
"should be"
6

(cube-surface 2)
"should be"
24