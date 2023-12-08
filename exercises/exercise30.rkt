;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise30) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; Exercise 30.
; Define constants for the price optimization program at the movie theater so that the
; price sensitivity of attendance (15 people for every 10 cents) becomes a computed constant.

(define SIZE-CHANGE-BETWEEN-PRICE-CHARGED .10)

(define SIZE-CHANGE-IN-NUMBER-OF-ATTENDEES-OBSERVED 15)

(define PRICE-SENSITIVITY (/ SIZE-CHANGE-IN-NUMBER-OF-ATTENDEES-OBSERVED SIZE-CHANGE-BETWEEN-PRICE-CHARGED))