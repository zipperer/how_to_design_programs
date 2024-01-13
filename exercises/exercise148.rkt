;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise148) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; Exercise 148
; Compare the function definitions from this section (sum, how-many, all-true, one-true)
; with the corresponding function definitions from the preceding sections.
; Is it better to work with data definitions that accommodate empty lists as opposed to definitions
; for non-empty lists? Why? Why not?

; This section
(define (all-true ne-list-of-booleans)
  (cond
    [(empty? (rest ne-list-of-booleans)) (first ne-list-of-booleans)]
    [else ; i.e. (cons? (rest ne-list-of-booleans))
     (and (first ne-list-of-booleans)
          (all-true (rest ne-list-of-booleans)))]))

(define (one-true ne-list-of-booleans)
  (cond
    [(empty? (rest ne-list-of-booleans)) (first ne-list-of-booleans)]
    [else ; i.e. (cons? (rest ne-list-of-booleans))
     (or (first ne-list-of-booleans)
         (one-true (rest ne-list-of-booleans)))]))

(define (sum ne-l)
  (cond
    [(empty? (rest ne-l)) (first ne-l)]
    [else (+ (first ne-l) (sum (rest ne-l)))]))


(define (how-many-non-empty-list non-empty-list)
  (cond
    [(empty? (rest non-empty-list)) 1]
    [else ; i.e. (cons? (rest non-empty-list))
     (+ 1 (how-many-non-empty-list (rest non-empty-list)))]))

; Preceding sections

(define (how-many alos)
  (cond
    [(empty? alos) 0]
    [else (+ (how-many (rest alos)) 1)]))

(define (sum list-of-amounts)
  (cond
    [(empty? list-of-amounts) 0]
    [(cons? list-of-amounts)
     (+ (first list-of-amounts)
     (sum (rest list-of-amounts)))]))

(define (all-true list-of-booleans)
  (cond
    [(empty? list-of-booleans) #true]
    [(cons? list-of-booleans)
     (and (first list-of-booleans)
          (all-true (rest list-of-booleans)))]))

(define (one-true list-of-booleans)
  (cond
    [(empty? list-of-booleans) #false]
    [(cons? list-of-booleans)
     (or (first list-of-booleans)
         (one-true (rest list-of-booleans)))]))

; When the list can be empty, the programmer must decide on a sensible value for the base case (i.e. the case when the list is empty).
; For some cases, this is easy, e.g. how-many should return 0, one-true should return #false.
; For other cases, it is easy to see why a choice is good, e.g. sum should return 0 despite there being no numbers to sum.
; For other cases, the programmer needs to know the convention or reason himself to the convention, e.g. all-true is #true despite there being no values .


; When the list is non-empty, the programmer does not need to decide on the the value.
; how-many for a list with one element is 1.
; one-true for a list with one element is #true when the element is #true and #false otherwise.
; all-true for a list with one element is #true when the element is #true and #false otherwise.
; sum for a list with one element is the value of the one element.

; The recursive cases are the same for the functions from this section and from the preceding section.

; Some cases will require that the programmer use a data definition with an empty list.
; Other cases may allow the programmer to insist that the caller provide a non-empty list.
; The world furnishes the constraints. The programmer adapts.
; In order to adapt, the programmer uses data definitions to state explicitly the assumptions.
; By abiding the discipline of writing data definitions and writing functions based on them,
; the programmer meets the world as it is.

; That is, it is not better to work with non-empty-lists or to work with lists that may be empty.
; It is good to state the data definition that handles the information at hand, and it is bad
; to fail to do this, e.g. by assuming the list is never empty.