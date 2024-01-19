from typing import Any, List

def member(element : Any,
           input_list : List[Any]
           ) -> bool:
    match input_list:
        case []:
            return False
        case [first_item_in_list, *rest_items_in_list] if first_item_in_list == element:
            return True
        case [first_item_in_list, *rest_items_in_list]:
            return member(element, rest_items_in_list)
        case _: # I added this for mypy. Without it: error: Missing return statement  [return]
            raise Exception('should not reach this case')

def length(input_list : List[Any]) -> int:
    match input_list:
        case []:
            return 0
        case [first_item_in_list, *rest_items_in_list]:
            return 1 + length(rest_items_in_list)
        case _: # I added this for mypy. Without it: error: Missing return statement  [return]
            raise Exception('should not reach this case')

def remove(element : Any,
           input_list : List[Any]
           ) -> List[Any]:
    match input_list:
        case []:
            return []
        case [first_item_in_list, *rest_items_in_list] if first_item_in_list == element:
            return rest_items_in_list
        case [first_item_in_list, *rest_items_in_list]:
            return [first_item_in_list] + remove(element, rest_items_in_list)
        case _: # I added this for mypy. Without it: error: Missing return statement  [return]
            raise Exception('should not reach this case')

def remove_all(element : Any,
               input_list : List[Any]
               ) -> List[Any]:
    match input_list:
        case []:
            return []
        case [first_item_in_list, *rest_items_in_list] if first_item_in_list == element:
            return remove_all(element, rest_items_in_list)
        case [first_item_in_list, *rest_items_in_list]:
            return [first_item_in_list] + remove_all(element, rest_items_in_list)
        case _: # I added this for mypy. Without it: error: Missing return statement  [return]
            raise Exception('should not reach this case')

def my_reverse(input_list : List[Any]) -> List[Any]:
    match input_list:
        case []:
            return []
        case [first_item_in_list, *rest_items_in_list]:
            return my_reverse(rest_items_in_list) + [first_item_in_list]
        case _: # I added this for mypy. Without it: error: Missing return statement  [return]
            raise Exception('should not reach this case')

import pytest

def test_member():
    assert member('a', list()) == False
    assert member('a', ['a']) == True
    assert member('a', ['b']) == False
    assert member('a', ['b', 'a']) == True
    assert member('a', ['c', 'b', 'a']) == True

def test_length():
    assert length([]) == 0
    assert length(['a']) == 1
    assert length(['b']) == 1
    assert length(['b', 'a']) == 2
    assert length(['c', 'b', 'a']) == 3

def test_remove():
    assert remove('a', list()) == list()
    assert remove('a', ['a']) == list()
    assert remove('a', ['b']) == ['b']
    assert remove('a', ['b', 'a']) == ['b']
    assert remove('a', ['c', 'b', 'a']) == ['c', 'b']
    assert remove('a', ['c', 'b', 'a', 'a']) == ['c', 'b', 'a']

def test_remove_all():
    assert remove_all('a', list()) == list()
    assert remove_all('a', ['a']) == list()
    assert remove_all('a', ['b']) == ['b']
    assert remove_all('a', ['b', 'a']) == ['b']
    assert remove_all('a', ['c', 'b', 'a']) == ['c', 'b']
    assert remove_all('a', ['c', 'b', 'a', 'a']) == ['c', 'b']
    assert remove_all('a', ['a', 'c', 'b', 'a', 'a']) == ['c', 'b']
    
def test_my_reverse():
    assert my_reverse(list()) == list()
    assert my_reverse(['a']) == ['a']
    assert my_reverse(['b']) == ['b']
    assert my_reverse(['b', 'a']) == ['a', 'b']
    assert my_reverse(['c', 'b', 'a']) == ['a', 'b' , 'c']
    assert my_reverse(['c', 'b', 'a', 'a']) == ['a', 'a', 'b', 'c']
    assert my_reverse(['a', 'c', 'b', 'a', 'a']) == ['a', 'a', 'b', 'c', 'a']
    
