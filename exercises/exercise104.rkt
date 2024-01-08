;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise104) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; Exercise 104
; Your home town manages a fleet of vehicles: automobiles, vans, buses, and SUVs.
; Develop a data representation for vehicles.
; The representation of each vehicle must describe:
; - the number of passengers that it can carry,
; - its license plate number, and
; - its fuel consumption (miles per gallon).
; Develop a template for functions that consume vehicles.

(define-struct automobile [passengers-limit license-plate-number miles-per-gallon])
(define-struct van [passengers-limit license-plate-number miles-per-gallon])
(define-struct bus [passengers-limit license-plate-number miles-per-gallon])
(define-struct suv [passengers-limit license-plate-number miles-per-gallon])
; An Automobile|Van|Bus|SUV is a structure:
;   (make-automobile Number String Number)
;   (make-van Number String Number)
;   (make-bus Number String Number)
;   (make-suv Number String Number)
; interpretation:
;   (make-automobile pl0 lp0 mpg0) represents an automobile
;   - that can carry pl0 passengers
;   - with license plate number lp0, and
;   - fuel consumption miles per gallon mpg0

(define (function-that-consumes-vehicle vehicle)
  (cond
    [(automobile? vehicle) (... automobile-passengers-limit ... automobile-license-plate-number ... automobile-miles-per-gallon ...)]
    [(van? vehicle) (... van-passengers-limit ... van-license-plate-number ... van-miles-per-gallon ...)]
    [(bus? vehicle) (... bus-passengers-limit ... bus-license-plate-number ... bus-miles-per-gallon ...)]
    [(suv? vehicle) (... suv-passengers-limit ... suv-license-plate-number ... suv-miles-per-gallon ...)]))

; Alternative?

(define-struct vehicle [type passengers-limit license-plate-number miles-per-gallon])
(define (make-automobile passengers-limit license-plate-number miles-per-gallon)
  (make-vehicle "automobile" passengers-limit license-plate-number miles-per-gallon))
(define (make-van passengers-limit license-plate-number miles-per-gallon)
  (make-vehicle "van" passengers-limit license-plate-number miles-per-gallon))
(define (make-bus passengers-limit license-plate-number miles-per-gallon)
  (make-vehicle "bus" passengers-limit license-plate-number miles-per-gallon))
(define (make-suv passengers-limit license-plate-number miles-per-gallon)
  (make-vehicle "suv" passengers-limit license-plate-number miles-per-gallon))

(define (function-that-consumes-vehicle-alternative vehicle)
  (cond
    [(string=? (vehicle-type vehicle) "automobile") ... vehicle-passengers-limit ... license-plate-number ... miles-per-gallon ... ]
    [(string=? (vehicle-type vehicle) "van") ... vehicle-passengers-limit ... license-plate-number ... miles-per-gallon ...]
    [(string=? (vehicle-type vehicle) "bus") ... vehicle-passengers-limit ... license-plate-number ... miles-per-gallon ...]
    [(string=? (vehicle-type vehicle) "suv") ... vehicle-passengers-limit ... license-plate-number ... miles-per-gallon ...]))