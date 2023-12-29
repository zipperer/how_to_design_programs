from dataclasses import dataclass
from typing_common import Number

@dataclass
class Velocity:
    deltax: Number
    deltay: Number
