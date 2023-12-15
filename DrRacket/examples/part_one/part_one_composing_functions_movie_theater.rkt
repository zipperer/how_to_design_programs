;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname part_one_composing_functions_movie_theater) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define NUMBER-OF-ATTENDEES-WHEN-PRICE-IS-FIVE-DOLLARS 120)

(define (number-of-attendees-at-show price)
  (+ NUMBER-OF-ATTENDEES-WHEN-PRICE-IS-FIVE-DOLLARS (number-of-attendees-difference-due-to-distance-from-five-dollars price)))

(define NUMBER-OF-ATTENDEES-CHANGE-FOR-EACH-CHANGE-IN-TEN-CENTS 15)

(define (number-of-attendees-difference-due-to-distance-from-five-dollars price)
  (* NUMBER-OF-ATTENDEES-CHANGE-FOR-EACH-CHANGE-IN-TEN-CENTS (number-of-ten-cent-differences-from-five-dollars price)))

(define (number-of-ten-cent-differences-from-five-dollars price)
  (number-of-ten-cent-differences-from-zero (- 5 price)))

(define (number-of-ten-cent-differences-from-zero amount)
  ; if it is .10 then it is 1
  ; if it is -.10 then it is -1
  ; if it is .20 then it is 2
  ; so, multiply by 10
  (* 10 amount))


(number-of-attendees-at-show 5.00)
"should be"
120

(number-of-attendees-at-show 4.90)
"should be"
135

(number-of-attendees-at-show 5.10)
"should be"
105

; 120 people at 5.00
; 15 people difference for each difference in .10


; (- (* price-per-ticket (+ 120 (* 15 (* 10 (- 5 price-per-ticket)))))
;    (+ 180 (* .04 (+ 120 (* 15 (* 10 (- 5 price-per-ticket)))))))

; (x * (120 + (15 * (10 * (5 - x))))) - (180 + (.04 * (120 + (15 * (10 * (5 - x))))))
; can do derivative here to get function value is at max at x ~= 3
; alternatively, wolfram alpha:
; plot (x * (120 + (15 * (10 * (5 - x))))) - (180 + (.04 * (120 + (15 * (10 * (5 - x)))))) from x = 0 to x = 6

(define (profit-for-movie-theater-at-price-per-ticket price-per-ticket)
  (- (revenue-for-movie-theater-at-price-per-ticket price-per-ticket)
     (cost-for-movie-theater-at-price-per-ticket price-per-ticket)))

(define (revenue-for-movie-theater-at-price-per-ticket price-per-ticket)
  (* price-per-ticket
     (number-of-attendees-at-price-per-ticket price-per-ticket)))

(define (number-of-attendees-at-price-per-ticket price)
  (number-of-attendees-at-show price)) ; todo: instead of this direct rewrite, rename number-of-attendees-at-show to number-of-attendees-at-price-per-ticket

(define FIXED-COST-PER-SHOW-FOR-MOVIE-THEATER 180)

(define (cost-for-movie-theater-at-price-per-ticket price-per-ticket)
  (+ FIXED-COST-PER-SHOW-FOR-MOVIE-THEATER
     (variable-cost-for-movie-theater-at-price-per-ticket price-per-ticket)))

(define VARIABLE-COST-TO-MOVIE-THEATER-PER-ATTENDEE .04)

(define (variable-cost-for-movie-theater-at-price-per-ticket price-per-ticket)
  (* VARIABLE-COST-TO-MOVIE-THEATER-PER-ATTENDEE
     (number-of-attendees-at-price-per-ticket price-per-ticket)))

; first version
(define (profit-for-movie-theater revenue-for-movie-theater cost-for-movie-theater)
  (- revenue-for-movie-theater cost-for-movie-theater))

(define (revenue-for-show number-of-attendees-at-show charge-per-ticket-for-show)
  (* number-of-attendees-at-show charge-per-ticket-for-show))
; end first version

; first version
;(define FIXED-COST-PER-SHOW-FOR-MOVIE-THEATER 180)

(define (cost-for-movie-theater-per-show number-of-attendees)
  (+ FIXED-COST-PER-SHOW-FOR-MOVIE-THEATER
     (variable-cost-for-movie-theater-due-to-attendees number-of-attendees)))

(define (variable-cost-for-movie-theater-due-to-attendees number-of-attendees)
  1) ; todo

; end first version

;(profit-for-movie-theater-at-price-per-ticket 0) -- This is incorrect. When I wrote this, I was thinking 0 dollars per ticket implies
;"should be"                                      -- (a) theater will pay fixed cost and (b) theater will not pay variable cost and (c)
;-180                                             -- theater will not make any money
;                                                 -- I claim (a) and (c) are true. But, (b) is not. At 0 dollars per ticket, many attendees.