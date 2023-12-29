;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise78) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; Exercise 78
; Provide a structure type and a data definition for representing three-letter words.
; A word consists of lowercase letters, represented with the 1Strings "a" through "z"
; plus #false.
; Note:
; This exercise is a part of the design of a hangman game; see exercise 396.

; A 1StringOrFalse is one of:
; - 1String
; - #false
; e.g. "a" is a 1StringOrFalse since "a" is a 1String
;      #false is a 1StringOrFalse since #false is #false
;      #true is not a 1StringOrFalse since #true is not a 1String and #true is not #false.

(define-struct three-letter-word [first-letter second-letter third-letter])
; A ThreeLetterWord is a structure:
;   (make-three-letter-word 1StringOrFalse 1StringOrFalse 1StringOrFalse)
; interpretation:
;   (make-three-letter-word f s t) represents the three letter word with
;     first letter f, second letter s, and third letter t.
;   e.g. (make-three-letter-word "a" "i" "r") represents the word "air".
;   e.g. (make-three-letter-word "f" "i" "g") represents the word "fig".
;   f, s, and t are all in Union[[a-z],#false]. That is, f, s, and t are
;   each (a) a lowercase letter between a and z or (b) #false.