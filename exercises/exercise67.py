from dataclasses import dataclass
from typing import Union
Number = Union[int,float]

# Exercise 67. Here is another way to represent bouncing balls:
SPEED = 3

@dataclass
class Balld:
    location: Number
    direction: str

example_balld = Balld(location=10, direction='up')    
# Interpret this code fragment and create other instances of balld.

# example_balld is a Ball. It has location 10 and direction 'up'.
# All Balls have speed 3. So, example_balld is 10 pixels from the
# top of the canvas, moving toward the top of the canvas at 3
# pixels per clock tick.
