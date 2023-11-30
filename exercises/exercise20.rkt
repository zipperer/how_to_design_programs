;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise20) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define (string-delete-index-valid str i)
  (and (<= i (- (string-length str) 1)) ; 1 less than string-length b/c substring requires it be less than string-length
       (>= i 0)))

(define (string-delete str i)
  (cond
    [(string-delete-index-valid str i)
     (string-append
      (substring str 0 i)
      (substring str (+ i 1)))]
    [else str]))

(string-delete "hey" 0)
"should be"
"ey"


(string-delete "hey" 1)
"should be"
"hy"

(string-delete "hey" 2)
"should be"
"he"

(string-delete "hey" 3)
"should be"
"hey"

(string-delete "hey" -1)
"should be"
"hey"