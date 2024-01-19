from typing import List, Any
from chapter_9_lists_5 import member, remove, remove_all
# from python_list_utilities import cons # cannot import b/c wrong directory

# List-of-string String -> N
# determines how often s occurs in los
def count_occurrences(s : str,
                      los : List[str]
                      ) -> int:
    match los:
        case []:
            return 0
        case [first_string_in_list, *rest_strings_in_list] if first_string_in_list == s:
            return 1 + count_occurrences(s, rest_strings_in_list)
        case [first_string_in_list, *rest_strings_in_list]:
            return count_occurrences(s, rest_strings_in_list)
        case _: # I added this for mypy. Without it: error: Missing return statement  [return]
            raise Exception('should not reach this case')

# python has set(). This file follows the steps in the book that
# use lists to represent sets.

EMPTY_SET : List[Any] = list()
# Son is an abbreviation for SetOfNumbers

# A Son.L is one of: 
# – EMPTY_SET
# – cons(Number, Son.L)
# 
# Son is used when it 
# applies to Son.L and Son.R
  
# A Son.R is one of: 
# – EMPTY_SET
# – cons(Number, Son.R)
# 
# Constraint If s is a Son.R, 
# no number occurs twice in s

def is_element_in_set(element : Any,
                      given_set : List[Any]
                      ) -> bool:
    return member(element, given_set)

def not_member_1(given_set : List[Any]) -> bool:
    '''
    True if 1 is not a member of given_set.
    False otherwise.
    '''
    return (not (is_element_in_set(1, given_set)))

def cons(element : Any,
         given_list : List[Any]
         ) -> List[Any]:
    return [element] + given_list

# Number Son.L -> Son.L
# removes x from s
# trying test in docstring (i.e. doctest) for fun.
# - see https://docs.python.org/3/library/doctest.html
# - run with $ python3 -m doctest [-v] chapter_9_lists_6.py
# - run with pytest $ python3 -m pytest --doctest-modules [-v] chapter_9_lists_6.py
def set_minus_L (element : Any,
                 given_set : List[Any]
                 ) -> List[Any]:
    '''
    >>> s1_L = cons(1, cons(1, EMPTY_SET))
    >>> assert set_minus_L(1, s1_L) == EMPTY_SET
    >>> set_minus_L(1, s1_L) == EMPTY_SET # alternative formulation of line above
    True
    >>> assert set_minus_L(1 , cons(1, cons(2, cons(3, EMPTY_SET)))) in [cons(2, cons(3, EMPTY_SET)), cons(3, cons(2, EMPTY_SET))]
    >>> not_member_1(set_minus_L(1 , cons(1, cons(2, cons(3, EMPTY_SET)))))
    True
    '''
    return remove_all(element, given_set)

# Number Son.R -> Son.R
# removes x from s
def set_minus_R (element : Any,
                 given_set : List[Any]
                 ) -> List[Any]:
    '''
    >>> s1_R = cons(1, EMPTY_SET)
    >>> assert set_minus_R(1, s1_R) == EMPTY_SET
    >>> set_minus_R(1, s1_R) == EMPTY_SET # alternative formulation of line above
    True
    >>> assert set_minus_R(1 , cons(1, cons(2, cons(3, EMPTY_SET)))) in [cons(2, cons(3, EMPTY_SET)), cons(3, cons(2, EMPTY_SET))]
    >>> not_member_1(set_minus_R(1 , cons(1, cons(2, cons(3, EMPTY_SET)))))
    True
    '''
    return remove(element, given_set)

# Exercise 160
# Design the functions set+.L and set+.R, which create a set by adding a number x to some 
# given set s for the left-hand and right-hand data definition, respectively. 

# Any Son.L -> Son.L
def set_plus_L(element : Any,
               given_set : List[Any]
               ) -> List[Any]:
    '''
    add element to given_set.
    Given that input set is Son.L, element may already occur in Son.L and adding
    another occurrence does not break any invariant/constraint.
    >>> set_plus_L(1, cons(1, EMPTY_SET)) == cons(1, cons(1, EMPTY_SET))
    True
    >>> count_occurrences(1, set_plus_L(1, cons(1, cons(2, cons(3, EMPTY_SET))))) == 1 + count_occurrences(1, cons(1, cons(2, cons(3, EMPTY_SET))))
    True
    '''
    return cons(element, given_set)

# Any Son.R -> Son.R
def set_plus_R(element : Any,
               given_set : List[Any]
               ) -> List[Any]:
    '''
    add element to given_set.
    Given that input set is Son.R, if element is already occur in Son.R then adding
    another occurrence breaks the constraint that each element occurs at most once.
    >>> set_plus_R(1, cons(1, EMPTY_SET)) == cons(1, EMPTY_SET)
    True
    >>> count_occurrences(1, set_plus_R(1, cons(1, cons(2, cons(3, EMPTY_SET))))) == count_occurrences(1, cons(1, cons(2, cons(3, EMPTY_SET))))
    True
    '''
    if is_element_in_set(element, given_set):
        return given_set
    else:
        return cons(element, given_set)

# pytest
def test_count_occurrences():
    assert count_occurrences("hello", []) == 0
    assert count_occurrences("hello", ["hello"]) == 1
    assert count_occurrences("hello", ["hello", "bye"]) == 1
    assert count_occurrences("hello", ["bye", "hello"]) == 1
    assert count_occurrences("hello", ["bye", "hello", "ciao"]) == 1
    assert count_occurrences("hello", ["bye", "hello", "ciao", "hello"]) == 2
    
