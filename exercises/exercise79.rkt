;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise79) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; Exercise 79
; Create examples for the following data definitions:

; 1. 
; A Color is one of: 
; — "white"
; — "yellow"
; — "orange"
; — "green"
; — "red"
; — "blue"
; — "black"

; Examples include: "red", "white", and "blue".

; 2. 
; H is a Number between 0 and 100.
; interpretation represents a happiness value

; For example,
; - 0 is a happiness value
; - 100 is a happiness value
; - 61 is a happiness value

; 3. 
(define-struct person [fstname lstname male?])
; A Person is a structure:
;   (make-person String String Boolean)

; For example:
;   (make-person "Bruce" "Willis" #true) represents Bruce Willis
;   (make-person "Brucina" "Willis" #false) represents Brucina Willis
 
; Question: Is it a good idea to use a field name that looks like the name of a predicate?
; Answer: No, because the selector looks like it is asking a question rather than selecting
;         the value for a field.
; Counterpoint: Given that the value for the field is a boolean, then selecting the value
;               from that field is at least akin to asking the question and could be seen
;               as equivalent to asking the question.
; Counter-counterpoint: So far we have seen predicates only for types of data, e.g.
;                       number?, string?, posn?. (person-male? x) -- if seen as a question
;                       like the others -- looks like it is asking whether x is an instance
;                       of datatype person-male. To read it as asking whether the person x
;                       is male requires reading it differently than we read number? string?
;                       and posn?.
; 4.
(define-struct dog [owner name age happiness])
; A Dog is a structure:
;   (make-dog Person String PositiveInteger H)

; For example:
;   (make-dog (make-person "Bruce" "Willis" #true) "BABY BRUCE" 6 94) represents Bruce Willis' dog BABY BRUCE.

; Add an interpretation to this data definition, too.

; A Weapon is one of: 
; — #false
; — Posn
; interpretation #false means the missile hasn't 
; been fired yet; a Posn means it is in flight

; For example:
; - #false represents the missile has not yet been fired
; - (make-posn 10 20) represents a missile in flight at x coordinate 10 and y coordinate 20 on the map
 
; The last definition is an unusual itemization,
; combining built-in data with a structure type.
; The next chapter deals with such definitions in depth. 