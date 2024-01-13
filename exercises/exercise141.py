from typing import List
from python_list_utilities import EMPTY_LIST, cons

def cat(list_of_strings : List[str]) -> str:
    '''
    concatenates elements of list_of_strings into one string
    '''
    match list_of_strings:
        case []:
            return ''
        case [first_string, *rest_strings]:
            return first_string + cat(rest_strings)

def cat_by_join(list_of_strings : List[str]) -> str:
    return str.join('', list_of_strings)
            
def cat_by_join_alternative(list_of_strings : List[str]) -> str:
    return ''.join(list_of_strings)

import pytest

def test_cat():
    assert cat(EMPTY_LIST) == ''
    assert cat(cons('a', EMPTY_LIST)) == 'a'
    assert cat(cons('b', cons('a', EMPTY_LIST))) == 'ba'
    assert cat(cons('c', cons('a', cons('b', EMPTY_LIST)))) == 'cab'

def test_cat_by_join():
    assert cat_by_join(EMPTY_LIST) == ''
    assert cat_by_join(cons('a', EMPTY_LIST)) == 'a'
    assert cat_by_join(cons('b', cons('a', EMPTY_LIST))) == 'ba'
    assert cat_by_join(cons('c', cons('a', cons('b', EMPTY_LIST)))) == 'cab'

def test_cat_by_join_alternative():
    assert cat_by_join_alternative(EMPTY_LIST) == ''
    assert cat_by_join_alternative(cons('a', EMPTY_LIST)) == 'a'
    assert cat_by_join_alternative(cons('b', cons('a', EMPTY_LIST))) == 'ba'
    assert cat_by_join_alternative(cons('c', cons('a', cons('b', EMPTY_LIST)))) == 'cab'
