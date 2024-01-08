# Exercise 105
# Some program contains the following data definition:

# A Coordinate is one of: 
# – a NegativeNumber 
# interpretation: on the y axis, distance from top
# – a PositiveNumber 
# interpretation: on the x axis, distance from left
# – a Posn
# interpretation an ordinary Cartesian point

from typing import Any

class Coordinate:
    pass

def enforce_value_negative_number(value : Any) -> None:
    assert (type(value) == int) or (type(value) == float)
    assert value < 0

def enforce_value_positive_number(value : Any) -> None:
    assert (type(value) == int) or (type(value) == float)
    assert value > 0

def enforce_value_number(value : Any) -> None:
    assert (type(value) == int) or (type(value) == float)
    
class NegativeNumber(Coordinate):

    def __init__(self, value):
        enforce_value_negative_number(value)
        self.value = value

class PositiveNumber(Coordinate):

    def __init__(self, value):
        enforce_value_positive_number(value)
        self.value = value

class CartesianPoint(Coordinate):

    def __init__(self, x, y) -> None:
        enforce_value_number(x)
        enforce_value_number(y)
        self.x = x
        self.y = y
        
def function_that_consumes_coordinate(coordinate : Coordinate) -> Any:
    match coordinate:
        case NegativeNumber():
            return 'negative'
        case PositiveNumber():
            return 'positive'
        case CartesianPoint():
            return 'cartesian'

import pytest

def test_negative_number():

    assert isinstance(NegativeNumber(-1), NegativeNumber) == True
    assert isinstance(NegativeNumber(-2), NegativeNumber) == True

    with pytest.raises(AssertionError):
        assert isinstance(NegativeNumber(2), NegativeNumber) == True

def test_positive_number():

    assert isinstance(PositiveNumber(1), PositiveNumber) == True
    assert isinstance(PositiveNumber(5), PositiveNumber) == True

    with pytest.raises(AssertionError):
        assert isinstance(PositiveNumber(-1), PositiveNumber) == True

def test_cartesian_point():

    assert isinstance(CartesianPoint(1, 1), CartesianPoint) == True
    assert isinstance(CartesianPoint(5, 5), CartesianPoint) == True

    with pytest.raises(AssertionError):
        assert isinstance(CartesianPoint('a', 1), CartesianPoint) == True

def test_function_that_consumes_coordinate():
    assert function_that_consumes_coordinate(NegativeNumber(-1)) == 'negative'
    assert function_that_consumes_coordinate(NegativeNumber(-2)) == 'negative'
    assert function_that_consumes_coordinate(PositiveNumber(1)) == 'positive'
    assert function_that_consumes_coordinate(PositiveNumber(2)) == 'positive'
    assert function_that_consumes_coordinate(CartesianPoint(1, 1)) == 'cartesian'
    assert function_that_consumes_coordinate(CartesianPoint(2, 2)) == 'cartesian'
# Make up at least two data examples per clause in the data definition.
# For each of the examples, explain its meaning with a sketch of a canvas.

NegativeNumber(-1)
# Point on y axis 1 unit below top
#_____________
#.            |
#             |
#             |
#             |
#             |
#_____________|

NegativeNumber(-5)
# Point on y axis 5 units below top
#_____________
#             |
#             |
#             |
#             |
#.            |
#_____________|

PositiveNumber(1)
# Point on x axis 1 unit right of left-margin
#_____________
#             |
#             |
#             |
#             |
#             |
#_.___________|

PositiveNumber(5)
# Point on x axis 5 units right of left-margin
#_____________
#             |
#             |
#             |
#             |
#             |
#______.______|

CartesianPoint(1, 1)
# Point at (1, 1)
#_____________
#             |
#             |
#             |
#             |
# .           |
#_____________|

CartesianPoint(5, 5)
# Point at (5, 5)
#_____________
#             |
#     .       |
#             |
#             |
#             |
#_____________|

CartesianPoint(7, 2)
# Point at (7, 2)
#_____________
#             |
#             |
#             |
#       .     |
#             |
#_____________|
