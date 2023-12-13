# Exercise 37. Design the function string-rest, which produces a string like the given one with the first character removed.

# data definitions
# signature, purpose statement, header
# functional examples
# take inventory, make template
# fill in template
# write functional examples as tests and run them

# We represent:
# - strings as strings

# We assume:
# - input string can be length 0 or length 1 or length greater

# string_rest: string -> string
#  return string that is same as input string except returned string does not have first character of input string
#  i.e. return string that is input string with first character removed
# def string_rest(input_string):
#   return "abc"
# given: "hello", expect "ello"
# given: "barbaric", expect "arbaric"
# given: "a", expect: ""
# given: "", expect: ""
# def string_rest(input_string):
#   return ... input_string ...

def string_rest(input_string):
    if len(input_string) <= 1:
        return ''
    else:
        return input_string[1:]

import unittest

class TestStringRest(unittest.TestCase):

    def test_string_rest(self):
        self.assertEqual(string_rest('hello'), 'ello')
        self.assertEqual(string_rest('barbaric'), 'arbaric')
        self.assertEqual(string_rest('a'), '')
        self.assertEqual(string_rest(''), '')

import pytest

def test_string_rest_pytest():
    assert string_rest('hello') == 'ello'
    assert string_rest('barbaric') == 'arbaric'
    assert string_rest('a') == ''
    assert string_rest('') == ''
