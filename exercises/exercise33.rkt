; The Year 2000 Problem
;
; The problem refers to the following possibility:
; - a program could store a year with 2 digits, e.g. a program could store 1995 as 95
; -- in such a program, the programmer takes a given that the year starts with the two digits 19, so that 95 stands for 1995.
; - given (a) a program that stored a date with 2 digits and
;         (b) a programmer who takes it as given that the first two digits are 19, and
;         (c) 99 will proceed to 00
;   when the program proceeds from 99 to 00 the interpretation proceeds from 1999 to 1900, rather than from 1999 to 2000.
;
; A program may rely on dates to reason about whether an event occurred before another event.
; For example, consider a program that maintains a priority queue and orders it by the date an entry is made.
; A person A could make an entry with year 99 and the program enters it into the priority queue.
; Then a person B makes an entry with year 00 and the program enters the person B entry into the priority queue BEFORE the entry with the year 99,
; since 00 is before 99. This is an error due to storing the year with two digits.
;
; See example related to misinterpreting year 00 as before year 99
; ''' NTT Mobile Communications Network (NTT Docomo), Japan's largest cellular operator,
;     reported that some models of mobile telephones were deleting new messages received,
;     rather than the older messages, as the memory filled up.
; ''' 
; Martyn Williams (3 January 2000).
; "Computer problems hit three nuclear plants in Japan".
; CNN. IDG Communications. Archived from the original on 2004-12-07.

; The Year 2000 Problem is also known as the Y2K {Problem|Bug|Scare|Error}.
; Y -> Year
; 2K -> 2000

; '''
; I'm one of the culprits who created this problem.
; I used to write those programs back in the 1960s and 1970s,
; and was proud of the fact that I was able to squeeze a few elements
; of space out of my program by not having to put a 19 before the year.
; Back then, it was very important. We used to spend a lot of time running
; through various mathematical exercises before we started to write our
; programs so that they could be very clearly delimited with respect to
; space and the use of capacity. It never entered our minds that those
; programs would have lasted for more than a few years. As a consequence,
; they are very poorly documented. If I were to go back and look at some
; of the programs I wrote 30 years ago, I would have one terribly difficult
; time working my way through step-by-step.
; '''
; —Alan Greenspan
; Testimony from ex-Chairman of the Federal Reserve before the Senate Banking
; Committee, 25 February 1998, ISBN 978-0-16-057997-4