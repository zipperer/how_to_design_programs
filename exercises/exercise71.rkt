;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise71) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; distances in terms of pixels:
(define HEIGHT 200)
(define MIDDLE (quotient HEIGHT 2))
(define WIDTH 400)
(define CENTER (quotient WIDTH 2))

(define-struct game [left-player right-player ball])

(define game0
  (make-game MIDDLE MIDDLE (make-posn CENTER CENTER)))

(check-expect (game-ball game0) (make-posn CENTER CENTER))
; (game-ball game0)
; == evaluate argument
; (game-ball (make-game MIDDLE MIDDLE (make-posn CENTER CENTER))
; == (game-ball (make-game L R B)) |-> B
; (make-posn CENTER CENTER)
(check-expect (posn? (game-ball game0)) #true)
; (posn? (game-ball game0))
; == evaluate argument
; (posn? (game-ball (make-game MIDDLE MIDDLE (make-posn CENTER CENTER)))
; == (game-ball (make-game L R B)) |-> B
; (posn? (make-posn CENTER CENTER))
; == (posn? (make-posn X Y)) |-> #true and (posn? (FUNCTION ...)) |-> #false where (not (equal? FUNCTION make-posn))
; #true
(check-expect (game-left-player game0) MIDDLE)
; (game-left-player game0)
; == evaluate argument
; (game-left-player (make-game MIDDLE MIDDLE (make-posn CENTER CENTER))
; == (game-left-player (make-game L R B)) |-> L
; MIDDLE