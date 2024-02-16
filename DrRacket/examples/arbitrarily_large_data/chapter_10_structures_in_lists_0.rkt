;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname chapter_10_structures_in_lists_0) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct work [employee rate hours])
; A (piece of) Work is a structure:
;   (make-work String Number Number)
; interpretation:
;   (make-work n r h) combines the name n
;   with the pay rate r and the number of hours h

; List-of-works is one of:
; - '()
; - (cons Work List-of-works)
; interpretation:
;   an instance of List-of-works represents the
;   hours worked for a number of employees

; Here are three elements of List-of-works
; '()
; (cons (make-work "Robby" 11.95 39) '())
; (cons (make-work "Matthew" 12.95 45)
;       (cons (make-work "Robby" 11.95 39) '())

; '() is a List-of-works b/c it satisfies the first clause in the definition.

; (cons (make-work "Robby" 11.95 39) '()) matches the second clause in the definition
; (cons work List-of-works)
; with:
; (make-work "Robby" 11.95 39) as the work
; '() as the List-of-Works

; (cons (make-work "Matthew" 12.95 45)
;       (cons (make-work "Robby" 11.95 39) '())
; matches the second clause in the definition
; (cons work List-of-works)
; with:
; (make-work "Matthew" 12.95 45) as the work
; (cons (make-work "Robby" 11.95 39) '()) as the List-of-works

; (cons (make-work "Julia" 11.95 45) '())
; (cons (make-work "Julia" 11.95 45)
;       (cons (make-work "Matthew" 12.95 45)
;             (cons (make-work "Robby" 11.95 39) '())))


; List-of-works -> List-of-numbers
; computes the weekly wages for the given records
(check-expect (wage*.v2 '())
              '())
(check-expect (wage*.v2 (cons (make-work "Robby" 11.95 39) '()))
              (cons (* 11.95 39) '()))
(check-expect (wage*.v2 (cons (make-work "Matthew" 12.95 45)
                              (cons (make-work "Robby" 11.95 39) '())))
              (cons (* 12.95 45)
                    (cons (* 11.95 39) '())))
(check-expect (wage*.v2 (cons (make-work "Julia" 11.95 45) '()))
              (cons (* 11.95 45) '()))
(check-expect (wage*.v2 (cons (make-work "Julia" 11.95 45)
                              (cons (make-work "Matthew" 12.95 45)
                                    (cons (make-work "Robby" 11.95 39) '()))))
              (cons (* 11.95 45)
                    (cons (* 12.95 45)
                          (cons (* 11.95 39) '()))))

(define (wage*.v2-az list-of-works)
  (cond
    [(empty? list-of-works) '()]
    [(cons? list-of-works)
     (cons (* (work-rate (first list-of-works))
              (work-hours (first list-of-works)))
           (wage*.v2-az (rest list-of-works)))]))


; header
; (define (wage*.v2 list-of-works)
;  '())

; template 1
; (define (wage*.v2 list-of-works)
; (cond
;   [(empty? list-of-works ...]
;   [(cons? list-of-works)
;   (... (first list-of-works) ...
;    ... (wage*.v2 (rest list-of-works)) ...)]))

; template 2
; (define (wage*.v2 list-of-works)
; (cond
;   [(empty? list-of-works ...]
;   [(cons? list-of-works)
;   (... (first list-of-works) ...
;    ... (work-employee (first list-of-works)) ...
;    ... (work-rate (first list-of-works)) ...
;    ... (work-hours (first list-of-works)) ...
;    ... (wage*.v2 (rest list-of-works)) ...)]))

; template 3
; List-of-works -> List-of-numbers
; (define (wage*.v2 list-of-works)
;   (cond
;     [(empty? list-of-works) ...]
;     [(cons? list-of-works)
;       (... (for-work (first list-of-works))
;        ... (wage*.v2 (rest list-of-works)) ...)]))
;
; Work -> ???
; a template for processing elements of Work
; (define (for-work work)
;   (... (work-employee work) ...
;    ... (work-rate work) ...
;    ... (work-hours work) ...))
;
; Work -> Number
; computes the wage for the given work record w
; (define (wage.v2 w)
; 0)

(define (wage.v2 work)
  (* (work-rate work)
     (work-hours work)))

(define (wage*.v2 list-of-works)
  (cond
    [(empty? list-of-works) '()]
    [(cons? list-of-works)
     (cons (wage.v2 (first list-of-works))
           (wage*.v2 (rest list-of-works)))]))