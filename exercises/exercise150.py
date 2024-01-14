from math import pi
from python_natural_number_utilities import is_zero, is_positive, add1, sub1
from typing_common import Number
# Exercise 150
# Design the function add-to-pi.
# It consumes a natural number n and adds it to pi without using the primitive + operation.
# Here is a start:
# N -> Number
# computes (+ n pi) without using +

def add_to_pi(n : Number) -> Number:
    if is_zero(n):
        return pi
    elif is_positive(n):
        return add1(add_to_pi(sub1(n)))
    else:
        raise Exception('failed to detect input as non-negative number')

def add_to_x(n : Number,
             x : Number
             ) -> Number:
    if is_zero(n):
        return x
    elif is_positive(n):
        return add1(add_to_x(sub1(n), x))
    else:
        raise Exception('add_to_x expects a natural number as first argument')

import pytest

def test_add_to_pi():
    assert add_to_pi(3) == 3 + pi # though I might need pytest.approx() for these
    assert add_to_pi(4) == 4 + pi
    assert add_to_pi(5) == 5 + pi


def test_add_to_x():
    assert add_to_x(3, pi) == 3 + pi # though I might need pytest.approx() for these
    assert add_to_x(4, pi) == 4 + pi
    assert add_to_x(5, pi) == 5 + pi
