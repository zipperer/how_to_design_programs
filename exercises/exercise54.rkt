; Exercise 54. Why would it be incorrect to use (string=? "resting" x) as the first condition in show? 
; Conversely, formulate a completely accurate condition, that is, a Boolean expression that evaluates 
; to #true precisely when x belongs to the first sub-class of LRCD. 

; It would be incorrect to use (string=? "resting" x) as the first condition in show because
;  string=? assumes its inputs are strings.
; 
;  https://docs.racket-lang.org/htdp-langs/beginner.html#%28def._htdp-beginner._%28%28lib._lang%2Fhtdp-beginner..rkt%29._string~3d~3f%29%29
; (string=? s t) → boolean?
;  s : string
;  t : string
; Determines whether all strings are equal, character for character.
; 
; Since string=? assumes its inputs are strings, a first condition (string=? "resting" x) would error when x is
;  not a string. And x will not be a string when x is a (a) negative integer -3, -2, 1 or (b) nonnegative integer.


; A completely accurate condition (i.e. a Boolean expression that evaluates to #true
;  precisely when x belongs to the first sub-class or LRCD:
;  (and (string? x) (string=? "resting" x))
