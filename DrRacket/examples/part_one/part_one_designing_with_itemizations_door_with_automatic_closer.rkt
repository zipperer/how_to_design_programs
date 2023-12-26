;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname part_one_designing_with_itemizations_door_with_automatic_closer) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

; Sample Problem
; Design a world program that simulates the working
; of a door with an automatic door closer. If this
; kind of door is locked, you can unlock it
; with a key. An unlocked door is closed, but someone
; pushing at the door opens it. Once the person has
; passed through the door and lets go, the automatic
; door takes over and closes the door again. When a
; door is closed, the can be locked again.

; See Figure 28 and its description.

                         ; A DoorState is one of:
(define LOCKED "locked") ; - LOCKED
(define CLOSED "closed") ; - CLOSED
(define OPEN "open")     ; - OPEN

; DoorState -> DoorState
; door-closer
(check-expect (door-closer LOCKED) LOCKED)
(check-expect (door-closer CLOSED) CLOSED)
(check-expect (door-closer OPEN) CLOSED)
; DoorState is an Enumeration, so I use cond.
(define (door-closer door-state)
  (cond
    [(equal? door-state LOCKED) LOCKED]
    [(equal? door-state CLOSED) CLOSED]
    [(equal? door-state OPEN) CLOSED]))

; DoorState KeyEvent -> DoorState
; turns key event key-event into an action on state door-state
(check-expect (door-action LOCKED "u") CLOSED)
(check-expect (door-action CLOSED "l") LOCKED)
(check-expect (door-action CLOSED " ") OPEN)
(check-expect (door-action OPEN "u") OPEN)
(check-expect (door-action CLOSED "a") CLOSED)
; DoorState is an Enumeration, so I use cond.
(define (door-action door-state key-event)
  (cond
    [(equal? door-state LOCKED)
     (cond
       [(equal? key-event "u") CLOSED]
       [else LOCKED])]
    [(equal? door-state CLOSED)
     (cond
       [(equal? key-event "l") LOCKED]
       [(equal? key-event " ") OPEN]
       [else CLOSED])]
    [(equal? door-state OPEN) OPEN]))

; DoorState -> Image
; translates the state s into a large text image
(check-expect (door-render CLOSED) (text CLOSED 40 "red"))
(define (door-render door-state)
  (text door-state 40 "red"))

(define SECONDS-PER-CLOCK-TICK 3)

; DoorState -> DoorState
; simulates a door with an automatic door closer
(define (door-simulation initial-state)
  (big-bang initial-state
    [on-tick door-closer SECONDS-PER-CLOCK-TICK]
    [on-key door-action]
    [to-draw door-render]))