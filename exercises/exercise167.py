# Exercise 167. 
# Design the function sum, which consumes a list of Posns and 
# produces the sum of all of its x-coordinates. 

from dataclasses import dataclass
from typing import Union, List
Number = Union[int,float]

@dataclass
class Posn:
    '''
    A Posn is a structure that stores an x-coordinate and a y-coordinate.
    Interpretation:
      Posn(x=x_a, y=y_a) is a point with x-coordinate x_a and y-coordinate y_a.
    For example:
      Posn(x=0, y=0) is the origin (0, 0)
      Posn(x=1, y=0) is the point on the x-axis one unit away from origin (1, 0)
      Posn(x=0, y=1) is the point on the y-axis one unit away from origin (0, 1)
      Posn(x=1, y=1) is the point (1,1)
    '''
    x : Number
    y : Number

# A List_of_posn is one of:
# - []
# - cons(Posn, List_of_posn)
# For example:
# []
# [Posn(x=0, y=0)]
# [Posn(x=1, y=0), Posn(x=0, y=0)]
# [Posn(x=1, y=1), Posn(x=1, y=0), Posn(x=0, y=0)]

def posn_x(posn : Posn) -> Number:
    return posn.x

def sum_x_coordinates(list_of_posn : List[Posn]) -> Number:
    match list_of_posn:
        case []:
            return 0
        case [first_posn, *rest_list_of_posn]:
            return posn_x(first_posn) + sum_x_coordinates(rest_list_of_posn)

def test_sum_x_coordinates():
    assert sum_x_coordinates([]) == 0
    assert sum_x_coordinates([Posn(x=0, y=0)]) == 0
    assert sum_x_coordinates([Posn(x=1, y=0), Posn(x=0, y=0)]) == 1
    assert sum_x_coordinates([Posn(x=1, y=1), Posn(x=1, y=0), Posn(x=0, y=0)]) == 2
    assert sum_x_coordinates([Posn(x=3, y=1), Posn(x=1, y=0), Posn(x=0, y=0)]) == 4
    assert sum_x_coordinates([Posn(x=-3, y=1), Posn(x=3, y=1), Posn(x=1, y=0), Posn(x=0, y=0)]) == 1

def sum_x_coordinates_map(list_of_posn : List[Posn]) -> Number:
    return sum(map(posn_x, list_of_posn))
        
def test_sum_x_coordinates_map():
    assert sum_x_coordinates_map([]) == 0
    assert sum_x_coordinates_map([Posn(x=0, y=0)]) == 0
    assert sum_x_coordinates_map([Posn(x=1, y=0), Posn(x=0, y=0)]) == 1
    assert sum_x_coordinates_map([Posn(x=1, y=1), Posn(x=1, y=0), Posn(x=0, y=0)]) == 2
    assert sum_x_coordinates_map([Posn(x=3, y=1), Posn(x=1, y=0), Posn(x=0, y=0)]) == 4
    assert sum_x_coordinates_map([Posn(x=-3, y=1), Posn(x=3, y=1), Posn(x=1, y=0), Posn(x=0, y=0)]) == 1
