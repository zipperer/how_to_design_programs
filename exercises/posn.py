from dataclasses import dataclass
from typing import Union, Any
Number = Union[int,float]

from local_utilities import is_number

@dataclass
class Posn:
    x: Number
    y: Number

def is_posn(value : Any) -> bool:
    return (isinstance(value, Posn) and
            is_number(value.x) and
            is_number(value.y))

def make_posn(x : Number,
              y : Number
              ) -> Posn:
    return Posn(x=x, y=y)
