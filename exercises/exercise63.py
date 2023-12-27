from typing import Union
Number = Union[int,float]

from math import sqrt

def sqr(given_number : Number) -> Number:
    return pow(given_number, 2)

class Posn:

    def __init__(self, x, y):
        self.x = x
        self.y = y

    def posn_x(self):
        return self.x

    def posn_y(self):
        return self.y

    def distance_to_0_as_instance_method(self):
        return sqrt(sqr(self.x) + sqr(self.y))

def distance_to_0(given_posn : Posn) -> Number:
    return sqrt(sqr(given_posn.posn_x()) + sqr(given_posn.posn_y()))


import pytest

def test_distance_to_0():
    assert distance_to_0(Posn(0, 5)) == 5
    assert distance_to_0(Posn(7, 0)) == 7
    assert distance_to_0(Posn(3, 4)) == 5
    assert distance_to_0(Posn(5, 12)) == 13
    assert distance_to_0(Posn(6, 8)) == 10

def test_distance_to_0_as_instance_method():
    assert Posn(0, 5).distance_to_0_as_instance_method() == 5
    assert Posn(7, 0).distance_to_0_as_instance_method() == 7
    assert Posn(3, 4).distance_to_0_as_instance_method() == 5
    assert Posn(5, 12).distance_to_0_as_instance_method() == 13
    assert Posn(6, 8).distance_to_0_as_instance_method() == 10
