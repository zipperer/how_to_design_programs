;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise87) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)
(require "exercise37.rkt") ; string-rest
(require "exercise38.rkt") ; string-remove-last

(define (string-first string-possibly-empty)
  (cond
    [(= (string-length string-possibly-empty) 0) ""]
    [else (string-ith string-possibly-empty 0)]))

(define (string-last string-possibly-empty)
  (cond
    [(= (string-length string-possibly-empty) 0) ""]
    [else (string-ith string-possibly-empty (- (string-length string-possibly-empty) 1))]))

; Exercise 87
; Develop a data representation for an editor based on our first idea, using a string and an index.
; Then solve the preceding exercises again.
; Retrace the design recipe.
; Hint: if you haven’t done so, solve the exercises in Functions.

; "We can imagine several different ways of going from the information to data and back.
; For example, one field in the structure may contain the entire text entered,
; and the other the number of characters between the first character (counting from the left) and the cursor."

(define-struct editor [text-in-field number-of-characters-between-first-character-and-cursor])
; An Editor is a structure:
;   (make-editor String Number)
; interpretation:
;   (make-editor TEXT-IN-FIELD-0 NUMBER-OF-CHARACTERS-BETWEEN-FIRST-CHARACTER-AND-CURSOR-0)
;   represents an editor with text TEXT-IN-FIELD-0 where
;   NUMBER-OF-CHARACTERS-BETWEEN-FIRST-CHARACTER-AND-CURSOR-0 characters separate
;   the first character and the cursor.
; For example:
;   (make-editor "" -1) represents an editor with no text and the cursor 'to the left' of the first character.
;   Note: (make-editor "" 0) DOES NOT represent an editor with no text and no characters between first
;     character and cursor. See (make-editor "" -1).
;   (make-editor "a" 0) represents an editor with text "a" and no characters between first
;     character and cursor
;   (make-editor "ab" 0) represents an editor with text "ab" and 0 characters between first
;     character and cursor. So, the cursor is after the first character, i.e. between "a"
;     and "b".
;   (make-editor "ab" 1) represents an editor with text "ab" and 1 character between first
;     character and cursor. So, the cursor is after the second character, i.e. after "b".
;   (make-editor "ab" -1) represents an editor with text "ab" and -1 characters between first
;     character and cursor. So, the cursor is before the first character, i.e. before "a".
;  Note: the length of the TEXT-IN-FIELD restricts the values for
;        NUMBER-OF-CHARACTERS-BETWEEN-FIRST-CHARACTER-AND-CURSOR. In particular,
;        (<= -1 NUMBER-OF-CHARACTERS-BETWEEN-FIRST-CHARACTER-AND-CURSOR (- (string-length TEXT-IN-FIELD) 1)

; Exercise 83
; Design the function render, which consumes an Editor and produces an image.
; The purpose of the function is to render the text within an empty scene of 200x20 pixels.
; For the cursor, use a 1x20 red rectangle and for the strings, black text of size 16.

; Develop the image for a sample string in DrRacket’s interactions area.
; We started with this expression:
; (overlay/align "left" "center"
;                (text "hello world" 11 "black")
;                (empty-scene 200 20))
; You may wish to read up on beside, above, and such functions.
; When you are happy with the looks of the image, use the expression as a test and as a guide to the design of render.

(define BACKGROUND-WIDTH 200)
(define BACKGROUND-HEIGHT 20)
(define BACKGROUND (empty-scene BACKGROUND-WIDTH BACKGROUND-HEIGHT))
(define CURSOR-WIDTH 1)
(define CURSOR-HEIGHT 20)
(define CURSOR-COLOR "red")
(define CURSOR-FILL-MODE "solid")
(define CURSOR (rectangle CURSOR-WIDTH CURSOR-HEIGHT CURSOR-FILL-MODE CURSOR-COLOR))
(define TEXT-SIZE 16)
(define TEXT-COLOR "black")

; EditorWorldState -> Image
; render the text in editor-world-state on a background
; stub/header:
;(define (render editor-world-state)
;  (overlay/align "left" "center"
;                (beside (text "hello, " 16 "black") CURSOR (text "world" 16 "black"))
;                (empty-scene 200 20)))
; template
;(define (render editor-world-state)
;  (overlay/align "left" "center"
;                (beside (text "hello, " 16 "black") CURSOR (text "world" 16 "black"))
;                (empty-scene 200 20)))
;  ... editor-world-state-text-in-field ; String
;  ... editor-world-state-number-of-characters-between-first-character-and-cursor ; Number
; )
(define OVERLAY/ALIGN-X-PLACE "left")
(define OVERLAY/ALIGN-Y-PLACE "center")

