# Exercise 34. 
# Design the function string-first, which extracts the first character from a non-empty string. 
# Don’t worry about empty strings. 
# 1. Express how you wish to represent information as data.
# We use strings to represent strings

# 2. Write down a signature, statement of purpose, and a function header.
# Signature: (i.e. number of parameters, type of parameter for each, type of output(s))
# String-NonEmpty -> 1String

# Statement of purpose: (i.e. what does the function compute)
#  returns first character of input string_non_empty

# Header (i.e. a simplistic function definition, also called a stub)
# def string_first (string_non_empty):
#   ...
#   return "a"

# 3. Illustrate the signature and the purpose statement with some functional examples.
# "aloha" |-> "a"
# "ciao"  |-> "c"

# Reformat above as
# Signature
# Purpose Statement
# Functional Examples
# Stub

# String-NonEmpty -> 1String
# returns string of length one -- first character of input string_non_empty
# given: "aloha", expect: "a"
# given: "ciao", expect: "c"
# def string_first (string_non_empty):
#   ...
#   return "a"

# 4. The next step is to take inventory, to understand what are the givens and what we need to compute.
# def string_first (string_non_empty):
#   ... 
#   string_non_empty 
#   ...
#   return "a"

# String-NonEmpty -> 1String
# returns string of length one -- first character of input string_non_empty
# given: "aloha", expect: "a"
# given: "ciao", expect: "c"
def string_first (string_non_empty):
    string_first_character = string_non_empty[0]
    return string_first_character

import unittest

class TestStringFirst(unittest.TestCase):

    def test_string_first(self):
        self.assertEqual(string_first("aloha"), "a")
        self.assertEqual(string_first("ciao"), "c")


import pytest

def test_string_first_pytest():
    assert string_first("aloha") == "a"
    assert string_first("ciao") == "c"
