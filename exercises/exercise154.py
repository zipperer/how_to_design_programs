# Exercise 154
# Design the function colors. 
# It consumes a Russian doll and produces a string of all colors, separated by a comma and a space. 
# Thus our example should produce: "yellow, green, red"

from dataclasses import dataclass
from typing import Any

@dataclass
class Layer:
    color: Any
    doll: Any

# A RussianDoll is one of:
# - str
# - Layer(color : str, doll : RussianDoll)

def colors(russian_doll # : RussianDoll
           ) -> str:
    match russian_doll:
        case str(russian_doll_color):
            return russian_doll_color
        case Layer(color=russian_doll_color, doll=russian_doll_inner_doll):
            return russian_doll_color + ', ' + colors(russian_doll_inner_doll)

def inner(russian_doll # : RussianDoll
          ) -> str:
    #breakpoint()
    match russian_doll:
        case str(russian_doll_color):
            return russian_doll_color
        case Layer(doll=russian_doll_inner_doll):
            return inner(russian_doll_inner_doll)
        
import pytest

def test_colors():
    assert colors('yellow') == 'yellow'
    assert colors(Layer(color='green', doll='yellow')) == 'green, yellow'
    assert colors(Layer(color='red', doll=Layer(color='green', doll='yellow'))) == 'red, green, yellow'

def test_inner():
    assert inner('yellow') == 'yellow'
    assert inner(Layer(color='green', doll='yellow')) == 'yellow'
    assert inner(Layer(color='red', doll=Layer(color='green', doll='yellow'))) == 'yellow'    
    assert inner(Layer(color='yellow', doll='green')) == 'green'
    assert inner(Layer(color='yellow', doll=Layer(color='green', doll='red'))) == 'red'
