# Exercise 35. Design the function string-last, which extracts the last character from a non-empty string. 

# data definitions
# signature, purpose statement, header
# functional examples
# take inventory, make template
# fill in template
# write functional examples as tests and run them

# We represent string as string
# We represent character as string of length 1

# string -> string of length 1
# from input string_non_empty return last character in string
# def string_last (string_non_empty):
#   return "e"
# "aloha" |-> "a"
# "ciao"  |-> "o"
# def string_last (string_non_empty):
#   return ... string_non_empty ... 
def string_last (string_non_empty):
    return string_non_empty[-1]

import unittest

class TestStringLast(unittest.TestCase):

    def test_string_last(self):
        self.assertEqual(string_last('aloha'), 'a')
        self.assertEqual(string_last('ciao'), 'o')

import pytest

def test_string_last_pytest():
    assert string_last('aloha') == 'a'
    assert string_last('ciao') == 'o'
