# Exercise 112
# Reformulate the predicate (missile-or-not?-cond)
# using an or expression. 

from posn import Posn
from typing import Any

def is_missile_or_not_match(value : Any) -> bool:
     match value:
         case False:
             return True
         case Posn():
             return True
         case _:
             return False

def is_missile_or_not_or(value : Any) -> bool:
    return ((value is False) or 
            isinstance(value, Posn))

def example_match_false(example_input):
    match example_input:
        case False:
            return 'matched false'
        case _:
            return 'did not match false'

import pytest        

def test_example_match_false():
    assert example_match_false(False) == 'matched false'
    assert example_match_false(True) == 'did not match false'

def test_is_missile_or_not_match():
    assert is_missile_or_not_match(False) == True
    assert is_missile_or_not_match(True) == False
    assert is_missile_or_not_match(Posn(x=1, y=2)) == True
    assert is_missile_or_not_match(Exception) == False
    assert is_missile_or_not_match(1) == False

def test_is_missile_or_not_or():
    assert is_missile_or_not_or(False) == True
    assert is_missile_or_not_or(True) == False
    assert is_missile_or_not_or(Posn(x=1, y=2)) == True
    assert is_missile_or_not_or(Exception) == False
    assert is_missile_or_not_or(1) == False
