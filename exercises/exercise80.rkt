;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise80) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; Exercise 80
; Create templates for functions that consume instances of the following structure types:
(define-struct movie [title director year])

#|
(define (movie-function movie-instance)
  ... movie-instance-title ; String
  ... movie-instance-director ; String
  ... movie-instance-year ; Number
  )
|#

(define-struct pet [name number])

#|
(define (pet-function pet-instance)
  ... pet-instance-name ; String
  ... pet-instance-number ; Number
  )
|#

(define-struct CD [artist title price])

#|
(define (CD-function CD-instance)
  ... CD-instance-artist ; String
  ... CD-instance-title ; String
  ... CD-instance-price ; Number
  )
|#

(define-struct sweater [material size color])

#|
(define (sweater-function sweater-instance)
  ... sweater-instance-material ; String
  ... sweater-instance-size ; String
  ... sweater-instace-color ; String
  )
|#