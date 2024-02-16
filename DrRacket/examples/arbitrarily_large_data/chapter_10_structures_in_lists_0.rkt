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

; Exercise 166.
; The wage*.v2 function consumes a list of work records and produces a list of numbers.
; Of course, functions may also produce lists of structures.

; Develop a data representation for paychecks.
; Assume that a paycheck contains two distinctive pieces of information: the employee’s name and an amount.
; Then design the function wage*.v3. It consumes a list of work records and computes a list of paychecks from it, one per record.

; In reality, a paycheck also contains an employee number.
; Develop a data representation for employee information and change the data definition for work records
; so that it uses employee information and not just a string for the employee’s name.
; Also change your data representation of paychecks so that it contains an employee’s name and number, too.
; Finally, design wage*.v4, a function that maps lists of revised work records to lists of revised paychecks.

(define-struct paycheck [employee-name amount])
; An EmployeePaycheck is a structure:
;   (make-paycheck String Number)
; interpretation:
;   (make-paycheck n a)
;   represents a paycheck for employee with name n for amount a
; For example,
;   (make-paycheck "Robby" 100) is a paycheck for employee named Robby for 100 units of currency.
;   (make-paycheck "Matthew" 101) is a paycheck for employee named Matthew for 101 units of currency.

; List-of-works -> List-of-paychecks
; computes list of paychecks from given list of work records
(check-expect (wage*.v3 '()) '())
(check-expect (wage*.v3 (cons (make-work "Robby" 11.95 39) '()))
              (cons (make-paycheck "Robby" (* 11.95 39)) '()))
(check-expect (wage*.v3 (cons (make-work "Matthew" 12.95 45)
                              (cons (make-work "Robby" 11.95 39) '())))
              (cons (make-paycheck "Matthew" (* 12.95 45))
                    (cons (make-paycheck "Robby" (* 11.95 39)) '())))
(check-expect (wage*.v3 (cons (make-work "Julia" 11.95 45) '()))
              (cons (make-paycheck "Julia" (* 11.95 45)) '()))
(check-expect (wage*.v3 (cons (make-work "Julia" 11.95 45)
                              (cons (make-work "Matthew" 12.95 45)
                                    (cons (make-work "Robby" 11.95 39) '()))))
              (cons (make-paycheck "Julia" (* 11.95 45))
                    (cons (make-paycheck "Matthew" (* 12.95 45))
                          (cons (make-paycheck "Robby" (* 11.95 39)) '()))))
(define (wage*.v3 list-of-works)
  (cond
    [(empty? list-of-works) '()]
    [(cons? list-of-works)
     (cons (make-paycheck-for-work-record (first list-of-works))
           (wage*.v3 (rest list-of-works)))]))

; Work -> EmployeePaycheck
; computes paycheck given work record
(check-expect (make-paycheck-for-work-record (make-work "Robby" 11.95 39)) (make-paycheck "Robby" (* 11.95 39)))
(check-expect (make-paycheck-for-work-record (make-work "Matthew" 12.95 45)) (make-paycheck "Matthew" (* 12.95 45)))
(check-expect (make-paycheck-for-work-record (make-work "Julia" 11.95 45)) (make-paycheck "Julia" (* 11.95 45)))
(define (make-paycheck-for-work-record work-record)
  (make-paycheck (work-employee work-record)
                 (* (work-rate work-record)
                    (work-hours work-record))))