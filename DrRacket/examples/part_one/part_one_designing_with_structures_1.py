from dataclasses import dataclass
#from ..exercises.typing_common import Number
from typing import Union
Number = Union[int,float]
from math import sqrt

@dataclass
class R3:
    '''
    An R3 is a structure
       R3(x=x0, y=y0, z=z0) represents a point in 3-dimensional space with distance from origin x0 in x dimension,
       y0 in y dimension, and z0 in z dimension.
    '''
    x : Number
    y : Number
    z : Number

example_r3_origin = R3(x=0, y=0, z=0)
example_r3_111    = R3(x=1, y=1, z=1)
example_r3_110    = R3(x=1, y=1, z=0)
example_r3_a      = R3(x=1, y=2, z=13)
example_r3_b      = R3(x=-1, y=0, z=3)

# R3 -> Number
# computes distance to origin from r3 -- i.e. distance from point in 3-dimensional space to origin
#def distance_to_origin(r3 : R3) -> Number:
#    return 0
#def distance_to_origin(r3 : R3) -> Number:
#    return (... r3.x  # Number
#            ... r3.y  # Number 
#            ... r3.z  # Number
#            ...)

def distance_to_origin(r3 : R3) -> Number:
    return sqrt(sqr(r3.x) + sqr(r3.y) + sqr(r3.z))

def sqr(n : Number):
    return pow(n, 2)

import pytest

def test_distance_to_origin():
    # https://docs.pytest.org/en/7.1.x/reference/reference.html#pytest-approx
    # for unittest see https://matt-w.net/blog/test-decimal-similarity-in-python/
    relative_tolerance = .01 # default value : 1e-6
    absolute_tolerance = .005 # default value : 1e-12
    assert distance_to_origin(example_r3_origin) == pytest.approx(sqrt(sqr(0) + sqr(0) + sqr(0)), 
                                                                  rel=relative_tolerance, 
                                                                  abs=absolute_tolerance)
    assert distance_to_origin(example_r3_111) == pytest.approx(sqrt(sqr(1) + sqr(1) + sqr(1)),
                                                               rel=relative_tolerance, 
                                                               abs=absolute_tolerance)
    assert distance_to_origin(example_r3_110) == pytest.approx(sqrt(sqr(1) + sqr(1) + sqr(0)), 
                                                               rel=relative_tolerance, 
                                                               abs=absolute_tolerance)
    assert distance_to_origin(example_r3_a) == pytest.approx(sqrt(sqr(1) + sqr(2) + sqr(13)), 
                                                             rel=relative_tolerance, 
                                                             abs=absolute_tolerance)
    assert distance_to_origin(example_r3_b) == pytest.approx(sqrt(sqr(-1) + sqr(0) + sqr(3)), 
                                                             rel=relative_tolerance, 
                                                             abs=absolute_tolerance)
