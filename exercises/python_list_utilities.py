from typing import Any, List

from posn import Posn

# should I use Tuple instead of List? is there an empty tuple?
# should I use ConsOrEmpty instead of List? see python_list_as_class_cons.py
def cons(value : Any,
         given_list : List
         ) -> List:
    '''
      make list from `value` and `given_list`.
      `value` is first element in new list.
     # to confirm: result is new list
    '''
    # return list(value) + given_list # does not work, b/c when call cons('Mercury', []) get ['M', 'e', 'r', 'c', 'u', 'r', 'y']
    # return concatenate([value], given_list) # works
    return [value] + given_list

def list_concatenate(list1 : List,
                list2 : List
                ) -> List:
    return list1 + list2

def list_append(list1 : List,
                list2 : List
                ) -> List:
    return concatenate(list1, list2)

EMPTY_LIST = list() # type: ignore

def empty(value : Any) -> bool:
    return value == EMPTY_LIST

import pytest

def test_cons():
    assert cons('a', list()) == ['a']
    assert cons('a', list()) == list('a')
    assert (cons('a', list()) is list('a')) == False # the == above is element by element equality, not object identity
    assert (cons('a', cons('b', list()))) == ['a', 'b']
    assert (cons('a', ['b'])) == ['a', 'b']
    my_list_a = ['a']
    # equals between lists with same elements
    assert my_list_a == ['a']
    # two lists not identical
    assert my_list_a is not ['a']
    my_list_a_in_list = [my_list_a]
    # inner list is object equal
    assert my_list_a_in_list[0] is my_list_a
    # equals between lists with same elements
    assert my_list_a_in_list == [['a']]
    # inner list is object equal after cons
    assert cons('c', my_list_a_in_list)[1] is my_list_a
    # given 'inner list is object equal after cons', hypothesis:
    #   cons does not make a new copy of the input list


def test_concatenate():
    assert list_concatenate([], []) == list()
    assert list_concatenate([], ['a']) == list('a')
    assert list_concatenate([], cons('a', list())) == list('a')
    assert list_concatenate(cons('a', list()), []) == list('a')
    assert list_concatenate(cons('a', list()), list()) == list('a')
    assert list_concatenate(cons('a', list()), cons('b', list())) == ['a', 'b']
    assert list_concatenate(cons('a', list()), cons('b', list())) == ['a', 'b']
    
def test_empty():
    assert list() == EMPTY_LIST
    assert 5 != EMPTY_LIST
    assert 'hello world' != EMPTY_LIST
    assert cons(1, EMPTY_LIST) != EMPTY_LIST
    assert Posn(0, 0) != EMPTY_LIST
