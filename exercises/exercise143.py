# Exercise 143
# Determine how average behaves in DrRacket when applied to the empty list.
# Then design checked-average, a function that produces an informative error message when it is applied to '(). 

from typing import List
from typing_common import Number

def average_temperature(list_of_temperatures : List[Number]) -> Number:
    return (sum(list_of_temperatures) / len(list_of_temperatures))

# >>> average_temperature([])
# Traceback (most recent call last):
#  File "<stdin>", line 1, in <module>
#  File "../how_to_design_programs/exercises/exercise143.py", line 9, in average_temperature
#    return (sum(list_of_temperatures) / len(list_of_temperatures))
# ZeroDivisionError: division by zero

def checked_average_temperature(list_of_temperatures : List[Number]) -> Number:
    if len(list_of_temperatures) == 0: # alternative to empty()
        raise Exception('Average expects list with elements, i.e. non-empty list')
    else:
        return average_temperature(list_of_temperatures)

import pytest

def test_checked_average():
    with pytest.raises(Exception):
        assert checked_average_temperature([]) == 'placeholder value'
    assert checked_average_temperature([1]) == 1.0
    assert checked_average_temperature([1, 2]) == 1.5
    assert checked_average_temperature([1, 2, 3]) == 2.0
