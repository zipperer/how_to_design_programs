;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname part_one_fahrenheit_to_celsius) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/batch-io)

(define (celsius_from_fahrenheit fahrenheit)
  (* (/ 5 9) (- fahrenheit 32)))

;(celsius_from_fahrenheit 32)
;"should be"
;0

;(celsius_from_fahrenheit 212)
;"should be"
;100

;(celsius_from_fahrenheit -40)
;"should be"
;-40

(define (read_value_from_file_convert_and_write_to_file output-file-name)
  (write-file output-file-name (number->string (celsius_from_fahrenheit (string->number (read-file "sample.dat"))))))

; (read_value_from_file_convert_and_write_to_file "celsius-output.txt")

(define (convert in out)
  (write-file out (string-append (number->string (celsius_from_fahrenheit (string->number (read-file in)))) "\n")))

(convert "sample.dat" "part_one_fahrenheit_celsisus_output-1.txt")