;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise103) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; Exercise 103
; Develop a data representation for the following four kinds of zoo animals:
; 1. spiders, whose relevant attributes are the number of remaining legs (we assume that spiders can lose legs in accidents)
;    and the space they need in case of transport;

; 2. elephants, whose only attributes are the space they need in case of transport;

; 3. boa constrictors, whose attributes include length and girth; and

; 4. armadillos, for which you must determine appropriate attributes, including one that determines the space needed for transport.

; Develop a template for functions that consume zoo animals.

; Design the fits? function, which consumes a zoo animal and a description of a cage.
; It determines whether the cage’s volume is large enough for the animal.

(define-struct space-for-transport [length width height])
; A SpaceForTransport is a structure:
;   (make-space-for-transport Number Number Number)
; interpretation:
;   (make-space-for-transport l0 w0 h0)
;   represents a description of the dimensions needs to
;   transport an object -- the dimensions specify a length l0,
;   width w0, and a height h0

(define-struct spider [legs-remaining space-for-transport])
; A Spider is a structure:
;   (make-spider Number SpaceForTransport)
; interpretation:
;   (make-spider n0 sft0)
;   represents a spider with n0 legs remaining and
;   sft0 requirements for space for transport. sft0
;   has structure (make-space-for-transport l0 w0 h0),
;   i.e. it specifies the requirements for
;   length, width, and height to transport the spider.

(define-struct elephant [space-for-transport])
; An Elephant is a structure:
;   (make-elephant SpaceForTransport)
; interpretation:
;   (make-elephant sft0) i.e.
;   (make-elephant (make-space-for-transport l0 w0 h0))
;   represents an elephant that requires for transport
;   an enclosure with length l0, width w0, and height h0.

(define-struct boa-constrictor [length girth])
; A BoaConstrictor is a structure:
;   (make-boa-constrictor Number Number)
; interpretation:
;   (make-boa-constrictor l0 g0) represents a boa constrictor
;   with length l0 and girth g0

(define-struct armadillo [space-for-transport nocturnal?])
; An Armadillo is a structure:
;   (make-armadillo SpaceForTransport Boolean)
; interpretation:
;   (make-armadillo (make-space-for-transport l0 w0 h0) b0)
;   represents an armadillo (a) that requires for transport an
;   enclosure that meets or exceeds length l0, width w0,
;   and height h0 and (b) for which it is b0 that the
;   armadillo is nocturnal.

; A ZooAnimal is one of:
; - Spider
; - Elephant
; - BoaConstrictor
; - Armadillo

; ZooAnimal -> Any
(define (function-for-zoo-animals zoo-animal)
  (cond
    [(spider? zoo-animal) (... (spider-legs-remaining zoo-animal) ... (spider-space-for-transport zoo-animal))]
    [(elephant? zoo-animal) (... (elephant-space-for-transport zoo-animal))]
    [(boa-constrictor? zoo-animal) (... (boa-constrictor-length zoo-animal) ... (boa-constrictor-girth zoo-animal) ...)]
    [(armadillo? zoo-animal) (... (armadillo-space-for-transport zoo-animal) ... (armadillo-nocturnal? zoo-animal) ...)]))

; BoaConstrictor -> SpaceForTransport
(define (boa-constrictor-space-for-transport boa-constrictor)
  (make-space-for-transport (* .8 (boa-constrictor-length boa-constrictor))
                            (* .8 (boa-constrictor-length boa-constrictor))
                            (* 2 (boa-constrictor-girth boa-constrictor))))

; ZooAnimal SpaceForTransport -> Boolean
; determines whether the cage’s volume is large enough for the animal
(check-expect (fits? (make-spider 0 (make-space-for-transport 1 1 1)) (make-space-for-transport 1 1.2 1)) #true)
(check-expect (fits? (make-spider 0 (make-space-for-transport 1 1 1)) (make-space-for-transport 1 .8 1)) #false)
(check-expect (fits? (make-boa-constrictor 1 .2) (make-space-for-transport 1 .9 .5)) #true)
(check-expect (fits? (make-boa-constrictor 1 .2) (make-space-for-transport 1 .7 .5)) #false)
(define (fits? zoo-animal cage-description)
  (cond
    [(spider? zoo-animal)
     (cage-description-meets-needs-of-animal-with-space-for-transport cage-description (spider-space-for-transport zoo-animal))]
    [(elephant? zoo-animal)
     (cage-description-meets-needs-of-animal-with-space-for-transport cage-description (elephant-space-for-transport zoo-animal))]
    [(boa-constrictor? zoo-animal)
     (cage-description-meets-needs-of-animal-with-space-for-transport cage-description (boa-constrictor-space-for-transport zoo-animal))]
    [(armadillo? zoo-animal)
     (cage-description-meets-needs-of-animal-with-space-for-transport cage-description (armadillo-space-for-transport zoo-animal))]))

(define (cage-description-meets-needs-of-animal-with-space-for-transport cage-description zoo-animal-space-for-transport)
  (and (>= (space-for-transport-length cage-description)
           (space-for-transport-length zoo-animal-space-for-transport))
       (>= (space-for-transport-width cage-description)
           (space-for-transport-width zoo-animal-space-for-transport))
       (>= (space-for-transport-height cage-description)
           (space-for-transport-height zoo-animal-space-for-transport))))

; Alternative:
(define (zoo-animal-space-for-transport zoo-animal)
  (cond
    [(spider? zoo-animal) (spider-space-for-transport zoo-animal)]
    [(elephant? zoo-animal) (elephant-space-for-transport zoo-animal)]
    [(boa-constrictor? zoo-animal) (boa-constrictor-space-for-transport zoo-animal)]
    [(armadillo? zoo-animal) (armadillo-space-for-transport zoo-animal)]))

(check-expect (fits?-alternative (make-spider 0 (make-space-for-transport 1 1 1)) (make-space-for-transport 1 1.2 1)) #true)
(check-expect (fits?-alternative (make-spider 0 (make-space-for-transport 1 1 1)) (make-space-for-transport 1 .8 1)) #false)
(check-expect (fits?-alternative (make-boa-constrictor 1 .2) (make-space-for-transport 1 .9 .5)) #true)
(check-expect (fits?-alternative (make-boa-constrictor 1 .2) (make-space-for-transport 1 .7 .5)) #false)
(define (fits?-alternative zoo-animal cage-description)
  (cage-description-meets-needs-of-animal-with-space-for-transport cage-description (zoo-animal-space-for-transport zoo-animal)))