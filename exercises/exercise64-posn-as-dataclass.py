from typing import Union
Number = Union[int,float]

from dataclasses import dataclass

@dataclass
class Posn:
    x: Number
    y: Number

    def manhattan_distance_to_origin_as_instance_method(self):
        return self.x + self.y

def manhattan_distance_to_origin(given_posn : Posn) -> Number:
    return given_posn.x + given_posn.y


import pytest

def test_manhattan_distance_to_origin():
    assert manhattan_distance_to_origin(Posn(0, 5)) == 5
    assert manhattan_distance_to_origin(Posn(7, 0)) == 7
    assert manhattan_distance_to_origin(Posn(3, 4)) == 7
    assert manhattan_distance_to_origin(Posn(5, 12)) == 17
    assert manhattan_distance_to_origin(Posn(6, 8)) == 14

def test_manhattan_distance_to_origin_as_instance_method():
    assert Posn(0, 5).manhattan_distance_to_origin_as_instance_method() == 5
    assert Posn(7, 0).manhattan_distance_to_origin_as_instance_method() == 7
    assert Posn(3, 4).manhattan_distance_to_origin_as_instance_method() == 7
    assert Posn(5, 12).manhattan_distance_to_origin_as_instance_method() == 17
    assert Posn(6, 8).manhattan_distance_to_origin_as_instance_method() == 14
