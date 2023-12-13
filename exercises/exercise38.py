# Exercise 38. Design the function string-remove-last, which produces a string like the given one with the last character removed.

# data definitions
# signature, purpose statement, header
# functional examples
# take inventory, make template
# fill in template
# write functional examples as tests and run them

# We represent:
# - strings as strings

# We assume:
# - strings can be length 0, length 1, and length greater than 1.

# string_remove_last: string -> string
#  returns a string identical to input string except returned string lacks last character of input string
# def string_remove_last(input_string):
#   return "abc"
# given: "hello", expect: "hell"
# given: "barbaric", expect: "barbari"
# given "a", expect: ""
# given "", expect: ""
# def string_remove_last(input_string):
#   return ... input_string ...

def string_remove_last(input_string):
    input_string_length = len(input_string)
    if input_string_length == 0:
        return ''
    else:
        return input_string[:(input_string_length - 1)] # alternatively input_string[:-1]

import unittest

class TestStringRemoveLast(unittest.TestCase):

    def test_string_remove_last(self):
        self.assertEqual(string_remove_last('hello'), 'hell')
        self.assertEqual(string_remove_last('barbaric'), 'barbari')
        self.assertEqual(string_remove_last('a'), '')
        self.assertEqual(string_remove_last(''), '')

import pytest

def test_string_remove_last_pytest():
    assert string_remove_last('hello') == 'hell'
    assert string_remove_last('barbaric') == 'barbari'
    assert string_remove_last('a') == ''
    assert string_remove_last('') == ''
