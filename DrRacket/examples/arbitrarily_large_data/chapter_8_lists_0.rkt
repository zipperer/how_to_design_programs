;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname chapter_8_lists_0) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; Exercise 129
; Create BSL lists that represent
; a list of celestial bodies, say, at least all the planets in our solar system;
; a list of items for a meal, for example, steak, french fries, beans, bread, water, Brie cheese, and ice cream; and
; a list of colors.

; Sketch some box representations of these lists, similar to those in figures 44 and 45.
; Which of the sketches do you like better?

(define PLANETS-IN-SOLAR-SYSTEM
  (cons "Mercury"
        (cons "Venus"
              (cons "Earth"
                    (cons "Mars"
                          (cons "Jupiter"
                                (cons "Saturn"
                                      (cons "Uranus"
                                            (cons "Neptune"
                                                  (cons "Pluto" '()))))))))))

(define ITEMS-FOR-MEAL
  (cons "steak"
        (cons "french fries"
              (cons "beans"
                    (cons "bread"
                          (cons "water"
                                (cons "brie cheese"
                                      (cons "ice cream" '()))))))))

(define COLORS
  (cons "red"
        (cons "white"
              (cons "blue" '()))))

; I like the boxes-in-boxes picture when depicting a single list.

; I like the boxes-and-arrows picture if multiple lists share a particular cons. For example:
; (define anchor (cons 'stake '()))
; (define first-rope (cons 'segment1 anchor))
; (define second-rope (cons 'segmen2 anchor))
; ___________|cons|  ___________|cons| 
; |first     |rest|  |first     |rest|
; |----------|----|  |----------|----|
; | segment1 |  o-|->| 'stake   |'() |
; |---------------|  |---------------|
;                    ^
; ___________|cons|  |
; |first     |rest|  |
; |----------|----|  |
; | segment2 |  o-|--
; |---------------|  


;----------------------------------------------
; A 3LON is a list of three numbers:
;   (cons Number (cons Number (cons Number '())))
; interpretation:
;   a point in 3-dimensional space

; A List-of-names is one of:
; - '()
; - (cons String List-of-names)
; interpretation:
;   a list of invitees, by last name

; Exercise 130
; Create an element of List-of-names that contains five Strings.
; Sketch a box representation of the list similar to those found in figure 44.

(define LIST-OF-FIVE-NAMES (cons "Felleisen"
                                 (cons "Findler"
                                       (cons "Krishnamurthi"
                                             (cons "Flatt"
                                                   (cons "Zipperer" '()))))))

; Explain why
;   (cons "1" (cons "2" '()))
; is an element of List-of-names and why
;   (cons 2 '())
; isn’t.

; claim: (cons "1" (cons "2" '())) is an element of List-of-names
; argument:
; a. '() is a List-of-names by the first clause in the itemization.
; b. (cons "2" '()) is a List-of-names by the second clause in the itemization; for,
;      "2" is a String and '() is an element of List-of-names by (a).
; c. (cons "1" (cons "2" '())) is a List-of-names by the second clause in the itemization; for,
;    "1" is a String and (cons "2" '()) is a List-of-names by (b).

; claim: (cons 2 '()) is not an element of List-of-names
; argument:
; (cons 2 '()) is not '(), so (cons "2" '()) fails to be a List-of-names by the first clause in the itemization.
; a. '() is a List-of-names by the first clause in the itemization.
; b. 2 is a Number; it is not a String. So, (cons 2 '()) fails to match the pattern (cons String List-of-names).

; Exercise 131
; Provide a data definition for representing lists of Boolean values.
; The class contains all arbitrarily long lists of Booleans.

; A List-of-booleans is one of:
; - '()
; - (cons Boolean List-of-booleans)

; AZ aside: what are the differences between cons and this:
;
; A List is one of:
; - EMPTY-LIST
; - (make-alternative-cons Any List)
;
; (define-struct alternative-cons [first rest])
; ?
;
; At least one difference: (make-alternative-cons x y) does not check whether y is a List, but
; cons does check whether y is a List in (cons x y).
;
; end AZ aside

; Any -> Boolean
; is the given value '()
; (define (empty? x) ...)

(define-struct pair [left right])
; A ConsPair is a structure:
;   (make-pair Any Any)

; Any Any -> ConsPair
; (define (our-cons a-value a-list)
;   (make-pair a-value a-list))

; A ConsOrEmpty is one of:
; - '()
; - (make-pair Any ConsOrEmpty)
; interpretation:
;   ConsOrEmpty is the class of all lists

(define (our-cons a-value a-list)
  (cond
    [(empty? a-list) (make-pair a-value '())]
    [(pair? a-list) (make-pair a-value a-list)]
    [else
     (error "cons expects second argument is a ConsOrEmpty")]))

; ConsOrEmpty -> Any
; extracts the left part of the given pair
(define (our-first a-list)
  (if (empty? a-list)
      (error "our-first expects argument is non-empty ConsOrEmpty (i.e. a (make-pair ...))")
      (pair-left a-list)))

(check-error (our-first '()))
(check-expect (our-first (make-pair 'a '())) 'a)
(check-expect (our-first (make-pair 'a (make-pair 'b '()))) 'a)

; ConsOrEmpty -> ConsOrEmpty 
(define (our-rest a-list)
  (if (empty? a-list)
      '() ; not sure what to do for this case.
      (pair-right a-list)))

(check-expect (our-rest '()) '())
(check-expect (our-rest (make-pair 'a '())) '())
(check-expect (our-rest (make-pair 'a (make-pair 'b '()))) (make-pair 'b '()))
(check-expect (our-rest (make-pair 'a (make-pair 'b (make-pair 'c '())))) (make-pair 'b (make-pair 'c '())))

; List -> Boolean
; check whether input list contains "Flatt"
(check-expect (contains-flatt? '()) #false)
(check-expect (contains-flatt? (cons "Flatt" '())) #true)
(check-expect (contains-flatt? (cons "Flatt" (cons "Felleisen" '()))) #true)
(check-expect (contains-flatt? (cons "Felleisen" (cons "Flatt" '()))) #true)
(check-expect (contains-flatt? (cons "Felleisen" (cons "Krishnamurthi" '()))) #false)
(define (contains-flatt? input-list)
  (cond
    [(empty? input-list) #false]
    [(string=? "Flatt" (first input-list)) #true]
    [else (contains-flatt? (rest input-list))]))

(define (contains-name? name input-list)
  (cond
    [(empty? input-list) #false]
    [(string=? name (first input-list)) #true]
    [else (contains-name? name (rest input-list))]))

(check-expect (contains-flatt?-alternative '()) #false)
(check-expect (contains-flatt?-alternative (cons "Flatt" '())) #true)
(check-expect (contains-flatt?-alternative (cons "Flatt" (cons "Felleisen" '()))) #true)
(check-expect (contains-flatt?-alternative (cons "Felleisen" (cons "Flatt" '()))) #true)
(check-expect (contains-flatt?-alternative (cons "Felleisen" (cons "Krishnamurthi" '()))) #false)
(define (contains-flatt?-alternative input-list)
  (contains-name? "Flatt" input-list))

; Exercise 132
; Use DrRacket to run contains-flatt? in this example:
(contains-flatt?
 (cons "Fagan"
       (cons "Findler"
             (cons "Fisler"
                   (cons "Flanagan"
                         (cons "Flatt"
                               (cons "Felleisen"
                                     (cons "Friedman" '()))))))))
; What answer do you expect? #true

; Exercise 133
; Here is another way of formulating the second cond clause in contains-flatt?:
; ... (cond
;       [(string=? (first alon) "Flatt") #true]
;       [else (contains-flatt? (rest alon))]) ...
; Explain why this expression produces the same answers as the `or` expression in the version of figure 47.
; Which version is clearer to you? Explain.

; claim: this version produces the same answers as the `or` expression in the version of figure 47.
; argument:
; consider the possible cases for each version:
; (string=? (first alon) "Flatt") == #true
;  - (string=? (first alon) "Flatt") with `or` version: the left side of `or` returns #true so whole expression #true
;  - (string=? (first alon) "Flatt") with `cond` version: the question part of the cond clause is #true, so
;    the value of the cond is the value of the answer which is #true
; (string=? (first alon) "Flatt") == #false
;  - with `or` version, the value of the `or` will be the value of the right-hand-side of the `or`, since the value
;    of left-hand-side is #false
;  - with `cond` version, the value of the expression will be the value of the else answer, since the value
;    of the `(cond [#false value1] [else value2])` is the value of value2 by cond_false rule.
;  So, in both cases, the value will be the value of (contains-flatt? (rest alon)).

; One appealing property of the `or` version: the `cond` cases on the input datatype and there is one case for each
;   possibility. The value of the second case is the value of the `or`. With the `cond` version, `cond` is used in
;   two distinct ways: (1) to case on the type of the input datatype and (2) to distinguish between when the first
;   element of the list is "Flatt" and not.

; But, both the `or` form and `cond` form are clear.

; Exercise 134
; Develop the contains? function, which determines whether some given string occurs on a given list of strings.

; Note:
; BSL actually comes with member?, a function that consumes two values and
; checks whether the first occurs in the second, a list:
; > (member? "Flatt" (cons "b" (cons "Flatt" '())))
; #true

; Don’t use member? to define the contains? function.

; See contains-name? above
(define (contains? input-string input-list)
  (cond
    [(empty? input-list) #false]
    [(string=? input-string (first input-list)) #true]
    [else (contains? input-string (rest input-list))]))

; Exercise 135
; Use DrRacket’s stepper to check the calculation for
;   (contains-flatt? (cons "Flatt" (cons "C" '())))

; Also use the stepper to determine the value of
;   (contains-flatt?
;     (cons "A" (cons "Flatt" (cons "C" '()))))
; What happens when "Flatt" is replaced with "B"?
;  (contains-flatt?
;    (cons "A" (cons "B" (cons "C" '()))))
;  => #false

