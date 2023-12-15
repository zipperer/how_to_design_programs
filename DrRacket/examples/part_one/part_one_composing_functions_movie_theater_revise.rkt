;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname part_one_composing_functions_movie_theater) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define (profit-for-movie-theater-at-price-per-ticket price-per-ticket)
  (- (revenue-for-movie-theater-at-price-per-ticket price-per-ticket)
     (cost-for-movie-theater-at-price-per-ticket price-per-ticket)))

(define (revenue-for-movie-theater-at-price-per-ticket price-per-ticket)
  (* price-per-ticket
     (number-of-attendees-at-price-per-ticket price-per-ticket)))

(define NUMBER-OF-ATTENDEES-AT-PRICE-PER-TICKET-FIVE-DOLLARS 120)

(define (number-of-attendees-at-price-per-ticket price-per-ticket)
  (+ NUMBER-OF-ATTENDEES-AT-PRICE-PER-TICKET-FIVE-DOLLARS 
     (number-of-attendees-change-due-to-distance-from-five-dollars price-per-ticket)))

(define NUMBER-OF-ATTENDEES-CHANGE-FOR-EACH-CHANGE-IN-TEN-CENTS 15)

(define (number-of-attendees-change-due-to-distance-from-five-dollars price-per-ticket)
  (* NUMBER-OF-ATTENDEES-CHANGE-FOR-EACH-CHANGE-IN-TEN-CENTS 
     (number-of-ten-cent-differences-from-five-dollars price-per-ticket)))

(define (number-of-ten-cent-differences-from-five-dollars price-per-ticket)
  (number-of-ten-cent-differences-from-zero (- 5 price)))

(define (number-of-ten-cent-differences-from-zero amount)
  ; if the distance is .10, then the number of ten cent differences is 1
  ; if the distance is -.10 then the number of ten cent differences is -1
  ; distance .20 then number of ten cent differences is 2
  ; so, to get number of ten cent differences from amount, multiply amount by 10
  (* 10 amount))

; 120 people at 5.00
; 15 people difference for each difference in .10

(number-of-attendees-at-show 5.00)
"should be"
120

(number-of-attendees-at-show 4.90)
"should be"
135

(number-of-attendees-at-show 5.10)
"should be"
105

(define FIXED-COST-PER-SHOW-FOR-MOVIE-THEATER 180)

(define (cost-for-movie-theater-at-price-per-ticket price-per-ticket)
  (+ FIXED-COST-PER-SHOW-FOR-MOVIE-THEATER
     (variable-cost-for-movie-theater-at-price-per-ticket price-per-ticket)))

(define VARIABLE-COST-TO-MOVIE-THEATER-PER-ATTENDEE .04)

(define (variable-cost-for-movie-theater-at-price-per-ticket price-per-ticket)
  (+ (variable-cost-for-movie-theater-due-to-attendees-at-price-per-ticket price-per-ticket)
     ; other variable costs
     ))

(define (variable-cost-for-movie-theater-due-to-attendees-at-price-per-ticket price-per-ticket)
  (* VARIABLE-COST-TO-MOVIE-THEATER-PER-ATTENDEE
     (number-of-attendees-at-price-per-ticket price-per-ticket)))
