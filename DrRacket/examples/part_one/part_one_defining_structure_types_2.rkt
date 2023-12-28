;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname part_one_defining_structure_types_2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct contact-entry [name home office cell])

(define-struct phone [area number])

(define example-contact-entry
  (make-contact-entry "Shriram Fisler"
                      (make-phone 207 "363-2421")
                      (make-phone 101 "776-1099")
                      (make-phone 208 "112-9981")))

(check-expect (contact-entry? example-contact-entry) #true)
(check-expect (contact-entry-name example-contact-entry) "Shriram Fisler")
(check-expect (phone-area (contact-entry-home example-contact-entry)) 207)
(check-expect (phone-number (contact-entry-cell example-contact-entry)) "112-9981")
