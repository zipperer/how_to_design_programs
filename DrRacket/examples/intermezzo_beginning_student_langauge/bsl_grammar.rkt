;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname bsl_grammar) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; Exercise 116
; Take a look at the following sentences:
; 1. x
; 2. (= y z)
; 3. (= (= y z) 0)

; Explain why they are syntactically legal expressions.

; x is a variable. Since x is a sequence of characters not including space or one of ",'`()[]{}|;#
; From the `expr = variable | value | ...` clause,
; a variable is an expr

; y is a variable.
; z is a variable.
; From the `expr = variable | value | ...` clause,
; a variable is an expr

; = is a primitive
; From the `expr = variable | value | (primitive expr expr...) ...` clause:
; (= y z) fits the shape of (primitive expr expr)
; So, (= y z) is an expr.

; 0 is a value, since 0 is a number. Since it is a value, 0 is an expr
; according to `expr = variable | value | ...`.

; (= (= y z) 0) fits the shape of (primitive expr expr), with
; first expr: (= y z)
; second expr: 0


; Exercise 117
; Consider the following sentences:
; 1. (3 + 4)
; 2. number?
; 3. (x)

; Explain why they are syntactically illegal.

; (3 + 4) does not match the def clause b/c 3 != def
; (3 + 4) does not match any of the expr cases b/c
; 3 is not a primitive (since 3 is a value, and values and primitives are disjoint)
; 3 is not a variable (since 3 is a value, and values and variables are disjoint)
; 3 does not match cond.
; So, (3 + 4) does not match any of the legal forms.

; number? is a primitive. It is a name to which BSL assigns meaning.
; Primitives and values are disjoint, so number? is not a value.
; Primitives and variables are disjoint, so number? is not a variable.
; number? does not start with a parenthesis, so number? does not match
; any of the latter 4 cases of expr or def. So, number? is not a legal form.

; x is a variable.
; (x) begins with a parenthesis.
; The cases that match opening with a parenthesis include def and the latter 4 cases in expr.
; (x) does not match def b/c x != define and there are no parentheses and variables and exprs after x.
; (x) does not match (primitive expr expr...) b/c x is not a primitive (primitives and variables are disjoint).
; (x) does not match (variable expr expr...) b/c there is no expr after x in (x).
; (x) does not match the (cond ...) cases b/c x != cond.


; Exercise 118
; Take a look at the following sentences:
; 1. (define (f x) x)
; 2. (define (f x) y)
; 3. (define (f x y) 3)

; Explain why they are syntactically legal definitions 

; (define (f x) x) matches the def case (define (variable variable) expr) with
; f a variable
; x a variable, so x an expr due to `expr = variable | ...`

; (define (f x) y) matches the def case (define (variable variable) expr) with
; f a variable
; x a variable, so x an expr due to `expr = variable | ...`
; y is an expr b/c y is a variable and `expr = variable | ...`

; (define (f x y) 3) matches the def case (define (variable variable) expr) with
; f a variable
; x a variable
; y a variable
; 3 is a value since 3 is a number, so 3 is an expr

; Exercise 119
; Consider the following sentences:
; 1. (define (f "x") x)
; 2. (define (f x y z) (x))

; Explain why they are syntactically illegal.

