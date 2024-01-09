;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname part_one_equality_predicates_0) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; Any -> Boolean
; is the given value an element of TrafficLight
(define (light? x)
  (cond
    [(string? x) (or (string=? "red" x)
                     (string=? "green" x)
                     (string=? "yellow" x))]
    [else #false]))

(define MESSAGE
  "traffic light expected, given some other value")
 
; Any Any -> Boolean
; are the two values elements of TrafficLight and, 
; if so, are they equal
 
(check-expect (light=? "red" "red") #true)
(check-expect (light=? "red" "green") #false)
(check-expect (light=? "green" "green") #true)
(check-expect (light=? "yellow" "yellow") #true)
 
(define (light=? a-value another-value)
  (if (and (light? a-value) (light? another-value))
      (string=? a-value another-value)
      (error MESSAGE)))

; Exercise 115
; Revise light=? so that the error message specifies which of the two
; arguments isn’t an element of TrafficLight.

(define (light=?-alternative1 a-value another-value)
  (if (and (light? a-value) (light? another-value))
      (string=? a-value another-value)
      (cond
        [(and (not (light? a-value))
              (not (light? another-value)))
         (error "light=? expects two values that satisfy light?. Received two values that do not satisfy light?.")]
        [(not (light? a-value))
         (error "light=? expects two values that satisfy light?. First argument does not satisfy light?.")]
        [else
         (error "light=? expects two values that satisfy light?. Second argument does not satisfy light?.")])))

(define (light=?-alternative2 a-value another-value)
  (cond
    [(light? a-value)
     (cond
       [(light? another-value)
        (string=? a-value another-value)]
       [else
        (error "light=? expects two values that satisfy light?. Second argument does not satisfy light?.")])]
     [else
      (error "light=? expects two values that satisfy light?. First argument does not satisfy light?.")]))