(check-expect (render (make-editor "" -1)) (overlay/align OVERLAY/ALIGN-X-PLACE OVERLAY/ALIGN-Y-PLACE CURSOR BACKGROUND))
; (check-expect (render (make-editor "" 0)) (overlay/align OVERLAY/ALIGN-X-PLACE OVERLAY/ALIGN-Y-PLACE CURSOR BACKGROUND)) ; this is not possible; for the number to be 0 requires a character is to the left of the cursor
(check-expect (render (make-editor "a" -1)) (overlay/align OVERLAY/ALIGN-X-PLACE OVERLAY/ALIGN-Y-PLACE (beside CURSOR (text "a" TEXT-SIZE TEXT-COLOR)) BACKGROUND))
(check-expect (render (make-editor "a" 0)) (overlay/align OVERLAY/ALIGN-X-PLACE OVERLAY/ALIGN-Y-PLACE (beside (text "a" TEXT-SIZE TEXT-COLOR) CURSOR) BACKGROUND))
(check-expect (render (make-editor "ab" 0)) (overlay/align OVERLAY/ALIGN-X-PLACE OVERLAY/ALIGN-Y-PLACE (beside (text "a" TEXT-SIZE TEXT-COLOR) CURSOR (text "b" TEXT-SIZE TEXT-COLOR)) BACKGROUND))
(check-expect (render (make-editor "ab" 1)) (overlay/align OVERLAY/ALIGN-X-PLACE OVERLAY/ALIGN-Y-PLACE (beside (text "a" TEXT-SIZE TEXT-COLOR) (text "b" TEXT-SIZE TEXT-COLOR) CURSOR) BACKGROUND))
(check-expect (render (make-editor "abc" 1)) (overlay/align OVERLAY/ALIGN-X-PLACE OVERLAY/ALIGN-Y-PLACE (beside (text "ab" TEXT-SIZE TEXT-COLOR) CURSOR (text "c" TEXT-SIZE TEXT-COLOR)) BACKGROUND))
(check-expect (render (make-editor "abc" 2)) (overlay/align OVERLAY/ALIGN-X-PLACE OVERLAY/ALIGN-Y-PLACE (beside (text "a" TEXT-SIZE TEXT-COLOR) (text "bc" TEXT-SIZE TEXT-COLOR) CURSOR) BACKGROUND))
(check-expect (render (make-editor "abc" -1)) (overlay/align OVERLAY/ALIGN-X-PLACE OVERLAY/ALIGN-Y-PLACE (beside CURSOR (text "abc" TEXT-SIZE TEXT-COLOR)) BACKGROUND))
(check-expect (render (make-editor "Hello, World" 11)) (overlay/align OVERLAY/ALIGN-X-PLACE OVERLAY/ALIGN-Y-PLACE (beside (text "Hello, World" TEXT-SIZE TEXT-COLOR) CURSOR) BACKGROUND))
(check-expect (render (make-editor "Hello, World" 6)) (overlay/align OVERLAY/ALIGN-X-PLACE OVERLAY/ALIGN-Y-PLACE (beside (text "Hello, " TEXT-SIZE TEXT-COLOR) CURSOR (text "World" TEXT-SIZE TEXT-COLOR)) BACKGROUND))
(define (render editor-world-state)
  (cond
    [(= -1 (editor-number-of-characters-between-first-character-and-cursor editor-world-state))
     (overlay/align "left" "center"
                    (beside CURSOR
                            (text (editor-text-in-field editor-world-state) TEXT-SIZE "black"))
                    BACKGROUND)]
    [(= 0 (editor-number-of-characters-between-first-character-and-cursor editor-world-state))
     (overlay/align "left" "center"
                    (beside
                     (text (string-first (editor-text-in-field editor-world-state)) TEXT-SIZE "black")
                     CURSOR
                     (text (string-rest (editor-text-in-field editor-world-state)) TEXT-SIZE "black"))
                    BACKGROUND)]
    [else
     (overlay/align "left" "center"
                    (beside
                     (text (substring (editor-text-in-field editor-world-state) 0 (add1 (editor-number-of-characters-between-first-character-and-cursor editor-world-state))) TEXT-SIZE "black")
                     CURSOR
                     (text (substring (editor-text-in-field editor-world-state) (add1 (editor-number-of-characters-between-first-character-and-cursor editor-world-state))) TEXT-SIZE "black"))
                    BACKGROUND)]))


