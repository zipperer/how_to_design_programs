from typing import Union, Any
Number = Union[int,float]
NumberOrException = Union[Number,Exception]
from math import pi

def area_of_disk(r : Number) -> Number:
    return pi * (r * r)

def checked_area_of_disk(x : Any) -> NumberOrException:
    match x:
        case int(input_number) | float(input_number):
            return area_of_disk(input_number)
        case _:
            raise Exception('area_of_disk expects a number')

# The return type of checked_area_of_disk may not capture exactly what I intend.
# The function does not ever _return_ an exception. It _raises_ one.
# So, it is correct that the return type is NumberOrException, because the function
# always _returns_ a Number -- when it returns. I don't yet see how to
# express that the function _raises_ an exception on some inputs

def checked_area_of_disk_alternative_return_type(x : Any) -> Number:
    match x:
        case int(input_number) | float(input_number):
            return area_of_disk(input_number)
        case _:
            raise Exception('area_of_disk expects a number')

def enforce_number(value : Any) -> None:
    assert (type(value) == int or 
            (type(value) == float))

def enforce_positive_number(value : Number) -> None:
    assert value >= 0

class PositiveNumber:

    def __init__(self, value):
        enforce_number(value)
        enforce_positive_number(value)
        self.value = value

def area_of_disk_require_positive_number(radius: PositiveNumber) -> PositiveNumber:
    return pi * (radius.value * radius.value)

def checked_area_of_disk_require_positive_number(radius: Any) -> PositiveNumber:
    match radius:
        case PositiveNumber(value=input_radius):
            return area_of_disk_require_positive_number(PositiveNumber(input_radius))
        case _:
            raise Exception('area_of_disk_alternative expects number greater than or equal to 0')

# claim: oving between number and instance of PositiveNumber is unneccessary complexity.

def area_of_disk_require_number_that_is_positive(radius : Number) -> Number:
    return pi * (radius * radius)

def checked_area_of_disk_require_number_that_is_positive(value : Any) -> Number:
    match value:
        case int(input_value) | float(input_value) if input_value >= 0:
            return area_of_disk_require_number_that_is_positive(input_value)
        case _:
            raise Exception('area_of_disk_require_number_that_is_positive expects number greater than or equal to 0')

import pytest

def test_checked_area_of_disk():
    assert checked_area_of_disk(1) == pi     # though I might need pytest.approx for these
    assert checked_area_of_disk(2) == pi * 4 # 
    with pytest.raises(Exception):
        assert checked_area_of_disk('a') == 'blah'

def test_checked_area_of_disk_alternative_return_type():
    assert checked_area_of_disk_alternative_return_type(1) == pi     # though I might need pytest.approx for these
    assert checked_area_of_disk_alternative_return_type(2) == pi * 4 # 
    with pytest.raises(Exception):
        assert checked_area_of_disk_alternative_return_type('a') == 'blah'

def test_checked_area_of_disk_alternative():
    assert checked_area_of_disk_require_positive_number(PositiveNumber(1)) == pi
    assert checked_area_of_disk_require_positive_number(PositiveNumber(2)) == pi * (2 * 2)
    with pytest.raises(Exception):
        assert checked_area_of_disk_require_positive_number(-1) == 'blah'
    with pytest.raises(Exception):
        assert checked_area_of_disk_require_positive_number('a') == 'blah'

def test_checked_area_of_disk_require_number_that_is_positive():
    assert checked_area_of_disk_require_number_that_is_positive(1) == pi
    assert checked_area_of_disk_require_number_that_is_positive(2) == pi * (2 * 2)
    with pytest.raises(Exception):
        assert checked_area_of_disk_require_number_that_is_positive(-1) == 'blah'
    with pytest.raises(Exception):
        assert checked_area_of_disk_require_number_that_is_positive('a') == 'blah'
