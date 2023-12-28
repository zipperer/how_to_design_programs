from dataclasses import dataclass
from posn import Posn
from typing_common import Number

@dataclass
class Velocity:
    deltax : Number
    deltay : Number

@dataclass
class Ball:
    location: Posn
    velocity: Velocity

BALL1 = Ball(Posn(x=30, y=40),
             Velocity(deltax=-10, deltay=5))

# For interpretation of BALL1, see exercise68.rkt

# Exercise 68.
# An alternative to the nested data representation of balls uses four fields to keep track of the four properties:
@dataclass
class BallF:
    x : Number
    y : Number
    deltax : Number
    deltay : Number

# Programmers call this a flat representation.
# Create an instance of ballf that has the same
# interpretation as ball1.

BALLF1 = BallF(x=30, 
               y=40,
               deltax=-10,
               deltay=5)
