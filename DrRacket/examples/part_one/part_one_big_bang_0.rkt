;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname part_one_big_bang_0) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

(require 2htdp/universe)

(define (number->square s)
  (square s "solid" "red"))

;(big-bang 100
;    [to-draw number->square])

;(big-bang 100
;  [to-draw number->square]
;  [on-tick sub1]
;  [stop-when zero?])

;(define (equals1000 x)
;  (= x 1000))

;(big-bang 100
;  [to-draw number->square]
;  [on-tick add1]
;  [stop-when equals1000])

(define (reset current-state key-event-as-string)
  100)

(big-bang 100
  [to-draw number->square]
  [on-tick sub1]
  [stop-when zero?]
  [on-key reset])