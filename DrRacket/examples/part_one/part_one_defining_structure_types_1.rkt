;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname part_one_defining_structure_types_1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Sample Problem
; Develop a structure type definition for a program
; that deals with “bouncing balls,” briefly mentioned at
; the very beginning of this chapter. The ball’s location
; is a single number, namely the distance of pixels from the
; top. Its constant speed is the number of pixels it moves
; per clock tick. Its velocity is the speed plus the direction
; in which it moves.

; Problem from beginning of chapter:
; Suppose you want to design a world program
; that simulates a ball bouncing back and forth
; on a straight vertical line between the floor
; and ceiling of some imaginary, perfect room.
; Assume that it always moves two pixels per clock
; tick. If you follow the design recipe, your first
; goal is to develop a data representation for what
; changes over time. Here, the ball’s position and
; its direction change over time, but that’s two
; values while big-bang keeps track of just one.
; Thus the question arises how one piece of data
; can represent two changing quantities of information.

; AZ
(define-struct world-state-bouncing-ball
  [distance-from-top-of-canvas ; Number of pixels
   number-of-pixels-to-move-per-clock-tick ; Number of pixels
   direction-of-motion] ; Enumeration: 'down' 'up'
  ; velocity is derived property:
  ;   (* number-of-pixels-to-move-per-clock-tick
  ;      direction-of-motion)
  ; or
  ;   (* number-of-pixels-to-move-per-clock-tick
  ;      (direction-of-motion->sign direction-of-motion))
  ; where
  ; (define (direction-of-motion->sign direction-of-motion)
  ;   (cond
  ;     [(equal? direction-of-motion "down") -1]
  ;     [(equal? direction-of-motion "up) 1]))


  ; Text:
  (define-struct ball [location velocity])
  (make-ball 10 -3) ; represents a ball that is 10 pixels from
                    ; the top and moves up at 3 pixels per clock tick

  ; "since the ball moves along a straight, vertical line, a number
  ;   is a perfectly adequate data representation for its velocity:
  ;   - A positive number means the ball moves down
  ;   - A negative number means it moves up"