;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname part_one_checking_the_world_0) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; (define (main s0)
;   (big-bang s0
;   ...
;   [check-with number?]
;   ...
;   ))

; A UnitWorld is a number 
;   between 0 (inclusive) and 1 (exclusive).

; Any -> Boolean 
; is x between 0 (inclusive) and 1 (exclusive)
 
(check-expect (between-0-and-1? "a") #false)
(check-expect (between-0-and-1? 1.2) #false)
(check-expect (between-0-and-1? 0.2) #true)
(check-expect (between-0-and-1? 0.0) #true)
(check-expect (between-0-and-1? 1.0) #false)
 
(define (between-0-and-1? x)
  (and (number? x) (<= 0 x) (< x 1)))

; With this predicate you can now monitor every single transition in your world program:
; (define (main s0)
;   (big-bang s0
;             ...
;             [check-with between-0-and-1?]
;             ...))

; Exercise 114
; Use the predicates from exercise 113 to check the
; space invader world program,
; the virtual pet program (exercise 106), and
; the editor program (A Graphical Editor).

#|
(define (main-space-invader-world-progam-with-checking-world-state-with-predicate
         initial-space-invader-world-state)
  (big-bang initial-space-invader-world-state
      ...
      [check-with sigs?]
      ...))
|#

#|
(define (main-virtual-pet-world-program-with-checking-world-state-with-predicate
         initial-virtual-pet-world-state)
  (big-bang  initial-virtual-pet-world-state
     ...
     [check-with vanimal?]
     ...))
|#

#|
(define (main-editor-world-program-with-checking-world-state-with-predicate
         initial-editor-world-state)
  (big-bang initial-editor-world-state
   ...
   [check-with editor-with-strings?]
   ...))

(define (editor-with-strings? value)
  (and (editor? value)
       (string? (editor-pre value))
       (string? (editor-post value))))
|#