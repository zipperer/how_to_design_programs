;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define str "helloworld")
(define i 5)

(define (remove-character-at-index string index)
  (if (and (>= index 0)
           (< index (string-length string)))
      (string-append (substring str 0 index) (substring str (+ index 1)))
      string))

(remove-character-at-index str i)
"should be"
"helloorld"

(remove-character-at-index str 10)
"should be"
"helloworld"