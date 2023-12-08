#lang racket
(provide profit)

(define NUMBER-OF-ATTENDEES-AT-PRICE-FIVE-DOLLARS 120)

(define FIVE-DOLLARS 5.0)

(define NUMBER-OF-ATTENDEES-CHANGE-PER-TEN-CENT-CHANGE-IN-PRICE 15)

(define TEN-CENTS .10)

(define (attendees ticket-price)
  (- NUMBER-OF-ATTENDEES-AT-PRICE-FIVE-DOLLARS
     (* (- ticket-price FIVE-DOLLARS)
        (/ NUMBER-OF-ATTENDEES-CHANGE-PER-TEN-CENT-CHANGE-IN-PRICE TEN-CENTS))))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define FIXED-COST-TO-MOVIE-THEATER-PER-SHOW 0) ; changed from 180 to 0 for exercise29

(define VARIABLE-COST-TO-MOVIE-THEATER-PER-ATTENDEE 1.50) ; changed from 0.04 to 1.50 for exercise29

(define (cost ticket-price)
  (+ FIXED-COST-TO-MOVIE-THEATER-PER-SHOW
     (* VARIABLE-COST-TO-MOVIE-THEATER-PER-ATTENDEE (attendees ticket-price))))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))

(attendees 5.00)
"should be"
120

(attendees 4.90)
"should be"
135

(attendees 5.10)
"should be"
105