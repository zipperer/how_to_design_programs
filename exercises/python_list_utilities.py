from typing import Any, List

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

def concatenate(list1 : List,
                list2 : List
                ) -> List:
    return list1 + list2

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
    assert concatenate([], []) == list()
    assert concatenate([], ['a']) == list('a')
    assert concatenate([], cons('a', list())) == list('a')
    assert concatenate(cons('a', list()), []) == list('a')
    assert concatenate(cons('a', list()), list()) == list('a')
    assert concatenate(cons('a', list()), cons('b', list())) == ['a', 'b']
    assert concatenate(cons('a', list()), cons('b', list())) == ['a', 'b']
