;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise81) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;#lang racket
;(require "exercise77.rkt") ; point-in-time-since-midnight

; copying exercise 77 below because with #lang racket DrRacket did not recognize check-expect

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


; Exercise 81.
; Design the function time->seconds, which consumes instances of time structures (see exercise 77)
; and produces the number of seconds that have passed since midnight.
; For example, if you are representing 12 hours, 30 minutes, and 2 seconds with one of these structures
; and if you then apply time->seconds to this instance, the correct result is 45002.

; PointInTimeSinceMidnight -> Number
; computes number of seconds since midnight
; stub/header:
;(define (time->seconds point-in-time-since-midnight)
;  0)
; functional examples
(check-expect (time->seconds (make-point-in-time-since-midnight 0 0 0)) 0)
(check-expect (time->seconds (make-point-in-time-since-midnight 0 0 30)) 30)
(check-expect (time->seconds (make-point-in-time-since-midnight 0 1 30)) 90)
(check-expect (time->seconds (make-point-in-time-since-midnight 1 0 0)) 3600)
(check-expect (time->seconds (make-point-in-time-since-midnight 12 30 2)) 45002)
; template
;(define (time->seconds point-in-time-since-midnight)
;  ... (point-in-time-since-midnight-hours point-in-time-since-midnight) ; Number
;  ... (point-in-time-since-midnight-minutes point-in-time-since-midnight) ; Number
;  ... (point-in-time-since-midnight-seconds point-in-time-since-midnight) ; Number
;  ...)

(define SECONDS-PER-MINUTE 60)
(define MINUTES-PER-HOUR 60)
(define SECONDS-PER-HOUR (* MINUTES-PER-HOUR SECONDS-PER-MINUTE))

(define (time->seconds point-in-time-since-midnight)
  (+
   (* SECONDS-PER-HOUR (point-in-time-since-midnight-hours point-in-time-since-midnight))
   (* SECONDS-PER-MINUTE (point-in-time-since-midnight-minutes point-in-time-since-midnight))
   (point-in-time-since-midnight-seconds point-in-time-since-midnight)))