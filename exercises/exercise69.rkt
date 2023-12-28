;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise69) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; Exercise 69.
; Draw box representations for the solution
; of exercise 65.

(define-struct movie [title producer year])
(define DIEHARD                                                                                                                   
  (make-movie                                                                                                                     
   "Die Hard"                                                                                                                     
   "Lawrence Gordon;Joel Silver"                                                                                                  
   1988))

;                         ______
;                        | Movie| 
; ------------------------------|
; title     | producer | year   |
; "Die Hard"| "LG;JS"  | 1988   |
; -------------------------------

(define-struct person [name hair eyes phone])                                                                                     
(define BRUCE-WILLIS                                                                                                              
  (make-person                                                                                                                    
   "Bruce Willis"                                                                                                                 
   "Brown"                                                                                                                        
   "Green"                                                                                                                        
   "8675309"))
;                         ________
;                        | Person| 
; -------------------------------|
; name   |hair   |eyes   |phone  |
; "Bruce"|"Brown"|"Green"|"86753"|
; --------------------------------

(define-struct pet [name number])                                                                                                 
(define BRUCE-WILLIS-CAT                                                                                                          
  (make-pet                                                                                                                       
   "BABY BRUCE"                                                                                                                   
   1))
;                  ____
;                 |Pet| 
; --------------------|
; name        |number |
; "BABY BRUCE"|1      |
; ---------------------

(define-struct CD [artist title price])                                                                                           
(define DIE-HARD-SOUNDTRACK                                                                                                       
  (make-CD                                                                                                                        
   "Michael Kamen"                                                                                                                
   "Die Hard: Original Motion Picture Soundtrack"                                                                                 
   9.99))
;                    _____
;                    | CD| 
; ------------------------
; artist |title    |price|
; "MK"   |"DH:OMPS"|9.99 |
; ------------------------

(define-struct sweater [material size producer])                                                                                  
(define BRUCE-WILLIS-SWEATER                                                                                                      
  (make-sweater                                                                                                                   
   "Kevlar"                                                                                                                       
   "Large"                                                                                                                        
   "Dupont"))
;                    _________
;                    |Sweater| 
; ----------------------------
; material |size    |producer|
; "Kevlar" |"Large" |"Dupont"|
; ----------------------------