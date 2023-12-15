;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname part_one_write_file_read_file) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/batch-io)

(write-file "sample.dat" "212")

(read-file "sample.dat")

(string-append (read-file "sample.dat") " rocks")

;> (write-file "sample.dat" "212")
;"sample.dat"
;> (read-file "sample.dat")
;"212"
;> (string-append (read-file "sample.dat") " rocks")
;"212 rocks"
;>(write-file 'stdout "312\n")
;312
;'stdout
;> (read-file 'stdin)
;hello, friend
;"hello, friend"
;> 
