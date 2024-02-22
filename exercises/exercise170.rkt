;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise170) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 170.

; Here is one way to represent a phone number:
(define-struct phone [area switch four])
; A Phone is a structure: 
;   (make-phone Three Three Four)
; A Three is a Number between 100 and 999. 
; A Four is a Number between 1000 and 9999. 

; Design the function replace.
;   It consumes and produces a list of Phones.
;   It replaces all occurrence of area code 713 with 281.

; List-of-phone is one of:
; - '()
; - (cons Phone List-of-phone)
; For example:
; '()
; (cons (make-phone 713 222 9832) '())
; (cons (make-phone 713 222 9832) (cons (make-phone 891 100 2300) '()))
; (cons (make-phone 281 545 3421) (cons (make-phone 713 222 9832) (cons (make-phone 891 100 2300) '())))

(define AREA-CODE-TO-REPLACE 713)
(define AREA-CODE-REPLACEMENT-VALUE 281)

; List-of-phone -> List-of-phone
; returns list of Phone from input, replacing each occurrence of area code AREA-CODE-TO-REPLACE with area code AREA-CODE-REPLACEMENT-VALUE
; header
;(define (replace list-of-phone)
;  '())
; template -- given list
;(define (replace list-of-phone)
;  (cond
;    [(empty? list-of-phone) ...]
;    [(cons? list-of-phone)
;     (... (first list-of-phone) ... ; instance of Phone
;      ... (replace (rest list-of-phone)) ...)])) ; List-of-phone after replacing each occurrence of area code AREA-CODE-TO-REPLACE with area code AREA-CODE-REPLACEMENT-VALUE
; template -- given list of instances of structure
;(define (replace list-of-phone)
;  (cond
;    [(empty? list-of-phone) ...]
;    [(cons? list-of-phone)
;     (... (process-phone (first list-of-phone)) ...
;      ... (replace (rest list-of-phone)) ...)]))

(check-expect (replace '()) '())
(check-expect (replace (cons (make-phone 713 222 9832) '())) (cons (make-phone 281 222 9832) '()))
(check-expect (replace (cons (make-phone 713 222 9832) (cons (make-phone 891 100 2300) '())))
              (cons (make-phone 281 222 9832) (cons (make-phone 891 100 2300) '())))

(check-expect (replace (cons (make-phone 281 545 3421) (cons (make-phone 713 222 9832) (cons (make-phone 891 100 2300) '()))))
              (cons (make-phone 281 545 3421) (cons (make-phone 281 222 9832) (cons (make-phone 891 100 2300) '()))))
(define (replace list-of-phone)
  (cond
    [(empty? list-of-phone) '()]
    [(cons? list-of-phone)
     (cons (replace-area-code-if-area-code-matches-value-to-replace (first list-of-phone))
           (replace (rest list-of-phone)))]))

; Phone -> Phone
; replaces area code AREA-CODE-TO-REPLACE with AREA-CODE-REPLACEMENT-VALUE
(check-expect (replace-area-code-if-area-code-matches-value-to-replace (make-phone 713 222 9832)) (make-phone 281 222 9832))
(check-expect (replace-area-code-if-area-code-matches-value-to-replace (make-phone 281 222 9832)) (make-phone 281 222 9832))
(check-expect (replace-area-code-if-area-code-matches-value-to-replace (make-phone 891 100 2300)) (make-phone 891 100 2300))
(define (replace-area-code-if-area-code-matches-value-to-replace phone)
  (cond
    [(= (phone-area phone) AREA-CODE-TO-REPLACE)
     (make-phone AREA-CODE-REPLACEMENT-VALUE (phone-switch phone) (phone-four phone))]
    [else phone]))