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
  (cons "steak"
        (cons "french fries"
              (cons "beans"
                    (cons "bread"
                          (cons "water"
                                (cons "brie cheese"
                                      (cons "ice cream" '()))))))))

(define COLORS
  (cons "red"
        (cons "white"
              (cons "blue" '()))))

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


;----------------------------------------------
; A 3LON is a list of three numbers:
;   (cons Number (cons Number (cons Number '())))
; interpretation:
;   a point in 3-dimensional space

; A List-of-names is one of:
; - '()
; - (cons String List-of-names)
; interpretation:
;   a list of invitees, by last name

; Exercise 130
; Create an element of List-of-names that contains five Strings.
; Sketch a box representation of the list similar to those found in figure 44.

(define LIST-OF-FIVE-NAMES (cons "Felleisen"
                                 (cons "Findler"
                                       (cons "Krishnamurthi"
                                             (cons "Flatt"
                                                   (cons "Zipperer" '()))))))

; Explain why
;   (cons "1" (cons "2" '()))
; is an element of List-of-names and why
;   (cons 2 '())
; isn’t.

; claim: (cons "1" (cons "2" '()))
; argument:
; a. '() is a List-of-names by the first clause in the itemization.
; b. (cons "2" '()) is a List-of-names by the second clause in the itemization; for,
;      "2" is a String and '() is an element of List-of-names by (a).
; c. (cons "1" (cons "2" '())) is a List-of-names by the second clause in the itemization; for,
;    "1" is a String and (cons "2" '()) is a List-of-names by (b).

; claim: (cons 2 '()) is not an element of List-of-names
; argument:
; (cons 2 '()) is not '(), so (cons "2" '()) fails to be a List-of-names by the first clause in the itemization.
; a. '() is a List-of-names by the first clause in the itemization.
; b. 2 is a Number; it is not a String. So, (cons 2 '()) fails to match the pattern (cons String List-of-names).

; Exercise 131
; Provide a data definition for representing lists of Boolean values.
; The class contains all arbitrarily long lists of Booleans.

; A List-of-booleans is one of:
; - '()
; - (cons Boolean List-of-booleans)