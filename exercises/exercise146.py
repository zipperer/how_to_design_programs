# Exercise 146
# Design how-many for NEList-of-temperatures.

# A NonEmptyList is one of:
# - (cons Any '())
# - (cons Any NonEmptyList)
# alternative notation:
# - cons(Any, EMPTY_LIST)
# - cons(Any, NonEmptyList)

def how_many(non_empty_list # : NonEmptyList
             ) -> int:
    match non_empty_list:
        case [single_element]:
            return 1
        case [first_element, *remaining_elements]:
            return 1 + how_many(remaining_elements)

def how_many_len_builtin(non_empty_list # : NonEmptyList
                         ) -> int:
    return len(non_empty_list)

import pytest

def test_how_many():
    assert how_many(['a']) == 1
    assert how_many(['a', 'b']) == 2
    assert how_many(['a', 'b', 'c']) == 3

def test_how_many_len_builtin():
    assert how_many_len_builtin(['a']) == 1
    assert how_many_len_builtin(['a', 'b']) == 2
    assert how_many_len_builtin(['a', 'b', 'c']) == 3
    
