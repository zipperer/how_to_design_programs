;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname chapter_8_lists_0) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; Exercise 129
; Create BSL lists that represent
; a list of celestial bodies, say, at least all the planets in our solar system;
; a list of items for a meal, for example, steak, french fries, beans, bread, water, Brie cheese, and ice cream; and
; a list of colors.

; Sketch some box representations of these lists, similar to those in figures 44 and 45.
; Which of the sketches do you like better?

(define PLANETS-IN-SOLAR-SYSTEM
  (cons "Mercury"
        (cons "Venus"
              (cons "Earth"
                    (cons "Mars"
                          (cons "Jupiter"
                                (cons "Saturn"
                                      (cons "Uranus"
                                            (cons "Neptune"
                                                  (cons "Pluto" '()))))))))))

(define ITEMS-FOR-MEAL
  (cons "Steak"
        (cons "French Fries"
              (cons "Beans"
                    (cons "Bread"
                          (cons "Water"
                                (cons "Brie Cheese"
                                      (cons "Ice Cream" '()))))))))

(define COLORS
  (cons "Red"
        (cons "White"
              (cons "Blue" '()))))

; I like the boxes-in-boxes picture when depicting a single list.

; I like the boxes-and-arrows picture if multiple lists share a particular cons. For example:
; (define anchor (cons 'stake '()))
; (define first-rope (cons 'segment1 anchor))
; (define second-rope (cons 'segmen2 anchor))
; ___________|cons|  ___________|cons| 
; |first     |rest|  |first     |rest|
; |----------|----|  |----------|----|
; | segment1 |  o-|->| 'stake   |'() |
; |---------------|  |---------------|
;                    ^
; ___________|cons|  |
; |first     |rest|  |
; |----------|----|  |
; | segment2 |  o-|--
; |---------------|  


