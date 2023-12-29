from posn import Posn
from typing_common import Number


# Exercise 73. 
# Design the function posn-up-x, which consumes a Posn p and a Number n. 
# It produces a Posn like p with n in the x field.

# Posn Number -> Posn
# produces Posn with n in x field and (posn-y p) in y field
# def posn_up_x(p : Posn,
#               n : Number
#              ) -> Posn:
#  return ... p.x ... n ... p.y

def posn_up_x(p : Posn,
              n : Number
              ) -> Posn:
  return Posn(x=n, y=p.y)

# A neat observation is that we can define x+ using posn-up-x:

# Posn -> Posn
# increases the x-coordinate of p by 3
#(check-expect (x+ (make-posn 10 0)) (make-posn 13 0))
# (define (x+ p)
#   (... (posn-x p) ... (posn-y p) ...))
# def x_plus(p : Posn) -> Posn:
#   return ... p.x ... p.y ...

def x_plus(p : Posn) -> Posn:
    return posn_up_x(p, (p.x + 3))

#Note: 
# Functions such as posn-up-x are often called updaters or functional setters. 
# They are extremely useful when you write large programs. 

import pytest

example_posn = Posn(x=10, y=20)

def test_posn_up_x():   
    assert posn_up_x(example_posn, 3) == Posn(3, example_posn.y)
    assert posn_up_x(example_posn, 15) == Posn(15, example_posn.y)

def test_x_plus():
    assert x_plus(Posn(x=10, y=0)) == Posn(x=13, y=0)
    assert x_plus(Posn(x=25, y=10)) == Posn(x=28, y=10)
