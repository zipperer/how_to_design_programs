;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise83) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require "exercises83-87-editor.rkt") ; editor make-editor editor-pre editor-post editor?
(require 2htdp/image)

; (check-expect (make-editor "a" "a") (make-editor "a" "a")) FAILS -- Why?
; for hypothesis, see exercise84:
; '''
; equality between editors with equal fields fails without the define-struct form here
; (equal? (make-editor "a" "a") (make-editor "a" "a")) succeeds when define-struct is here and fails when define-struct comes from (require ...)
; I hypothesize that I need to (provide ...) another function, e.g. something like editor-equal?
; '''

; Exercise 83
; Design the function render, which consumes an Editor and produces an image.

; The purpose of the function is to render the text within an empty scene of 200x20 pixels.
; For the cursor, use a 1x20 red rectangle and for the strings, black text of size 16.

; Develop the image for a sample string in DrRacket’s interactions area. We started with this expression:
; (overlay/align "left" "center"
;               (text "hello world" 11 "black")
;               (empty-scene 200 20))

; You may wish to read up on beside, above, and such functions.
; When you are happy with the looks of the image, use the expression as a test and as a guide to the design of render.

(define TEXT-SIZE 16)
(define TEXT-COLOR "black")
(define EXAMPLE-CHARACTER (text "a" 16 "black"))
(define CURSOR-WIDTH (image-width EXAMPLE-CHARACTER))
(define CURSOR-HEIGHT (image-height EXAMPLE-CHARACTER))
(define CURSOR (rectangle CURSOR-WIDTH CURSOR-HEIGHT "solid" "red"))

(define BACKGROUND-WIDTH 200)
(define BACKGROUND-HEIGHT 20)
(define BACKGROUND (empty-scene BACKGROUND-WIDTH BACKGROUND-HEIGHT))

; WorldState -> Image
; render text from WorldState within an empty scene of image pixels
(check-expect (render (make-editor "Hello, World" ""))
              (overlay/align "left" "center"
                             (beside (text "Hello, World" TEXT-SIZE TEXT-COLOR) CURSOR)
                             BACKGROUND))
(check-expect (render (make-editor "Hello, " "World"))
              (overlay/align "left" "center"
                             (beside (text "Hello, " TEXT-SIZE TEXT-COLOR) CURSOR (text "World" TEXT-SIZE TEXT-COLOR))
                             BACKGROUND))
(check-expect (render (make-editor "Hello, " "World"))
              (overlay/align "left" "center"
                             (beside (text "Hello, " TEXT-SIZE TEXT-COLOR) CURSOR (text "World" TEXT-SIZE TEXT-COLOR))
                             BACKGROUND))
(define (render editor-world-state)
  (overlay/align
   "left"
   "center"
   (beside (text (editor-pre editor-world-state) TEXT-SIZE TEXT-COLOR)
           CURSOR
           (text (editor-post editor-world-state) TEXT-SIZE TEXT-COLOR))
   BACKGROUND))