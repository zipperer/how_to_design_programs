;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise159) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

(define (col n img)
  (cond
    [(zero? n) empty-image]
    [(positive? n)
     (above img (col (sub1 n) img))]))

(define (row n img)
  (cond
    [(zero? n) empty-image]
    [(positive? n) (beside img (row (sub1 n) img))]))

(define LECTURE-HALL-SECTION-SIDE-LENGTH 10)
(define LECTURE-HALL-SECTION (square LECTURE-HALL-SECTION-SIDE-LENGTH "outline" "black"))
(define LECTURE-HALL-COLUMN-NUMBER-SECTIONS-PER-COLUMN 20)
(define LECTURE-HALL-COLUMN (col LECTURE-HALL-COLUMN-NUMBER-SECTIONS-PER-COLUMN LECTURE-HALL-SECTION))
(define LECTURE-HALL-NUMBER-COLUMNS 10)
(define LECTURE-HALL (row LECTURE-HALL-NUMBER-COLUMNS LECTURE-HALL-COLUMN))
(define RED-DOT (circle 4 "solid" "red"))

;(define LECTURE-HALL-WIDTH (* LECTURE-HALL-SECTION-SIDE-LENGTH LECTURE-HALL-NUMBER-COLUMNS))
(define LECTURE-HALL-WIDTH (image-width LECTURE-HALL))
;(define LECTURE-HALL-HEIGHT (* LECTURE-HALL-SECTION-SIDE-LENGTH LECTURE-HALL-COLUMN-NUMBER-SECTIONS-PER-COLUMN))
(define LECTURE-HALL-HEIGHT (image-height LECTURE-HALL))
  
; Exercise 159
; Turn the solution of exercise 153 into a world program.
; Its main function, dubbed riot, consumes how many balloons the students want to throw;
; its visualization shows one balloon dropping after another at a rate of one per second.
; The function produces the list of Posns where the balloons hit.

; Hints:
;(1) Here is one possible data representation:
 (define-struct pair [balloon# lob])

; A Pair is a structure (make-pair N List-of-posns)

; A List-of-posns is one of: 
; – '()
; – (cons Posn List-of-posns)
; interpretation:
;   (make-pair n lob) means n balloons 
;   must yet be thrown and added to lob
; (2) A big-bang expression is really just an expression.
; It is legitimate to nest it within another expression.

; (3) Recall that random creates random numbers. 

; RiotWorldState is a Pair

; RiotWorldState -> RiotWorldState
; if there are balloons remaining to be thrown,
; reduce by 1the number remaining to be thrown
; and assign the location-thrown-to randomly
(check-expect (tock (make-pair 0 '())) (make-pair 0 '()))
(check-random (tock (make-pair 1 '())) (make-pair 0
                                                  (cons (make-posn (random LECTURE-HALL-WIDTH)
                                                                   (random LECTURE-HALL-HEIGHT))
                                                        '())))
;(check-random (tock (make-pair 2
;                               (cons (make-posn (random LECTURE-HALL-WIDTH)
;                                                (random LECTURE-HALL-HEIGHT))
;                                     '())))
;                    (make-pair 1
;                               (cons (make-posn (random LECTURE-HALL-WIDTH)
;                                                (random LECTURE-HALL-HEIGHT))
;                                     (cons (make-posn (random LECTURE-HALL-WIDTH)
;                                                      (random LECTURE-HALL-HEIGHT))
;                                           '()))))

(define (tock riot-world-state)
  (cond
    [(zero? (pair-balloon# riot-world-state)) riot-world-state]
    [(positive? (pair-balloon# riot-world-state))
     (make-pair (sub1 (pair-balloon# riot-world-state))
                (cons (make-posn (random LECTURE-HALL-WIDTH)
                                 (random LECTURE-HALL-HEIGHT))
                      (pair-lob riot-world-state)))]))

; RiotWorldState -> Image
(define (render riot-world-state)
  (cond
    [(empty? (pair-lob riot-world-state)) LECTURE-HALL]
    [(cons? (pair-lob riot-world-state))
     (place-image RED-DOT
                  (posn-x (first (pair-lob riot-world-state)))
                  (posn-y (first (pair-lob riot-world-state)))
                  (render (make-pair (pair-balloon# riot-world-state)
                                     (rest (pair-lob riot-world-state)))))]))

(define CLOCK-TICKS-PER-SECOND 1)

(define (riot number-ballons-students-will-throw)
  (pair-lob ; "The function produces the list of Posns where the balloons hit. ...
            ; A big-bang expression is really just an expression. It is legitimate to nest it within another expression.
   (big-bang (make-pair number-ballons-students-will-throw '())
     [on-tick tock CLOCK-TICKS-PER-SECOND]
     [to-draw render])))

(riot 10)