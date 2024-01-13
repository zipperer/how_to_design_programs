from python_list_utilities import cons, EMPTY_LIST

# Exercise 147
# Develop a data definition for NEList-of-Booleans, a representation of non-empty lists of Boolean values.
# Then redesign the functions all-true and one-true from exercise 140.

## Exercise 140
## Design the function all-true, which consumes a list of Boolean values and determines whether all of them are #true.
## In other words, if there is any #false on the list, the function produces #false.

## Now design one-true, a function that consumes a list of Boolean values and
## determines whether at least one item on the list is #true. 

# An NEList-of-Booleans is one of:
# - cons(Boolean, EMPTY_LIST)
# - cons(Boolean, NEList-of-Booleans)

def all_true(ne_list_of_booleans) -> bool:
    match ne_list_of_booleans:
        case [single_boolean]:
            return single_boolean
        case [first_boolean, *rest_booleans]:
            return (first_boolean and
                    all_true(rest_booleans))

def one_true(ne_list_of_booleans) -> bool:
    match ne_list_of_booleans:
        case [single_boolean]:
            return single_boolean
        case [first_boolean, *rest_booleans]:
            return (first_boolean or
                    one_true(rest_booleans))

import pytest

def test_all_true():
    assert all_true(cons(True, EMPTY_LIST)) == True
    assert all_true(cons(False, EMPTY_LIST)) == False
    assert all_true(cons(True, cons(False, EMPTY_LIST))) == False
    assert all_true(cons(True, cons(True, EMPTY_LIST))) == True
    assert all_true(cons(True, cons(True, cons(True, EMPTY_LIST)))) == True

def test_one_true():
    assert one_true(cons(True, EMPTY_LIST)) == True
    assert one_true(cons(False, EMPTY_LIST)) == False
    assert one_true(cons(True, cons(False, EMPTY_LIST))) == True
    assert one_true(cons(True, cons(True, EMPTY_LIST))) == True
    assert one_true(cons(True, cons(True, cons(True, EMPTY_LIST)))) == True
    assert one_true(cons(False, cons(False, cons(False, EMPTY_LIST)))) == False

