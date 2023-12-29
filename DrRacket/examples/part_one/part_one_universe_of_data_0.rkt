;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname part_one_universe_of_data_0) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct ball [location velocity])

; observe lack of restrictions on type of input values:

; > (make-ball 1 2)
; (make-ball 1 2)
; > (make-ball (make-posn #true #true) 2)
; (make-ball (make-posn #true #true) 2)