;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise77) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;Exercise 77
; Provide a structure type definition and a data definition
; for representing points in time since midnight.
; A point in time consists of three numbers: hours, minutes, and seconds. 

(define-struct point-in-time-since-midnight [hours minutes seconds])
; A PointInTimeSinceMidnight is a structure:
;   (make-point-in-time-since-midnight Number Number Number)
; interpretation:
;   (make-point-in-time-since-midnight h m s) represents a point in time since midnight --
;     in particular the point h hours m minutes and s seconds since midnight.
;   e.g. (make-point-in-time-since-midnight 5 0 0) is 5 AM.
;         (make-point-in-time-since-midnight 23 59 59) is one second before the next midnight.
;   Since h is hours, m is minutes, and s is seconds:
;   h is in [0, 23]
;   m is in [0, 59]
;   s is in [0, 59]