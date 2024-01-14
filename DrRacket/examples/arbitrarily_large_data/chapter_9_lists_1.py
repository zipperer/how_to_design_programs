from typing import List, Any
from typing_common import Number # wrong directory to import this
from python_list_utilities import cons, EMPTY_LIST # wrong director to import this
# Number Any -> List[Any]
def my_make_list(number_occurrences : Number,
                 value : Any
                 ) -> List[Any]:
    if (number_occurrences == 0):
        return list()
    else:
        #return [value] + my_make_list((number_occurrences - 1),
        #                              value)
        return cons(value, my_make_list((number_occurrences - 1),
                                        value))

# An N is one of:
# - 0
# - (+ 1 N)
# interpretation:
#   represents the counting numbers
# e.g.
# 0 is an N
# (+ 1 0) is an N, i.e. 1
# (+ 1 (+ 1 0)) is an N, i.e. 2

import pytest

def test_my_make_list():
    assert my_make_list(2, "hello") == ["hello", "hello"]
    assert my_make_list(2, "hello") == cons("hello", cons("hello", EMPTY_LIST))
    assert my_make_list(3, True) == [True, True, True]
    assert my_make_list(3, True) == cons(True, cons(True, cons(True, EMPTY_LIST)))
    assert my_make_list(0, 17) == list()
    assert my_make_list(0, 17) == []


    