; "x" is not a variable, since the character " is not allowed in the sequence of characters for variables.
; (define (f "x") x) starts with (define, and the only case that starts with (define is the def case (define (variable variable) expr).
; But (define (f "x") x) fails to match that case because "x" is not a variable.

; (define (f x y z) (x)) has the shape of the def case (define (variable variable...) expr);
; in particular (define (variable variable variable) expr).
; But, is (x) an expr? No. We showed (x) is not an expr in Exercise 117.

; Exercise 120
; Discriminate the legal from the illegal sentences:
; 1. (x)

; 2. (+ 1 (not x))

; 3. (+ 1 2 3)

; Explain why the sentences are legal or illegal.
; Determine whether the legal ones belong to the category expr or def.

; (x) -- in Exercise 117 we showed (x) is not an expr and not a def.
;        (x) begins with a parenthesis and no other cases apply. So, (x) is not legal.

; (+ 1 (not x)) matches the shape of (primitive expr expr...) with
; + : primitive
; expr : 1
; expr : (not x)

; 1 is a value, so it is an expr by `expr = variable | value | ...`
; (not x) matches (primitve expr expr...) with
; not : primitive
; x : expr

; x is an expr by `expr = variable | ...`
; So, (+ 1 (not x)) is an expr because it satisfies one of the cases of expr.

; (+ 1 2 3) matches the shape of (primitive expr expr...) with
; + : primitive
; 1 : expr
; 2 : expr
; 3 : expr

; each of 1, 2, and 3 are values, so each is an expr by `expr = variable | value | ...`
; so, (+ 1 2 3) is an expr because it satisfies one of the cases in expr.


; Exercise 121
; Evaluate the following expressions step-by-step:
; 1.
; (+ (* (/ 12 8) 2/3)
;    (- 20 (sqrt 4)))
; == arithmetic and substitute equals for equals
; (+ 1
;    (- 20 (sqrt 4)))
; == arithmetic and substitute equals for equals
; (+ 1
;    (- 20 2))
; == arithmetic and substitute equals for equals
; (+ 1 
;    18)
; == arithmetic and substitute equals for equals
; 19
;
;
; 2.
; (cond
;  [(= 0 0) #false]
;  [(> 0 1) (string=? "a" "a")]
;  [else (= (/  1 0) 9)])
; == arithmetic and substitute equals for equals
; (cond
;  [#true #false]
;  [(> 0 1) (string=? "a" "a")]
;  [else (= (/  1 0) 9)])
; == cond_true
; #false
;
; 3.
; (cond
;  [(= 2 0) #false]
;  [(> 2 1) (string=? "a" "a")]
;  [else (= (/  1 2) 9)])
; == arithmetic and substitute equals for equals
; (cond
;  [#false #false]
;  [(> 2 1) (string=? "a" "a")]
;  [else (= (/  1 2) 9)])
; == cond_false
; (cond
;  [(> 2 1) (string=? "a" "a")]
;  [else (= (/  1 2) 9)])
; == arithmetic and substitute equals for equals
; (cond
;  [#true (string=? "a" "a")]
;  [else (= (/  1 2) 9)])
; == cond_true
; (string=? "a" "a")
; == function application -- details omitted
; #true
;
; Use DrRacket’s stepper to confirm your computations.

; Exercise 122
; Suppose the program contains these definitions:
;(define (f x y)
;  (+ (* 3 x) (* y y)))

; Show how DrRacket evaluates the following expressions, step-by-step:
; (+ (f 1 2) (f 2 1))
; == beta
; (+ (+ (* 3 1) (* 2 2)) (f 2 1))
; == arithmetic
; (+ (+ 3 4) (f 2 1))
; == arithmetic
; (+ 7 (f 2 1))
; == beta
; (+ 7 (+ (* 3 2) (* 1 1))
; == arithmetic
; (+ 7 (+ 6 1))
; == arithmetic
; (+ 7 7)
; == arithmetic
; 14

; (f 1 (* 2 3))
; == arithmetic -- assumes 'evaluate arguments before function application'
; (f 1 6)
; == beta
; (+ (* 3 1) (* 6 6))
; == 
; (+ 3 36)
; ==
; 39

; (f (f 1 (* 2 3)) 19)
; == evaluate arguments; do arithmetic and substitute equals for equals
; (f (f 1 6) 19)
; == beta
; (f (+ (* 3 1) (* 6 6)) 19)
; == skip steps since same as above
; (f 39 19)
; == beta
; (+ (* 3 39) (* 19 19)))
; == arithmetic and substitute equals for equals
; (+ 117 361)
; ==
; 478
; Use DrRacket’s stepper to confirm your computations.

; Exercise 123
; The use of if may have surprised you in another way because this intermezzo does not mention this form elsewhere.
; In short, the intermezzo appears to explain and with a form that has no explanation either.
; At this point, we are relying on your intuitive understanding of if as a short-hand for cond.
; Write down a rule that shows how to reformulate
; (if expr-test expr-then expr-else)
; as a cond expression. 

; (cond
;  [expr-test expr-then]
;  [else expr-else])