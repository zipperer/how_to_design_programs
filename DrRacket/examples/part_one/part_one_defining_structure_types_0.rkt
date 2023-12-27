;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname part_one_defining_structure_types_0) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct my-posn [x y])

(check-expect (my-posn-x (make-my-posn 1 2)) 1)
(check-expect (my-posn-y (make-my-posn 1 2)) 2)
(check-expect (my-posn? (make-my-posn 1 2)) #true)

; Exercise 65
; Take a look at the following structure type definitions.

; Write down the names of the functions
;   (constructors, selectors, and predicates)
;   that each introduces.


(define-struct movie [title producer year])
; (define (make-movie title producer year) ...)
; (define (movie-title movie) ...)
; (define (movie-producer movie) ...)
; (define (movie-year movie) ...)
; (define (movie? x) ...)

(define-struct person [name hair eyes phone])
; (define (make-person name hair eyes phone) ...)
; (define (person-name person) ...)
; (define (person-hair person) ...)
; (define (person-eyes person) ...)
; (define (person-phone person) ...)
; (define (person? x) ...)

(define-struct pet [name number])
; (define (make-pet name number) ...)
; (define (pet-name pet) ...)
; (define (pet-number pet) ...)
; (deifne (pet? x) ...)

(define-struct CD [artist title price])
; (define (make-CD artist title price) ...)
; (define (CD-artist CD) ...)
; (define (CD-title CD) ...)
; (define (CD-price CD) ...)
; (define (CD? x) ...)

(define-struct sweater [material size producer])
; (define (make-sweater material size producer) ...)
; (define (sweater-material sweater) ...)
; (define (sweater-size sweater) ...)
; (define (sweater-producer sweater) ...)
; (define (sweater? x) ...)