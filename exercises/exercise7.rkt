;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise7) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define sunny #true)
(define friday #false)

(define (good-day-to-go-to-mall? sunny friday)
  (or (not sunny)
      friday))

(good-day-to-go-to-mall? sunny friday)
"should be"
#false