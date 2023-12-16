;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname part_one_itemizations_launch_rocket_with_spacebar_data_definitions) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; Data definition
; An LR (short for launching rocket) is one of:
; - "resting"
; - NonnegativeNumber
; interpretation:
;   "resting" represents a grounded rocket
;   a number denotes the height of the rocket in flight

; The intepretation of number is ambiguous because height is ambiguous.
; Does height refer to:
;  - distance between the ground and the rocket's center? or alternatively,
;  - distance between top of the canvas and the rocket's center?

; For this exercise, we use the second interpretation.

; Exercise 53. The design recipe for world programs demands that you translate
; information into data and vice versa to ensure a complete understanding of the
; data definition. It’s best to draw some world scenarios and to represent them
; with data and, conversely, to pick some data examples and to draw pictures that
; match them. Do so for the LR definition, including at least HEIGHT and 0 as examples.

; Given data "resting":
; interpretations is the world scenario that corresponds to that resting state
; (place-image ROCKET BACKGROUND-MIDDLE-X ROCKET-INITIAL-POSITION BACKGROUND)
; where ROCKET-INITIAL-POSITION is calculated from BACKGROUND-HEIGHT and height of ROCKET

; Given data numerical height 0:
; interpretation is the world scenario that corresponds to the state when the ROCKET
; is at the top of the canvas and the top half is off canvas.
; (place-image ROCKET BACKGROUND-MIDDLE-X 0 BACKGROUND)

; Given data numerical height HEIGHT:
; interpretation is the world scenario that corresponds to the state when the ROCKET
; is no longer resting and the distance from the top of the canvas and the ROCKET's center
; is HEIGHT.
; (place-image ROCKET BACKGROUND-MIDDLE-X HEIGHT BACKGROUND