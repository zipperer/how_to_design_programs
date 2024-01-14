from python_list_utilities import cons, EMPTY_LIST
from typing import List, Any
from typing_common import Number
# An N is one of:
# - 0
# - (+ 1 N)
# interpretation:
#   represents the counting numbers
# e.g.
# 0 is an N
# (+ 1 0) is an N, i.e. 1
# (+ 1 (+ 1 0)) is an N, i.e. 2

# An N is one of:
# - 0
# - (add1 N)
# interpretation:
#   represents the counting numbers
# e.g.
# 0 is an N
# (add1 0) is an N, i.e. 1
# (add1 (add1 0)) is an N, i.e. 2

def is_zero(n : Any) -> bool:
    return n == 0

def add1(n : Number) -> Number:
    return 1 + n

def sub1(n : Number) -> Number:
    if is_zero(n):
        raise Exception('sub1 expects number greater than 0')
    else:
        return n - 1

def is_positive(n : Number) -> bool:
    return n > 0

# N String -> List-of-strings (i.e. List[str])
# creates a list of n occurrences of s
def their_make_list(n : Number, 
                    value : Any) -> List[Any]:
    if is_zero(n):
        return list()
    else: # i.e. is_positive(n)
        return cons(value, their_make_list(sub1(n), value))

import pytest

def test_their_make_list():
    assert their_make_list(0, "hello") == list()
    assert their_make_list(2, "hello") == ["hello", "hello"]
    assert their_make_list(2, "hello") == cons("hello", cons("hello", EMPTY_LIST))
