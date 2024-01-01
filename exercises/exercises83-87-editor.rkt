#lang racket
(provide editor
         make-editor
         editor-pre
         editor-post
         editor?)

(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with 
; the cursor displayed between s and t

; e.g. (make-editor "Hello, " "World") represents an editor with visible text
;      "Hello, World" with the cursor displayed between " " and "W"

; e.g. (make-editor "" "Hello, Worlld") represents an editor with visible text
;      "Hello, World" with the cursor displayed before the "H"