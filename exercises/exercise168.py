# Exercise 168. 
# Design the function translate. 
#   It consumes and produces lists of Posns. 
#   For each (make-posn x y) in the former, the latter contains (make-posn x (+ y 1)). 

# We borrow the word “translate” from geometry, where the movement of a point 
#   by a constant distance along a straight line is called a translation. 

from dataclasses import dataclass
from typing import Union, List
from python_list_utilities import cons
Number = Union[int,float]

@dataclass
class Posn:
    '''
    A Posn is a structure that stores an x-coordinate and a y-coordinate.
    Interpretation:
      Posn(x=x_a, y=y_a) represents a point with x-coordinate x_a and y-coordinate y_a
    For example:
      Posn(x=0, y=0) represents the origin (0,0)
      Posn(x=1, y=0) represents the point one unit away from the origin along the x axis (1,0)
      Posn(x=0, y=1) represents the point one unit away from the origin along the y axis (0,1)
      Posn(x=1, y=1) represents the point (1,1)
    '''
    x : Number
    y : Number

# A List_of_posn is one of:
# - '()
# - cons(Posn, List_of_posn)
# For example:
# []
# [Posn(x=0, y=0)]
# [Posn(x=1, y=0), Posn(x=0, y=0)]
# [Posn(x=0, y=1), Posn(x=1, y=0), Posn(x=0, y=0)]
# [Posn(x=1, y=1), Posn(x=0, y=1), Posn(x=1, y=0), Posn(x=0, y=0)]

def translate_posn(posn : Posn) -> Posn:
    '''
    translates input posn by one unit in positive y direction
    
    Parameters:
     - Posn(x=x_a, y=y_b)

    Returns:
     - Posn(x=x_a, y=(y_b + 1)
    '''
    return Posn(x=posn.x,
                y=(posn.y + 1))

def test_translate_posn():
    assert translate_posn(Posn(x=0, y=0)) == Posn(x=0, y=1)
    assert translate_posn(Posn(x=-1, y=-1)) == Posn(x=-1, y=0)
    assert translate_posn(Posn(x=10, y=12)) == Posn(x=10, y=13)

def translate(list_of_posn : List[Posn]) -> List[Posn]:
    match list_of_posn:
        case []:
            return []
        case [first_posn, *rest_list_of_posn]:
            return cons(translate_posn(first_posn),
                        translate(rest_list_of_posn))

def test_translate():
    assert translate([]) == []
    assert translate([Posn(x=0, y=0)]) == [Posn(x=0, y=1)]
    assert translate([Posn(x=1, y=0)]) == [Posn(x=1, y=1)]
    assert translate([Posn(x=1, y=0), Posn(x=0, y=0)]) == [Posn(x=1, y=1), Posn(x=0, y=1)]
    assert translate([Posn(x=-1, y=-1), Posn(x=1, y=0), Posn(x=0, y=0)]) == [Posn(x=-1, y=0), Posn(x=1, y=1), Posn(x=0, y=1)]

def translate_map(list_of_posn : List[Posn]) -> List[Posn]:
    return list(map(translate_posn, list_of_posn))

def test_translate_map():
    assert translate_map([]) == []
    assert translate_map([Posn(x=0, y=0)]) == [Posn(x=0, y=1)]
    assert translate_map([Posn(x=1, y=0)]) == [Posn(x=1, y=1)]
    assert translate_map([Posn(x=1, y=0), Posn(x=0, y=0)]) == [Posn(x=1, y=1), Posn(x=0, y=1)]
    assert translate_map([Posn(x=-1, y=-1), Posn(x=1, y=0), Posn(x=0, y=0)]) == [Posn(x=-1, y=0), Posn(x=1, y=1), Posn(x=0, y=1)]
