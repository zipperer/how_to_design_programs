from dataclasses import dataclass
from typing import Union
Number = Union[int,float]

@dataclass
class Posn:
    x: Number
    y: Number
