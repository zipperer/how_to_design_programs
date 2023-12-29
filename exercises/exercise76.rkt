;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise76) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; Exercise 76
; Formulate data definitions for the following structure type definitions.
; Make sensible assumptions as to what kind of values go into each field. 

(define-struct movie [title producer year])
; A Movie is a structure:
;   (make-movie String String Number)
; interpretation:
;   (make-movie t p y) represents a movie with title t, producer p, released in year y.
;   e.g. (make-movie "Die Hard" "Lawrence Gordon;Joel Silver" 1988)

(define-struct person [name hair eyes phone])
; A Person is a structure:
;   (make-person String String String String) ; instead of String, phone could be structure PhoneNumber
; interpretation:
;   (make-person n h e p) represents a person with name n, hair color h, eye color e, and phone number p.
;   e.g. (make-person "Bruce Willis" "Brown" "Green" "8675309")

(define-struct pet [name number])
; A Pet is a structure:
;   (make-pet String Number)
; interpretation:
;   (make-pet name0 number0) represents a pet with name name0 which is the number0-th pet of that type you possess
;   e.g. (make-pet "Spot" 2) -- "Spot" is the 2nd dog you possess

(define-struct CD [artist title price])
; A CD is a structure:
;   (make-CD String String Number)
; interpretation:
;   (make-CD a t p) represents a CD made by artist a, with title t, and price p.
;   e.g. (make-cd "Michael Kamen" "Die Hard: Original Motion Picture Soundtrack" 9.99)

(define-struct sweater [material size producer])
; A Sweater is a structure:
;   (make-sweater String String String)
; interpretation:
;   (make-sweater m s p) represents a sweater made with material m in size s by producer p.
;   e.g. (make-sweater "Kevlar" "Large" "Dupont")
