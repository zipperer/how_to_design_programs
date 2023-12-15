;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise47) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

; WorldState is a number
; - number is in range 0 to 100 inclusive
; - number represents gauge reading on happiness gauge

(define (tock current-world-state)
  (if (<= current-world-state 0)
      0
      (- current-world-state 0.1)))

(define FACTOR-BY-WHICH-TO-REDUCE-HAPPINESS-ON-DOWN-ARROW 1/5)

(define COEFFICIENT-TO-REDUCE-HAPPINESS-BY-FACTOR-ON-DOWN-ARROW (- 1 FACTOR-BY-WHICH-TO-REDUCE-HAPPINESS-ON-DOWN-ARROW))

(define FACTOR-BY-WHICH-TO-INCREASE-HAPPINESS-ON-UP-ARROW 1/3)

(define COEFFICIENT-TO-INCREASE-HAPPINESS-BY-FACTOR-ON-UP-ARROW (+ 1 FACTOR-BY-WHICH-TO-INCREASE-HAPPINESS-ON-UP-ARROW))

(define (key-handler current-world-state key-as-string)
  (cond
    [(string=? key-as-string "down")
     (* current-world-state COEFFICIENT-TO-REDUCE-HAPPINESS-BY-FACTOR-ON-DOWN-ARROW)]
    [(string=? key-as-string "up")
     (* current-world-state COEFFICIENT-TO-INCREASE-HAPPINESS-BY-FACTOR-ON-UP-ARROW)]
    [else current-world-state]))

(define BACKGROUND-HEIGHT 100)
(define BACKGROUND-WIDTH (/ BACKGROUND-HEIGHT 5))
(define BACKGROUND (empty-scene BACKGROUND-WIDTH BACKGROUND-HEIGHT))
(define BLACK-FRAME-HEIGHT (* .98 BACKGROUND-HEIGHT))
(define BLACK-FRAME-WIDTH (* .98 BACKGROUND-WIDTH))
(define BLACK-FRAME (rectangle BLACK-FRAME-WIDTH BLACK-FRAME-HEIGHT "outline" "black"))
(define BACKGROUND-WITH-BLACK-FRAME (underlay/xy BACKGROUND (* .01 BACKGROUND-WIDTH) (* .01 BACKGROUND-HEIGHT) BLACK-FRAME))

(define (render current-world-state)
  (place-image (rectangle (* .98 BLACK-FRAME-WIDTH) current-world-state "solid" "red")
               (* 1/2 BACKGROUND-WIDTH)
               (* .98 BACKGROUND-HEIGHT)
               BACKGROUND-WITH-BLACK-FRAME))

(define (end? current-world-state)
  #false)

(define (gauge-prog initial-world-state)
  (big-bang initial-world-state
    [on-tick tock]
    [stop-when end?]
    [on-key key-handler]
    [to-draw render]))

(gauge-prog 30)