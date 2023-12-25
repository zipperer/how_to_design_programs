;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise57) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

(define HEIGHT 300) ; distances in pixels 
(define WIDTH  100)
(define YDELTA 3)
 
(define BACKG  (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle 5 30 "solid" "red"))
 
(define CENTER (/ (image-height ROCKET) 2))
(define STATE-OF-WORLD-AT-TAKEOFF CENTER)

(define (place-rocket-on-background-at-x-coordinate-10-and-y-coordinate-minus-center y-coordinate)
  (place-image ROCKET 10 (- HEIGHT y-coordinate) BACKG))

(define (show x)
  (cond
    [(string? x)
     (place-rocket-on-background-at-x-coordinate-10-and-y-coordinate-minus-center CENTER)]
    [(<= -3 x -1)
     (place-image (text (number->string x) 20 "red")
                  10 (* 3/4 WIDTH)
		  (place-rocket-on-background-at-x-coordinate-10-and-y-coordinate-minus-center CENTER))]
    [(>= x 0)
     (place-rocket-on-background-at-x-coordinate-10-and-y-coordinate-minus-center x)]))


(check-expect (launch "resting" " ") -3)
(check-expect (launch "resting" "a") "resting")
(check-expect (launch -3 " ") -3)
(check-expect (launch -1 " ") -1)
(check-expect (launch 33 " ") 33)
(check-expect (launch 33 "a") 33)

(define (launch x ke)
  (cond
    [(string? x) (if (string=? " " ke) -3 x)]
    [(<= -3 x -1) x]
    [(>= x 0) x]))


; LRCD -> LRCD
(define (main1 s)
  (big-bang s
    [to-draw show]
    [on-key launch]))

;(main1 "resting")


; LRCD -> LRCD
; raises the rocket by YDELTA if it is moving already 
 
;(check-expect (fly "resting") "resting")
;(check-expect (fly -3) -2)
;(check-expect (fly -2) -1)
;(check-expect (fly -1) HEIGHT)
;(check-expect (fly 10) (- 10 YDELTA))
;(check-expect (fly 22) (- 22 YDELTA))
 
(define (fly x)
  (cond
    [(string? x) x]
    [(<= -3 x -1) (if (= x -1) STATE-OF-WORLD-AT-TAKEOFF (+ x 1))]
    [(>= x 0) (+ x YDELTA)]))

(define CLOCK-TICKS-PER-SECOND 1)

(define (rocket-is-out-of-sight? current-world-state-height)
  (= current-world-state-height HEIGHT))

(define (rocket-reaches-atmosphere current-world-state)
  (cond
    [(and (string? current-world-state)
          (string=? "resting" current-world-state)) #false]
    [(<= -3 current-world-state -1) #false]
    [(<= 0 current-world-state) (rocket-is-out-of-sight? current-world-state)]))

(define (main2 initial-state)
  (big-bang initial-state
    [to-draw show]
    [on-tick fly CLOCK-TICKS-PER-SECOND]
    [stop-when rocket-reaches-atmosphere]
    [on-key launch]))

; Exercise 56 and 57 differ on whether the nonnegative integer
; in the data definition represents the distance of the
; rocket from the (a) top of the image or (b) bottom of
; the image. 
; The different intereptation implies different implementations for
;  - how to think about where to put rocket at takeoff
;  -- i.e. (a) HEIGHT distance from top or (b) 0 distance from bottom
;  - how to change state of world (increase v decrease)
;  -- i.e. (a) decrease distance from top as rocket ascends or
;  --      (b) increase distance from bottom as rocket ascends
;  - how to show position of rocket given world state
;  -- place image higher to reflect (a) decreasing distance from top or 
;     (b) increasing distance from bottom
;  - how to check whether rocket is out of view
;  -- i.e. the distance between rocket and (a) top has decreased to 0 or
;          (b) bottom has increased to HEIGHT