from python_list_utilities import cons, first, rest, EMPTY_LIST, empty
from typing_common import Number
from typing import List
# Exercise 139
# Now take a look at this data definition:
# A List-of-numbers is one of: 
# – '()
# – (cons Number List-of-numbers)

# Some elements of this class of data are appropriate inputs for sum from exercise 138 and some aren’t.
# Design the function pos?, which consumes a List-of-numbers and determines whether all numbers are positive numbers. 
# In other words, if (pos? l) yields #true, then l is an element of List-of-amounts. 
# Use DrRacket’s stepper to understand how pos? works for (cons 5 '()) and (cons -1 '()).

def all_pos(list_of_numbers : List[Number]) -> bool:
    match list_of_numbers:
        case []:
            return True
        case [first_number, *rest_of_numbers]:
            return ((first_number >= 0) and
                    all_pos(rest_of_numbers))

def all_pos_if(list_of_numbers : List[Number]) -> bool:
    if empty(list_of_numbers):
        return True
    else:
        return ((first(list_of_numbers) >= 0) and
                (all_pos_if(rest(list_of_numbers))))

def all_pos_map(list_of_numbers: List[Number]) -> bool:
    return all(map(lambda number: (number >= 0), list_of_numbers))

def all_pos_map_with_local(list_of_numbers: List[Number]) -> bool:
    def number_greater_than_zero(number : Number) -> bool:
        return (number >= 0)
    return all(map(number_greater_than_zero, list_of_numbers))

# Also design checked-sum. 
# The function consumes a List-of-numbers. 
# It produces their sum if the input also belongs to List-of-amounts; otherwise it signals an error. 
# Hint: Recall to use check-error.
def checked_sum(list_of_numbers : List[Number]) -> Number:
    '''
    compute sum of list_of_numbers if all numbers greater than 0.
    otherwise, error
    '''
    if all_pos(list_of_numbers):
        return sum_list_of_amounts(list_of_numbers)
    else:
        raise Exception('sum_list_of_amounts expects each number is positive')

def sum_list_of_amounts(list_of_amounts : List[Number]) -> Number:
    '''
    computes sum of numbers in list_of_amounts
    '''
    #breakpoint()
    match list_of_amounts:
        case []:
            return 0
        case [first_amount, *rest_of_amounts]:
            return first_amount + sum_list_of_amounts(rest_of_amounts)

# What does sum compute for an element of List-of-numbers? 
# The sum of the positive numbers minus the sum of the negative numbers
import pytest

def test_all_pos():
    assert all_pos(EMPTY_LIST) == True
    assert all_pos(cons(1, EMPTY_LIST)) == True
    assert all_pos(cons(-1, EMPTY_LIST)) == False
    assert all_pos(cons(2, cons(1, EMPTY_LIST))) == True
    assert all_pos(cons(2, cons(-1, EMPTY_LIST))) == False

def test_all_pos_if():
    assert all_pos_if(EMPTY_LIST) == True
    assert all_pos_if(cons(1, EMPTY_LIST)) == True
    assert all_pos_if(cons(-1, EMPTY_LIST)) == False
    assert all_pos_if(cons(2, cons(1, EMPTY_LIST))) == True
    assert all_pos_if(cons(2, cons(-1, EMPTY_LIST))) == False   

def test_all_pos_map():
    assert all_pos_map(EMPTY_LIST) == True
    assert all_pos_map(cons(1, EMPTY_LIST)) == True
    assert all_pos_map(cons(-1, EMPTY_LIST)) == False
    assert all_pos_map(cons(2, cons(1, EMPTY_LIST))) == True
    assert all_pos_map(cons(2, cons(-1, EMPTY_LIST))) == False

def test_all_pos_map_with_local():
    assert all_pos_map_with_local(EMPTY_LIST) == True
    assert all_pos_map_with_local(cons(1, EMPTY_LIST)) == True
    assert all_pos_map_with_local(cons(-1, EMPTY_LIST)) == False
    assert all_pos_map_with_local(cons(2, cons(1, EMPTY_LIST))) == True
    assert all_pos_map_with_local(cons(2, cons(-1, EMPTY_LIST))) == False

def test_checked_sum():
    with pytest.raises(Exception):
        assert checked_sum(cons(-1, EMPTY_LIST)) == 'placeholder value'
    with pytest.raises(Exception):
        assert checked_sum(cons(2, cons(-1, EMPTY_LIST))) == 'placeholder value'    
    assert checked_sum(EMPTY_LIST) == 0
    assert checked_sum(cons(1, EMPTY_LIST)) == 1
    assert checked_sum(cons(2, cons(1, EMPTY_LIST))) == 3

