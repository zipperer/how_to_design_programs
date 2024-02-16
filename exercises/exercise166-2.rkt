;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise166-2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct employee-information [id name])
; An EmployeeInformation is a structure:
;   (make-employee-information Number String)
; interpretation
;   (make-employee-information number name)
;   represents an employee with employee id number and name name
; For example,
;   (make-employee-information 1 "Robby")
;   (make-employee-information 2 "Matthew")
;   (make-employee-information 3 "Julia")

(define-struct work [employee rate hours])
; A (piece of) Work is a structure:
;   (make-work EmployeeInformation Number Number)
; interpretation:
;   (make-work info r h) combines the employee information info
;   with the pay rate r and the number of hours h

; List-of-works is one of:
; - '()
; - (cons Work List-of-works)
; interpretation:
;   an instance of List-of-works represents the
;   hours worked for a number of employees

; Here are three elements of List-of-works
; '()
; (cons (make-work (make-employee-information 1 "Robby") 11.95 39) '())
; (cons (make-work (make-employee-information 2 "Matthew") 12.95 45)
;       (cons (make-work (make-employee-information 1 "Robby") 11.95 39) '())

; '() is a List-of-works b/c it satisfies the first clause in the definition.

; (cons (make-work (make-employee-information 1 "Robby") 11.95 39) '()) matches the second clause in the definition
; (cons work List-of-works)
; with:
; (make-work (make-employee-information 1 "Robby") 11.95 39) as the work
; '() as the List-of-Works

; (cons (make-work (make-employee-information 2 "Matthew") 12.95 45)
;       (cons (make-work (make-employee-information 1 "Robby") 11.95 39) '())
; matches the second clause in the definition
; (cons work List-of-works)
; with:
; (make-work (make-employee-information 2 "Matthew") 12.95 45) as the work
; (cons (make-work (make-employee-information 1 "Robby") 11.95 39) '()) as the List-of-works

; (cons (make-work (make-employee-information 3 "Julia") 11.95 45) '())
; (cons (make-work (make-employee-information 3 "Julia") 11.95 45)
;       (cons (make-work (make-employee-information 2 "Matthew") 12.95 45)
;             (cons (make-work (make-employee-information 1 "Robby") 11.95 39) '())))


(define-struct paycheck [employee-info amount])
; An EmployeePaycheck is a structure:
;   (make-paycheck EmployeeInformation Number)
; interpretation:
;   (make-paycheck info a)
;   represents a paycheck for employee with employee information info for amount a
; For example,
;   (make-paycheck (make-employee-information 1 "Robby") 100) is a paycheck for employee named Robby with id 1 for 100 units of currency.
;   (make-paycheck (make-employee-information 2 "Matthew") 101) is a paycheck for employee named Matthew with id 2 for 101 units of currency.

; List-of-works -> List-of-paychecks
; computes list of paychecks for given list of work records
(check-expect (wage*.v4 '()) '())
(check-expect (wage*.v4 (cons (make-work (make-employee-information 1 "Robby") 11.95 39) '()))
              (cons (make-paycheck (make-employee-information 1 "Robby") (* 11.95 39)) '()))
(check-expect (wage*.v4 (cons (make-work (make-employee-information 2 "Matthew") 12.95 45)
                              (cons (make-work (make-employee-information 1 "Robby") 11.95 39) '())))
              (cons (make-paycheck (make-employee-information 2 "Matthew") (* 12.95 45))
                    (cons (make-paycheck (make-employee-information 1 "Robby") (* 11.95 39)) '())))
(check-expect (wage*.v4 (cons (make-work (make-employee-information 3 "Julia") 11.95 45) '()))
              (cons (make-paycheck (make-employee-information 3 "Julia") (* 11.95 45)) '()))
(check-expect (wage*.v4 (cons (make-work (make-employee-information 3 "Julia") 11.95 45)
                              (cons (make-work (make-employee-information 2 "Matthew") 12.95 45)
                                    (cons (make-work (make-employee-information 1 "Robby") 11.95 39) '()))))
              (cons (make-paycheck (make-employee-information 3 "Julia") (* 11.95 45))
                    (cons (make-paycheck (make-employee-information  2 "Matthew") (* 12.95 45))
                          (cons (make-paycheck (make-employee-information 1 "Robby") (* 11.95 39)) '()))))

(define (wage*.v4 list-of-work-records)
  (cond
    [(empty? list-of-work-records) '()]
    [(cons? list-of-work-records)
     (cons (make-paycheck-for-work-record (first list-of-work-records))
           (wage*.v4 (rest list-of-work-records)))]))

(define (make-paycheck-for-work-record work-record)
  (make-paycheck (work-employee work-record)
                 (work-record-paycheck-amount work-record)))

(define (work-record-paycheck-amount work-record)
  (* (work-rate work-record)
     (work-hours work-record)))