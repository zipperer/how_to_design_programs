from python_list_utilities import cons, rest, EMPTY_LIST
from typing import List
# Exercise 140
# Design the function all-true, which consumes a list of Boolean values and determines whether all of them are #true.
# In other words, if there is any #false on the list, the function produces #false.

# A List-of-booleans is one of:
# - [] # i.e. EMPTY_LIST
# - cons(Boolean, List-of-booleans)
# <arrow from List-of-booleans in second clause to List-of-booleans in definition>
# Examples:
# EMPTY_LIST is a List-of-booleans
# cons(True, EMPTY_LIST) is a List-of-booleans
# cons(False, cons(True EMPTY_LIST)) is a List-of-booleans

# List-of-booleans -> Boolean
# determines whether each entry in list is True
def all_true(list_of_booleans : List[bool]) -> bool:
    #breakpoint()
    match list_of_booleans:
        case []:
            return True
        case [first_boolean, *rest_booleans]:
            return (first_boolean and all_true(rest(list_of_booleans)))

def all_true_all_builtin(list_of_booleans: List[bool]) -> bool:
    #breakpoint()
    return all(list_of_booleans)

# Now design one-true, a function that consumes a list of Boolean values and determines whether at
# least one item on the list is #true.

# List-of-booleans -> Boolean
# determines whether at least one element in list is #true
def one_true(list_of_booleans : List[bool]) -> bool:
    #breakpoint()
    match list_of_booleans:
        case []:
            return False
        case [first_boolean, *rest_booleans]:
            return (first_boolean or one_true(rest(list_of_booleans)))

def one_true_any_builtin(list_of_booleans : List[bool]) -> bool:
    #breakpoint()
    return any(list_of_booleans)

import pytest

def test_all_true():
    assert all_true(EMPTY_LIST) == True
    assert all_true(cons(True, EMPTY_LIST)) == True
    assert all_true(cons(False, EMPTY_LIST)) == False
    assert all_true(cons(True, cons(False, EMPTY_LIST))) == False
    assert all_true(cons(True, cons(True, EMPTY_LIST))) == True
    assert all_true(cons(True, cons(True, cons(True, EMPTY_LIST)))) == True

def test_all_true_all_builtin():
    assert all_true_all_builtin(EMPTY_LIST) == True
    assert all_true_all_builtin(cons(True, EMPTY_LIST)) == True
    assert all_true_all_builtin(cons(False, EMPTY_LIST)) == False
    assert all_true_all_builtin(cons(True, cons(False, EMPTY_LIST))) == False
    assert all_true_all_builtin(cons(True, cons(True, EMPTY_LIST))) == True
    assert all_true_all_builtin(cons(True, cons(True, cons(True, EMPTY_LIST)))) == True

def test_one_true():
    assert one_true(EMPTY_LIST) == False
    assert one_true(cons(True, EMPTY_LIST)) == True
    assert one_true(cons(False, EMPTY_LIST)) == False
    assert one_true(cons(True, cons(False, EMPTY_LIST))) == True
    assert one_true(cons(True, cons(True, EMPTY_LIST))) == True
    assert one_true(cons(True, cons(True, cons(True, EMPTY_LIST)))) == True
    assert one_true(cons(False, cons(False, cons(False, EMPTY_LIST)))) == False

def test_one_true_any_builtin():
    assert one_true_any_builtin(EMPTY_LIST) == False
    assert one_true_any_builtin(cons(True, EMPTY_LIST)) == True
    assert one_true_any_builtin(cons(False, EMPTY_LIST)) == False
    assert one_true_any_builtin(cons(True, cons(False, EMPTY_LIST))) == True
    assert one_true_any_builtin(cons(True, cons(True, EMPTY_LIST))) == True
    assert one_true_any_builtin(cons(True, cons(True, cons(True, EMPTY_LIST)))) == True
    assert one_true_any_builtin(cons(False, cons(False, cons(False, EMPTY_LIST)))) == False
    
