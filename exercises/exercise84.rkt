;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise84) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; (require "exercise34.rkt") ; string-first ; string-ith: unbound identifier; and assumes string non-empty
; (require "exercise35.rkt") ; string-last ; string-ith: unbound identifier; and assumes string non-empty
(require "exercise37.rkt") ; string-rest
(require "exercise38.rkt") ; string-remove-last
;(require "exercises83-87-editor.rkt") ; editor make-editor editor-pre editor-post editor?
(require 2htdp/image)
(require 2htdp/universe)

;(require "exercise83.rkt")

(define (string-first string-possibly-empty)
  (cond
    [(= (string-length string-possibly-empty) 0) ""]
    [else (string-ith string-possibly-empty 0)]))

(define (string-last string-possibly-empty)
  (cond
    [(= (string-length string-possibly-empty) 0) ""]
    [else (string-ith string-possibly-empty (- (string-length string-possibly-empty) 1))]))

(define-struct editor [pre post]) ; copied here from exercises83-87-editor.rkt.
; equality between editors with equal fields fails without the define-struct form here
; (equal? (make-editor "a" "a") (make-editor "a" "a")) succeeds when define-struct is here and fails when define-struct comes from (require ...)
; I hypothesize that I need to (provide ...) another function, e.g. something like editor-equal?


; Exercise 84
; Design edit.
; The function consumes two inputs, an editor ed and a KeyEvent ke, and it produces another editor.
; Its task is to add a single-character KeyEvent ke to the end of the pre field of ed,
; unless ke denotes the backspace ("\b") key. In that case, it deletes the character immediately to the
; left of the cursor (if there are any).
; The function ignores the tab key ("\t") and the return key ("\r").

; The function pays attention to only two KeyEvents longer than one letter: "left" and "right".
; The left arrow moves the cursor one character to the left (if any), and
; the right arrow moves it one character to the right (if any).
; All other such KeyEvents are ignored.

; Develop a goodly number of examples for edit, paying attention to special cases.
; When we solved this exercise, we created 20 examples and turned all of them into tests.

; Hint
; Think of this function as consuming KeyEvents,
; a collection that is specified as an enumeration.
; It uses auxiliary functions to deal with the Editor structure.
; Keep a wish list handy; you will need to design additional functions
; for most of these auxiliary functions, such as string-first, string-rest,
; string-last, and string-remove-last.
; If you haven’t done so, solve the exercises in Functions.

; Editor KeyEvent -> Editor
; produces an editor from the given editor and key-event
; cases:
;   - when key-event is backspace ("\b"), remove letter to left of cursor if there is one
;   - when key-event is "left", move cursor to the left one letter if possible
;   - when key-event is "right", move cursor to the right one letter if possible
;   - when key-event is a letter, enter the letter to the left of the cursor
;   - when key-event is not any of the above, ignore it
; stub/header:
; (define (edit editor key-event)
;   editor)
; template:
; (define (edit editor key-event)
;   (editor-pre editor) ; String
;   (editor-post editor) ; String
;   key-event ; String
;  )
(check-expect (edit (make-editor "" "") "left") (make-editor "" ""))
(check-expect (edit (make-editor "" "") "right") (make-editor "" ""))
(check-expect (edit (make-editor "" "") "\b") (make-editor "" ""))
(check-expect (edit (make-editor "a" "b") "\b") (make-editor "" "b"))
(check-expect (edit (make-editor "a" "b") "\t") (make-editor "a" "b"))
(check-expect (edit (make-editor "a" "b") "\r") (make-editor "a" "b"))
(check-expect (edit (make-editor "a" "b") " ") (make-editor "a " "b"))
(check-expect (edit (make-editor "a" "b") "c") (make-editor "ac" "b"))
(check-expect (edit (make-editor "a" "b") "right") (make-editor "ab" ""))
(check-expect (edit (make-editor "a" "b") "left") (make-editor "" "ab"))
(define (edit editor key-event)
  (cond
    [(string=? key-event "\b") (make-editor-apply-backspace editor)]
    [(or (string=? key-event "\t") (string=? key-event "\r")) editor]
    [(or (string=? key-event "left") (string=? key-event "right")) (make-editor-move-cursor-direction editor key-event)]
    [(= 1 (string-length key-event)) (make-editor-insert-character editor key-event)]
    [else editor]
    ))

; Editor -> Editor
; remove last letter before cursor, if there is one
(check-expect (make-editor-apply-backspace (make-editor "" "")) (make-editor "" ""))
(check-expect (make-editor-apply-backspace (make-editor "a" "")) (make-editor "" ""))
(check-expect (make-editor-apply-backspace (make-editor "a" "b")) (make-editor "" "b"))
(check-expect (make-editor-apply-backspace (make-editor "" "b")) (make-editor "" "b"))
(define (make-editor-apply-backspace editor)
  (make-editor
   (string-remove-last (editor-pre editor))
   (editor-post editor)))

; Editor KeyEvent-left-or-right -> Editor
; move cursor to left or right
(check-expect (make-editor-move-cursor-direction (make-editor "" "") "left")
              (make-editor "" ""))
(check-expect (make-editor-move-cursor-direction (make-editor "" "") "right")
              (make-editor "" ""))
(check-expect (make-editor-move-cursor-direction (make-editor "" "b") "right")
              (make-editor "b" ""))
(check-expect (make-editor-move-cursor-direction (make-editor "a" "") "right")
              (make-editor "a" ""))
(check-expect (make-editor-move-cursor-direction (make-editor "a" "b") "right")
              (make-editor "ab" ""))
; stub/header:
; (define (make-editor-move-cursor-direction editor key-event-left-or-right)
;   editor)
(define (make-editor-move-cursor-direction editor key-event-left-or-right)
  (cond
    [(string=? key-event-left-or-right "left")
     (make-editor (string-remove-last (editor-pre editor))
                  (string-append (string-last (editor-pre editor))
                                 (editor-post editor)))]
    [(string=? key-event-left-or-right "right")
    (make-editor (string-append (editor-pre editor)
                                (string-first (editor-post editor)))
                 (string-rest (editor-post editor)))]))

; Editor KeyEvent-character -> Editor
; insert key-event-character at cursor
;   i.e. at the end of the string in (editor-pre editor)
(check-expect (make-editor-insert-character (make-editor "" "") " ") (make-editor " " ""))
(check-expect (make-editor-insert-character (make-editor "" "") "a") (make-editor "a" ""))
(check-expect (make-editor-insert-character (make-editor "a" "c") "b") (make-editor "ab" "c"))
(define (make-editor-insert-character editor key-event-character)
  (make-editor (string-append (editor-pre editor) key-event-character)
               (editor-post editor)))


;; BEGIN copied from exercise 83 -- can't require/provide because check-expect not in #lang racket
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
;; END copied from exercise 83


(define (main initial-editor)
  (big-bang initial-editor
    [on-key edit]
    [to-draw render]))

(main (make-editor "" ""))