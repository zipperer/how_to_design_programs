;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define str "helloworld")
(define i 5)

(define (add-underscore-to-string-at-index string index)
  (string-append (substring str 0 index) "_" (substring str index)))

(add-underscore-to-string-at-index str i)
"should be"
"hello_world"