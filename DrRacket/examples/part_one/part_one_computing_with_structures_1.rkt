;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname part_one_computing_with_structures_1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define example-posn (make-posn 7 0))

(define-struct entry (name phone email))
(define example-entry (make-entry "Al Abe" "666-7771" "lee@x.me"))

(check-expect (posn? example-posn) #true)
(check-expect (posn? 42) #false)
(check-expect (posn? #true) #false)
(check-expect (posn? (make-posn 3 4)) #true)

(check-expect (entry? example-entry) #true)
(check-expect (entry? 42) #false)
(check-expect (entry? #true) #false)