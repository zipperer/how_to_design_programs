;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname part_one_computing_with_structures_0) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct entry [name phone email])

(define example-entry-al (make-entry "Al Abe"
                                  "666-7771"
                                  "lee@x.me"))

(define example-entry-tara (make-entry "Tara Harp"
                                       "666-7770"
                                       "th@smlu.edu"))

(check-expect (entry-name example-entry-al) "Al Abe")
(check-error (entry-name (make-posn 42 5)) "entry-name: expects an entry, given (make-posn 42 5)")
