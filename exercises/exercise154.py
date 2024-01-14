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

import pytest

def test_colors():
    assert colors('yellow') == 'yellow'
    assert colors(Layer(color='green', doll='yellow')) == 'green, yellow'
    assert colors(Layer(color='red', doll=Layer(color='green', doll='yellow'))) == 'red, green, yellow'
