; Exercise 55. Take another look at show. It contains three instances of an expression with the approximate shape:
;  (place-image ROCKET 10 (- ... CENTER) BACKG)

; This expression appears three times in the function: twice to draw a resting rocket and once to draw a flying rocket. 
; Define an auxiliary function that performs this work and thus shorten show. 
; Why is this a good idea?

(define (place-rocket-on-background-at-x-coordinate-10-and-y-coordinate-minus-center y-coordinate)
  (place-image ROCKET 10 (- y-coordinate CENTER) BACKG))

(define (show x)
  (cond
    [(string? x)
     (place-rocket-on-background-at-x-coordinate-10-and-y-coordinate-minus-center HEIGHT)]
    [(<= -3 x -1)
     (place-image (text (number->string x) 20 "red")
                  10 (* 3/4 WIDTH)
		  (place-rocket-on-background-at-x-coordinate-10-and-y-coordinate-minus-center HEIGHT))]
    [(>= x 0)
     (place-rocket-on-background-at-x-coordinate-10-and-y-coordinate-minus-center x)]))

; It is a good idea to define an auxiliary function to perform this work because
;   1.
;   using the auxiliary function in multiple places conveys to the reader that
;   the form in these multiple places is similar intentionally. If the reader
;   encountered multiple uses of (place-image ROCKET 10 ... BACKG) rather than
;   multiple uses of the auxiliary function, then the reader cannot rule out the
;   possibility that the multiple uses of (place-image ROCKET 10 ... BACKG) are
;   similar by happenstance rather than intention.
;  
;  2.
;  if the writer wants to change the program and keep the similar behavior across
;  these cases, then the writer can edit the auxiliary function once rather than
;  editing each clause.
