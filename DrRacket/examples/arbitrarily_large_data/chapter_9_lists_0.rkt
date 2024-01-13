;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname chapter_9_lists_0) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; A List-of-temperatures is one of: 
; – '()
; – (cons CTemperature List-of-temperatures)
 
(define ABSOLUTE0 -272)
; A CTemperature is a Number greater than ABSOLUTE0.

; List-of-temperatures -> Number
; return average of temperatures in input list-of-temperatures
(check-expect (average-temperature (cons 50 '())) 50)
(check-expect (average-temperature (cons 100 (cons 50 '()))) 75)
(check-expect (average-temperature (cons 75 (cons 100 (cons 50 '())))) 75)
(check-expect (average-temperature (cons 1 (cons 2 (cons 3 '())))) 2)
#|
(define (average-temperature list-of-temperatures)
  (cond
    [(empty? (rest list-of-temperatures))
     (first list-of-temperatures)]
    [(cons? list-of-temperatures)
     ...]))
|#
(define (average-temperature list-of-temperatures)
  (/ (sum list-of-temperatures)
     (how-many list-of-temperatures)))

(check-expect (sum (cons 50 '())) 50)
(check-expect (sum (cons 100 (cons 50 '()))) 150)
(check-expect (sum (cons 75 (cons 100 (cons 50 '())))) 225)
(check-expect (sum (cons 1 (cons 2 (cons 3 '())))) 6)
(define (sum list-of-amounts)
  (cond
    [(empty? list-of-amounts) 0]
    [(cons? list-of-amounts)
     (+ (first list-of-amounts)
     (sum (rest list-of-amounts)))]))

(check-expect (how-many (cons 50 '())) 1)
(check-expect (how-many (cons 100 (cons 50 '()))) 2)
(check-expect (how-many (cons 75 (cons 100 (cons 50 '())))) 3)
(check-expect (how-many (cons 1 (cons 2 (cons 3 '())))) 3)
(define (how-many alos)
  (cond
    [(empty? alos) 0]
    [else
     (add1 (how-many (rest alos)))]))

; Exercise 143
; Determine how average behaves in DrRacket when applied to the empty list.
#|
> (average-temperature '())
/: division by zero
|#
; Then design checked-average, a function that produces an informative error message when it is applied to '().

; List-of-temperatures -> Union[Number, Error]
; computes average for non-empty lists
; for empty lists, returns error
(check-error (checked-average '()))
(check-expect (checked-average (cons 50 '())) 50)
(check-expect (checked-average (cons 100 (cons 50 '()))) 75)
(check-expect (checked-average (cons 75 (cons 100 (cons 50 '())))) 75)
(check-expect (checked-average (cons 1 (cons 2 (cons 3 '())))) 2)             
(define (checked-average list-of-temperatures)
  (if (empty? list-of-temperatures)
      (error "Average expects a non-empty list")
      (average-temperature list-of-temperatures)))


; An NEList-of-temperatures is one of: 
; – ???
; – (cons CTemperature NEList-of-temperatures)

; An NEList-of-temperatures is one of: 
; – (cons CTemperature '())
; – (cons CTemperature NEList-of-temperatures)
; interpretation non-empty lists of Celsius temperatures
; Examples:
; (cons 0 '()) is an NEList-of-temperatures
; '() is NOT an NEList-of-temperatures
; (cons 1 (cons 0 '())) is an NEList-of-temperatures

; NEList-of-temperatures -> Number
; computes the average temperature 
 
(check-expect (average (cons 1 (cons 2 (cons 3 '()))))
              2)
 
(define (average ne-l)
  (/ (sum ne-l)
     (how-many ne-l)))

; Exercise 144
; Will sum and how-many work for NEList-of-temperatures even though they are
; designed for inputs from List-of-temperatures?
; If you think they don’t work, provide counter-examples.
; If you think they would, explain why.
; claim: sum and how-many will work for NEList-of-temperatures even though
; they are designed for inputs from List-of-temperatures.
;
; Form of argument: sum and how-many work for List-of-temperatures.
;                   Every NEList-of-temperatures is a List-of-temperatures.
;                   So, sum and how-many apply to a set of values, and
;                   we have a subset of those values.
;                   Since sum and how-many apply to every value in the set,
;                   sum and how-many apply to very value in the subset.
;
; argument:
; recall
; A List-of-temperatures is one of: 
; – '()
; – (cons CTemperature List-of-temperatures)
; and
; ; An NEList-of-temperatures is one of: 
; – (cons CTemperature '())
; – (cons CTemperature NEList-of-temperatures)
;
; lemma: an element of NEList-of-temperatures is an element of List-of-temperatures.
; argument:
; Take arbitrary element, nelot, of NEList-of-temperatures.
; nelot has form either (cons CTemperature '()) or (cons CTemperature NEList-of-temperatures).
; a. Suppose nelot has form (cons CTemperature '()).
;    Then nelot is a List-of-temperatures; for:
;    a1. '() is a List-of-temperatures
;    a2. (cons CTemperature '()) is a List-of-temperatures for any CTemperature -- from a1 and second clause of List-of-temperatures.
;    a3. since nelot has form (cons CTemperature '()) and (cons CTemperature '()) is a
;      List-of-temperatures for any CTemperature, nelot is a List-of-temperatures.
; b. Suppose nelot has form (cons CTemperature NEList-of-temperatures) [i.e. nelot := (cons ct nelot0)]
;    Then nelot is a List-of-temperatures; for:
;    b1. nelot was built by cons from (cons CTemperature '()). ; ignore
;    b2. we showed above that (cons CTemperature '()) is a List-of-temperatures. This is the base case for an induction.
;    b3. Suppose that nelot0 is a List-of-temperatures. Show that nelot (:= (cons ct nelot0)) is a List-of-temperatures
;        b11. Second clause of List-of-temperatures says (cons CTemperature List-of-temperatures) is a List-of-temperatures.
;        b12. We assume in induction hypothesis that nelot0 is a List-of-temperatures.
;        b13. So, (cons ct nelot0) has form (cons CTemperature List-of-temperatures).
;        b14. Since nelot := (cons ct nelot0) and (cons ct nelot0) has form (cons CTemperature List-of-temperatures),
;             nelot has form (cons CTemperature List-of-temperatures). So, nelot is a List-of-temperatures.