; Exercise 84
; Design edit.
; The function consumes two inputs, an editor ed and a KeyEvent ke, and it produces another editor.
; Its task is to add a single-character KeyEvent ke to the end of the pre field of ed, unless ke denotes the backspace ("\b") key.
; In that case, it deletes the character immediately to the left of the cursor (if there are any).
; The function ignores the tab key ("\t") and the return key ("\r").

; The function pays attention to only two KeyEvents longer than one letter: "left" and "right".
; The left arrow moves the cursor one character to the left (if any), and
; the right arrow moves it one character to the right (if any).
; All other such KeyEvents are ignored.

; Develop a goodly number of examples for edit, paying attention to special cases.
; When we solved this exercise, we created 20 examples and turned all of them into tests.

; Hint
; Think of this function as consuming KeyEvents, a collection that is specified as an enumeration.
; It uses auxiliary functions to deal with the Editor structure.
; Keep a wish list handy; you will need to design additional functions for most of these auxiliary functions,
; such as string-first, string-rest, string-last, and string-remove-last.
; If you haven’t done so, solve the exercises in Functions.

; Editor KeyEvent -> Editor
; makes new editor and inserts character
; when the key-event is a backspace ("\b") key, remove character to the left of the cursor if there is one
; when the key-event is tab ("\t") or return ("\r"), ignore it
; when the key-event is "left" or "right", move the cursor one character in the given direction if possible
; when the key-event is a 1String not already covered, insert the character into the editor
; stub/header:
; (define (edit editor-world-state key-event)
;   editor-world-state)
(check-expect (edit (make-editor "" -1) "\b") (make-editor "" -1))
(check-expect (edit (make-editor "a" 0) "\b") (make-editor "" -1))
(check-expect (edit (make-editor "a" -1) "\b") (make-editor "a" -1))
(check-expect (edit (make-editor "ab" 0) "\b") (make-editor "b" -1))
(check-expect (edit (make-editor "ab" 1) "\b") (make-editor "a" 0))
(check-expect (edit (make-editor "abc" 2) "\b") (make-editor "ab" 1))
(check-expect (edit (make-editor "abcd" 2) "\b") (make-editor "abd" 1))
(check-expect (edit (make-editor "abcd" 2) "\t") (make-editor "abcd" 2))
(check-expect (edit (make-editor "abcd" 2) "\r") (make-editor "abcd" 2))
(check-expect (edit (make-editor "abcd" -1) "left") (make-editor "abcd" -1))
(check-expect (edit (make-editor "abcd" 0) "left") (make-editor "abcd" -1))
(check-expect (edit (make-editor "abcd" 1) "left") (make-editor "abcd" 0))
(check-expect (edit (make-editor "abcd" 2) "left") (make-editor "abcd" 1))
(check-expect (edit (make-editor "abcd" -1) "right") (make-editor "abcd" 0))
(check-expect (edit (make-editor "abcd" 0) "right") (make-editor "abcd" 1))
(check-expect (edit (make-editor "abcd" 3) "right") (make-editor "abcd" 3))
(check-expect (edit (make-editor "abcd" -1) "z") (make-editor "zabcd" 0))
(check-expect (edit (make-editor "abcd" 0) "z") (make-editor "azbcd" 1))
(check-expect (edit (make-editor "abcd" 3) "z") (make-editor "abcdz" 4))
; (define (edit editor-world-state key-event)
; ... (editor-text-in-field editor-world-state) ; String
; ... (editor-number-of-characters-between-first-character-and-cursor editor-world-state) ; Number
; ... key-event ; String -- could be backspace, tab, return, left, right, 1String
(define (edit editor-world-state key-event)
  (cond
    [(or (string=? key-event "\t") (string=? key-event "\r")) editor-world-state]
    [(string=? key-event "\b") (make-editor-world-state-apply-backspace editor-world-state)]
    [(or (string=? key-event "left") (string=? key-event "right")) (make-editor-world-state-apply-left-or-right editor-world-state key-event)]
    [else (make-editor-world-state-apply-key-event-character editor-world-state key-event)]))

; abcd
; 0123

; Editor -> Editor
; apply backspace if possible, i.e. remove character to left of cursor if there is one and update distance
; between first character and cursor
(check-expect (make-editor-world-state-apply-backspace (make-editor "" -1)) (make-editor "" -1))
(check-expect (make-editor-world-state-apply-backspace (make-editor "a" 0)) (make-editor "" -1))
(check-expect (make-editor-world-state-apply-backspace (make-editor "a" -1)) (make-editor "a" -1))
(check-expect (make-editor-world-state-apply-backspace (make-editor "ab" 0)) (make-editor "b" -1))
(check-expect (make-editor-world-state-apply-backspace (make-editor "ab" 1)) (make-editor "a" 0))
(check-expect (make-editor-world-state-apply-backspace (make-editor "abc" 2)) (make-editor "ab" 1))
(check-expect (make-editor-world-state-apply-backspace (make-editor "abcd" 2)) (make-editor "abd" 1))
; (define (make-editor-world-state-apply-backspace editor-world-state)
; ... (editor-text-in-field editor-world-state) ; String
; ... (editor-number-of-characters-between-first-character-and-cursor editor-world-state) ; Number
; )
(define (make-editor-world-state-apply-backspace editor-world-state)
  (cond
    [(= -1 (editor-number-of-characters-between-first-character-and-cursor editor-world-state))
     editor-world-state]
    [(= 0 (editor-number-of-characters-between-first-character-and-cursor editor-world-state))
     (make-editor (string-rest (editor-text-in-field editor-world-state))
                  -1)]
    [else
     (make-editor (string-append (substring (editor-text-in-field editor-world-state)
                                            0
                                            (editor-number-of-characters-between-first-character-and-cursor editor-world-state))
                                 (substring (editor-text-in-field editor-world-state) (add1 (editor-number-of-characters-between-first-character-and-cursor editor-world-state))))
                  (sub1 (editor-number-of-characters-between-first-character-and-cursor editor-world-state)))]))

; Editor KeyEvent-left-or-right-arrow -> WorldState
; move cursor one space if possible
; when key-event-left-or-right-arrow is "left", move left
; when key-event-left-or-right-arrow is "right", move right
(check-expect (make-editor-world-state-apply-left-or-right (make-editor "abcd" -1) "left") (make-editor "abcd" -1))
(check-expect (make-editor-world-state-apply-left-or-right (make-editor "abcd" 0) "left") (make-editor "abcd" -1))
(check-expect (make-editor-world-state-apply-left-or-right (make-editor "abcd" 1) "left") (make-editor "abcd" 0))
(check-expect (make-editor-world-state-apply-left-or-right (make-editor "abcd" 2) "left") (make-editor "abcd" 1))
(check-expect (make-editor-world-state-apply-left-or-right (make-editor "abcd" -1) "right") (make-editor "abcd" 0))
(check-expect (make-editor-world-state-apply-left-or-right (make-editor "abcd" 0) "right") (make-editor "abcd" 1))
(check-expect (make-editor-world-state-apply-left-or-right (make-editor "abcd" 3) "right") (make-editor "abcd" 3))
;(define (make-editor-world-state-apply-left-or-right editor-world-state key-event-left-or-right-arrow)
; ... (editor-text-in-field editor-world-state) ; String
; ... (editor-number-of-characters-between-first-character-and-cursor editor-world-state) ; Number
; ...
;)
(define (make-editor-world-state-apply-left-or-right editor-world-state key-event-left-or-right-arrow)
  (cond
    [(string=? key-event-left-or-right-arrow "left")
     (cond
       [(= -1 (editor-number-of-characters-between-first-character-and-cursor editor-world-state))
        editor-world-state]
       [(= 0 (editor-number-of-characters-between-first-character-and-cursor editor-world-state))
        (make-editor (editor-text-in-field editor-world-state)
                     -1)]
       [else
        (make-editor (editor-text-in-field editor-world-state)
                     (sub1 (editor-number-of-characters-between-first-character-and-cursor editor-world-state)))])] ; can collapse last two cases
    [else ; (string=? key-event-left-or-right-arrow "right")
     (cond
       [(= (string-length (editor-text-in-field editor-world-state))
           (add1 (editor-number-of-characters-between-first-character-and-cursor editor-world-state)))
        editor-world-state]
       [else
        (make-editor (editor-text-in-field editor-world-state)
                     (add1 (editor-number-of-characters-between-first-character-and-cursor editor-world-state)))])]))

; Editor KeyEvent-character-to-insert -> Editor
; insert character and update number that tracks characters between cursor
(check-expect (edit (make-editor "abcd" -1) "z") (make-editor "zabcd" 0)) ; insert at front and increase -1 -> 0
(check-expect (edit (make-editor "abcd" 0) "z") (make-editor "azbcd" 1)) ; insert to right of first character and increase 0 -> 1
(check-expect (edit (make-editor "abcd" 3) "z") (make-editor "abcdz" 4)) ; insert at index (add1 number-characters-between)
; alternatively put, (string-append (substring (editor-text-in-field editor-world-state) 0 (add1 number-characters-between))
;                                   key-event-character
;                                   (substring (editor-text-in-field editor-world-state) (add1 number-characters-between)))
; tests to describe length limit
(check-expect (edit (make-editor "abcdefghijklmnopqrstuvwx" 23) "y") (make-editor "abcdefghijklmnopqrstuvwxy" 24))
(check-expect (edit (make-editor "abcdefghijklmnopqrstuvwxy" 24) "z") (make-editor "abcdefghijklmnopqrstuvwxyz" 25))
(check-expect (edit (make-editor "abcdefghijklmnopqrstuvwxyz" 25) "a") (make-editor "abcdefghijklmnopqrstuvwxyz" 25)) ; number-characters-between does not increase and character not in text
(define (make-editor-world-state-apply-key-event-character editor-world-state key-event-character-to-insert)
  (cond
    [(= -1 (editor-number-of-characters-between-first-character-and-cursor editor-world-state))
     (make-editor (string-append key-event-character-to-insert
                                 (editor-text-in-field editor-world-state))
                  0)]
    [(= 0 (editor-number-of-characters-between-first-character-and-cursor editor-world-state))
     (make-editor (string-append (string-first (editor-text-in-field editor-world-state))
                                 key-event-character-to-insert
                                 (string-rest (editor-text-in-field editor-world-state)))
     1)]
    [else
     (cond
       [(>= (image-width (text (editor-text-in-field editor-world-state) TEXT-SIZE TEXT-COLOR))
            (image-width BACKGROUND))
        editor-world-state]
       [else
        (make-editor (string-append (substring (editor-text-in-field editor-world-state) 0 (add1 (editor-number-of-characters-between-first-character-and-cursor editor-world-state)))
                                    key-event-character-to-insert
                                    (substring (editor-text-in-field editor-world-state) (add1 (editor-number-of-characters-between-first-character-and-cursor editor-world-state))))
                     (add1 (editor-number-of-characters-between-first-character-and-cursor editor-world-state)))])]))

; Exercise 85 with new data representation
(define (run initial-editor-world-state)
  (big-bang initial-editor-world-state
    [on-key edit]
    [to-draw render]))

(define EDITOR-WITH-NO-TEXT-AND-CURSOR-BEFORE-FIRST-CHARACTER (make-editor "" -1))

(run EDITOR-WITH-NO-TEXT-AND-CURSOR-BEFORE-FIRST-CHARACTER)


; Exercise 86.
; Notice that if you type a lot, your editor program does not display all of the text.
; Instead the text is cut off at the right margin.
; Modify your function `edit` from exercise 84 so that it ignores a keystroke if adding
; it to the end of the pre field would mean the rendered text is too wide for your canvas.

; implementation:
; in make-editor-world-state-apply-key-event-character, see
; [(>= (image-width (text (editor-text-in-field editor-world-state) TEXT-SIZE TEXT-COLOR))
;      (image-width BACKGROUND))
;  editor-world-state]