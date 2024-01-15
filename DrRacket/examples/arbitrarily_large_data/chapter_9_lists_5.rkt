;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname chapter_9_lists_5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;(check-expect (my-member? element input-list) #true)
(check-expect (my-member? 1 '()) #false)
(check-expect (my-member? 1 (cons 2 '())) #false)
(check-expect (my-member? 2 (cons 2 '())) #true)
(check-expect (my-member? 2 (cons 1 (cons 2 (cons 3 '())))) #true)

(define (my-member? element input-list)
  (cond
    [(empty? input-list) #false]
    [(cons? input-list)
     (cond
       [(equal? (first input-list) element) #true]
       [else (my-member? element (rest input-list))])]))


(check-expect (my-length '()) 0)
(check-expect (my-length (cons 'a '())) 1)
(check-expect (my-length (cons 'a (cons 'b '()))) 2)
(check-expect (my-length (cons 'a (cons 'b (cons 'c '())))) 3)
(define (my-length input-list)
  (cond
    [(empty? input-list) 0]
    [(cons? input-list)
     (+ 1 (length (rest input-list)))]))


(check-expect (my-remove 'a '()) '())
(check-expect (my-remove 'a (cons 'a '())) '())
(check-expect (my-remove 'a (cons 'a (cons 'a '()))) (cons 'a '()))
(check-expect (my-remove 'a (cons 'b (cons 'a '()))) (cons 'b '()))
(check-expect (my-remove 'a (cons 'b (cons 'a (cons 'c '())))) (cons 'b (cons 'c '())))
(define (my-remove element input-list)
  (cond
    [(empty? input-list) '()]
    [(cons? input-list)
     (cond
       [(equal? element (first input-list))
        (rest input-list)]
       [else
        (cons (first input-list) (my-remove element (rest input-list)))])]))

(check-expect (my-remove-all 'a '()) '())
(check-expect (my-remove-all 'a (cons 'a '())) '())
(check-expect (my-remove-all 'a (cons 'a (cons 'a '()))) '())
(check-expect (my-remove-all 'a (cons 'b (cons 'a '()))) (cons 'b '()))
(check-expect (my-remove-all 'a (cons 'b (cons 'a (cons 'c '())))) (cons 'b (cons 'c '())))
(check-expect (my-remove-all 'a (cons 'b (cons 'a (cons 'c (cons 'a '()))))) (cons 'b (cons 'c '())))
(define (my-remove-all element input-list)
  (cond
    [(empty? input-list) '()]
    [(cons? input-list)
     (cond
       [(equal? element (first input-list))
        (my-remove-all element (rest input-list))]
       [else
        (cons (first input-list) (my-remove-all element (rest input-list)))])]))

(define (add-to-end element input-list)
  (cond
    [(empty? input-list) (cons element '())]
    [(cons? input-list)
     (cons (first input-list) (add-to-end element (rest input-list)))]))

(check-expect (my-reverse '()) '())
(check-expect (my-reverse (cons 'a '())) (cons 'a '()))
(check-expect (my-reverse (cons 'a (cons 'b '()))) (cons 'b (cons 'a '())))
(check-expect (my-reverse (cons 'a (cons 'b (cons 'c '())))) (cons 'c (cons 'b (cons 'a '()))))
(define (my-reverse input-list)
  (cond
    [(empty? input-list) '()]
    [(cons? input-list)
     (add-to-end (first input-list) (my-reverse (rest input-list)))]))

(check-expect (my-reverse-extra-list '()) '())
(check-expect (my-reverse-extra-list (cons 'a '())) (cons 'a '()))
(check-expect (my-reverse-extra-list (cons 'a (cons 'b '()))) (cons 'b (cons 'a '())))
(check-expect (my-reverse-extra-list (cons 'a (cons 'b (cons 'c '())))) (cons 'c (cons 'b (cons 'a '()))))
(define (my-reverse-extra-list input-list)
  (my-reverse-extra-list-int input-list '()))

(define (my-reverse-extra-list-int input-list extra-list)
  (cond
    [(empty? input-list) extra-list]
    [(cons? input-list)
     (my-reverse-extra-list-int (rest input-list) (cons (first input-list) extra-list))]))
