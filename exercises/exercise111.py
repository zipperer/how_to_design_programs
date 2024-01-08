# Exercise 111
# Take a look at these definitions:
# (define-struct vec [x y])
# A vec is
#   (make-vec PositiveNumber PositiveNumber)
# interpretation represents a velocity vector

# Develop the function checked-make-vec,
# which is to be understood as a checked version of the primitive operation
# make-vec. It ensures that the arguments to make-vec are positive numbers.
# In other words, checked-make-vec enforces our informal data definition.

from dataclasses import dataclass
from typing_common import Number
from typing import Any

@dataclass
class VelocityVector2D:
    x_dimension: Number # positive number
    y_dimension: Number # positive number

def make_velocity_vector_2D(x_dimension : Number,
                            y_dimension : Number
                            ) -> VelocityVector2D:
    return VelocityVector2D(x_dimension=x_dimension,
                            y_dimension=y_dimension)

def checked_make_velocity_vector_2D(x_dimension : Any,
                                    y_dimension : Any
                                    ) -> VelocityVector2D:
    match x_dimension:
        case int(x_dimension_input) | float(x_dimension_input) if x_dimension_input >= 0:
            match y_dimension:
                case int(y_dimension_input) | float(y_dimension_input) if y_dimension_input >= 0:
                    return make_velocity_vector_2D(x_dimension=x_dimension_input,
                                                   y_dimension=y_dimension_input)
                case _:
                    raise Exception('make_velocity_vector_2D expects positive number, positive number')
        case _:
            raise Exception('make_velocity_vector_2D expects positive number, positive number')

def is_positive_number(value : Any) -> bool:
    is_number = ((type(value) == int) or (type(value) == float))
    is_positive = False
    if is_number:
        is_positive = (value >= 0)
    return (is_number and is_positive)

def checked_make_velocity_vector_2D_alternative(x_dimension : Any,
                                                y_dimension : Any
                                                ) -> VelocityVector2D:
    if (is_positive_number(x_dimension) and
        is_positive_number(y_dimension)):
        return make_velocity_vector_2D(x_dimension=x_dimension,
                                       y_dimension=y_dimension)
    else:
        raise Exception('make_velocity_vector_2D expects positive number, positive number')        

import pytest

def test_checked_make_velocity_vector_2D():
    assert checked_make_velocity_vector_2D(1, 2) == VelocityVector2D(x_dimension=1, y_dimension=2)
    assert checked_make_velocity_vector_2D(3, 4) == VelocityVector2D(x_dimension=3, y_dimension=4)
    with pytest.raises(Exception):
        assert checked_make_velocity_vector_2D(-3, 4) == 'placeholder'


def test_checked_make_velocity_vector_2D_alternative():
    assert checked_make_velocity_vector_2D_alternative(1, 2) == VelocityVector2D(x_dimension=1, y_dimension=2)
    assert checked_make_velocity_vector_2D_alternative(3, 4) == VelocityVector2D(x_dimension=3, y_dimension=4)
    with pytest.raises(Exception):
        assert checked_make_velocity_vector_2D_alternative(-3, 4) == 'placeholder'
