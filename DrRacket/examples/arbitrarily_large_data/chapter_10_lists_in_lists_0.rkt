;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname chapter_10_lists_in_lists_0) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/batch-io)

; (read-file "ttt.txt")

; Exercise 171.
; You know what the data definition for List-of-strings looks like. Spell it out.

; Make sure that you can represent Piet Hein’s poem as an instance of the definition
;   where each line is represented as a string and another instance where each word is a string.

; Use read-lines and read-words to confirm your representation choices.

; Next develop the data definition for List-of-list-of-strings.
;   Again, represent Piet Hein’s poem as an instance of the definition
;   where each line is represented as a list of strings, one per word, and
;   the entire poem is a list of such line representations.

; You may use read-words/line to confirm your choice.


; ---

; A List-of-strings is one of:
; - '()
; - (cons String List-of-strings)
; For example:
; '()
; (cons "Hello" '())
; (cons "Blueberry" '())
; (cons "Blueberry" (cons "Hello" '()))

(define PIET-HEIN-POEM-AS-LIST-OF-STRINGS-ONE-STRING-PER-LINE (cons "TTT" (cons "" (cons "Put up in a place" '()))))
(define PIET-HEIN-POEM-AS-LIST-OF-STRINGS-ONE-STRING-PER-WORD (cons "TTT" (cons "Put" (cons "up" (cons "in" (cons "a" (cons "place" '())))))))

; (read-lines "ttt.txt")
; (read-words "ttt.txt")

; A List-of-list-of-strings is one of:
; - '()
; - (cons List-of-strings List-of-list-of-strings)
; For example:
; '()
; (cons (cons "Blueberry" (cons "Hello" '()))
;       '())
; (cons (cons "Blueberry" (cons "Hello" '()))
;       (cons "Blackberry" '())
;       '())

(define PIET-HEIN-POEM-AS-LIST-OF-LIST-OF-STRINGS (cons (cons "TTT" '())
                                                        (cons (cons "" '())
                                                              (cons (cons "Put" (cons "up" (cons "in" (cons "a" (cons "place" '())))))
                                                                    '()))))

(read-words/line "ttt.txt")
