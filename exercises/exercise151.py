from python_natural_number_utilities import is_zero, sub1, is_positive
from typing_common import Number
# Exercise 151
# Design the function multiply. 
# It consumes a natural number n and multiplies it with a number x without using *.

# N Number -> Number
# multiplies given_number by multiplier
def multiply(multiplier : Number,
             given_number : Number
             ) -> Number:
    if is_zero(multiplier):
        return 0
    elif multiplier == 1:
        return given_number
    elif multiplier > 1:
        return given_number + multiply(sub1(multiplier), given_number)
    else:
        raise Exception('multiply expects a natural number as first argument')

def multiply_alternative(multiplier : Number,
                         given_number : Number
                         ) -> Number:
    if is_zero(multiplier):
        return 0
    elif is_positive(multiplier):
        return given_number + multiply(sub1(multiplier), given_number)
    else:
        raise Exception('multiply expects a natural number as first argument')

import pytest

def test_multiply():
    assert multiply(0, 3) == 0
    assert multiply(1, 3) == 3
    assert multiply(2, 3) == 6
    assert multiply(2, 4) == 8
    assert multiply(3, 3) == 9
    assert multiply(3, 4) == 12
    assert multiply(3, 0) == 0

def test_multiply_alternative():
    assert multiply_alternative(0, 3) == 0
    assert multiply_alternative(1, 3) == 3
    assert multiply_alternative(2, 3) == 6
    assert multiply_alternative(2, 4) == 8
    assert multiply_alternative(3, 3) == 9
    assert multiply_alternative(3, 4) == 12
    assert multiply_alternative(3, 0) == 0
