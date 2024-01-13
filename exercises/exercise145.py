from python_list_utilities import EMPTY_LIST, rest, first, empty
from typing_common import Number
from typing import List
# Exercise 145
# Design the sorted>? predicate, which consumes a NEList-of-temperatures and produces #true
# if the temperatures are sorted in descending order. That is, if the second is smaller than the first, 
# the third smaller than the second, and so on. Otherwise it produces #false.

# CTemperature is a number greater than ABSOLUTE0.
ABSOLUTE0 = -272

# NEList-of-temperatures is one of:
# - cons(CTemperature, EMPTY_LIST)
# - cons(CTemperature, NEList-of-temperatures)

def sorted_greater_than(ne_list_of_temperatures : List[Number]) -> bool:
    match ne_list_of_temperatures:
        case [single_temperature_in_list]:
            return True
        case [first_temperature_in_list, *remaining_temperatures_in_list]:
            return ((first_temperature_in_list > first(remaining_temperatures_in_list)) and
                    sorted_greater_than(remaining_temperatures_in_list))

def sorted_greater_than_if(ne_list_of_temperatures : List[Number]) -> bool:
    if empty(rest(ne_list_of_temperatures)):
        return True
    else:
        return ((first(ne_list_of_temperatures) >
                 first(rest(ne_list_of_temperatures))) and
                sorted_greater_than_if(rest(ne_list_of_temperatures)))

def sorted_greater_than_sorted_builtin(ne_list_of_temperatures : List[Number]) -> bool:
    # Notes:
    # 1.
    # This function is correct but it scales worse than alternatives.
    # In particular, alternatives can check whether the list is sorted with linear time in worst case.
    # This function performs the sort, so this function does work: O((n*log(n)) + n), so O(n*log(n))
    # nlog(n) for sort and n for comparing the two lists element by element.
    # 2.
    # when reverse=False, sorted uses <. I provide reverse=True so it effectively uses >.
    return ne_list_of_temperatures == sorted(ne_list_of_temperatures, reverse=True) 

import pytest

def test_sorted_greater_than():
    assert sorted_greater_than([1]) == True
    assert sorted_greater_than([2, 1]) == True
    assert sorted_greater_than([1, 2]) == False
    assert sorted_greater_than([3, 2, 1]) == True
    assert sorted_greater_than([3, 1, 2]) == False

def test_sorted_greater_than_if():
    assert sorted_greater_than_if([1]) == True
    assert sorted_greater_than_if([2, 1]) == True
    assert sorted_greater_than_if([1, 2]) == False
    assert sorted_greater_than_if([3, 2, 1]) == True
    assert sorted_greater_than_if([3, 1, 2]) == False

def test_sorted_greater_than_sorted_builtin():
    assert sorted_greater_than_sorted_builtin([1]) == True
    assert sorted_greater_than_sorted_builtin([2, 1]) == True
    assert sorted_greater_than_sorted_builtin([1, 2]) == False
    assert sorted_greater_than_sorted_builtin([3, 2, 1]) == True
    assert sorted_greater_than_sorted_builtin([3, 1, 2]) == False
    
