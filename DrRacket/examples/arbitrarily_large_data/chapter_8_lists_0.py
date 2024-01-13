from typing import Any, List, Union

EMPTY_LIST = list() # type: ignore

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

def empty(value : Any) -> bool:
    return value == EMPTY_LIST

def first(input_list : List) -> Any:
    if empty(input_list):
        raise Exception('first expects non-empty list')
    else:
        return input_list[0]

def first_match(input_list : List) -> Any:
    match input_list:
        case []:
            raise Exception('first expects non-empty list')
        case _: # this relies on external type checking. i.e. the body of the function does not enforce that the value will be a list. see first_match_checking_type
            return input_list[0]

def first_match_checking_type(input_list : List) -> Any:
    match input_list:
        case []:
            raise Exception('first expects non-empty list')
        case list():
            return input_list[0]
        case _:
            raise Exception('first expects list')

def rest(input_list : List) -> List:
    if empty(input_list): # not sure what to do for this case
        return EMPTY_LIST
    else:
        return input_list[1:]

def rest_match(input_list : List) -> List:
    match input_list:
        case []: # not sure what to do for this case
            return list()
        case [first_element_in_list, *rest_of_list]:
            return rest_of_list
        case _:
            raise Exception('rest expects list')

def contains_flatt_if(input_list : List) -> bool:
    if empty(input_list):
        return False
    elif first(input_list) == 'Flatt':
        return True
    else:
        return contains_flatt_if(rest(input_list))

def contains_name_if(input_list : List,
                     name : Any
                     ) -> bool:
    if empty(input_list):
        return False
    elif input_list[0] == name:
        return True
    else:
        return contains_name_if(rest(input_list), name)

# def contains_flatt_match_0(input_list : List) -> bool:
#     match input_list:
#         case list():
#             return False
#         case ['Flatt':remaining_list]: # incorrect sytnax. see contains_flatt_match{,_1}
#             return True
#         case _:
#             return contains_flatt_match(rest(input_list))


def contains_flatt_match_1(input_list : List) -> bool:
    match input_list:
        case list(): # this matches any list, e.g. it matches ['Flatt'], so this case matches more than I intended
            return False
        case ['Flatt', *remaining_list]: # https://peps.python.org/pep-0636/#matching-multiple-values
            return True
        case _:
            return contains_flatt_match(rest(input_list))
        
def contains_flatt_match(input_list : List) -> bool:
    # breakpoint() # exercise 135
    match input_list:
        case []:
            return False
        case ['Flatt', *remaining_list]: # https://peps.python.org/pep-0636/#matching-multiple-values
            return True
        case _:
            return contains_flatt_match(rest(input_list))

def contains_flatt_match_or(input_list : List) -> bool:
    # breakpoint() # exercise 135
    match input_list:
        case []:
            return False
        case list():
            return ((first(input_list) == 'Flatt') or
                    contains_flatt_match_or(rest(input_list)))

# Exercise 135:
#...
# use the stepper to determine the value of
# (contains-flatt?
#   (cons "A" (cons "Flatt" (cons "C" '()))))
# ...
#root@b8566b142e10:/how_to_design_programs/exercises# python3 -i ../DrRacket/examples/arbitrarily_large_data/chapter_8_lists_0.py
#>>> contains_flatt_match_or(cons('a', cons('Flatt', cons('c', list()))))
# ...
#>>> contains_flatt_match_or(cons('a', cons('b', cons('c', list()))))
# ...

def contains_name_match(input_list : List,
                        name : Any
                        ) -> bool:
    match input_list:
        case []:
            return False
        case [first_element, *remaining_list] if first_element == name:
            return True
        case _:
            return contains_name_match(rest(input_list), name)

# List-of-strings -> Number
# determines how many strings are in a list of strings
def how_many(a_list_of_strings : List) -> int:
    match a_list_of_strings:
        case []:
            return 0
        case _:
            return 1 + how_many(rest(a_list_of_strings))

# Exercise 138
# Here is a data definition for representing sequences of amounts of money:
# A List-of-amounts is one of: 
# – '()
# – (cons PositiveNumber List-of-amounts)
# Create some examples to make sure you understand the data definition. 
# '() is a List-of-amounts
# (cons 1 '()) is a List-of-amounts
# (cons 2 (cons 1 '())) is a List-of-amounts
# Also add an arrow for the self-reference.
# - Arrow from List-of-amounts in (cons PositiveNumber List-of-amounts) to List-of-amounts in 'A List-of-amounts is one of:...'
# Design the sum function, which consumes a List-of-amounts and computes the sum of the amounts. 
# Use DrRacket’s stepper to see how (sum l) works for a short list l in List-of-amounts. 

Number = Union[int,float]

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

def sum_list_of_amounts_if(list_of_amounts : List[Number]) -> Number:
    if empty(list_of_amounts):
        return 0
    else:
        return first(list_of_amounts) + sum_list_of_amounts_if(rest(list_of_amounts))

import pytest

def test_contains_flatt_match():
    assert contains_flatt_match(cons('Flatt', EMPTY_LIST)) == True
    assert contains_flatt_match(cons('Krishnamurthi', cons('Flatt', EMPTY_LIST))) == True
    assert contains_flatt_match(EMPTY_LIST) == False
    assert contains_flatt_match(cons('Krishnamurthi', cons('Flatt', cons('Findler', EMPTY_LIST)))) == True
    assert contains_flatt_match(cons("Fagan",
                                     cons("Findler",
                                          cons("Fisler",
                                               cons("Flanagan",
                                                    cons("Flatt",
                                                         cons("Felleisen",
                                                              cons("Friedman", EMPTY_LIST)))))))) == True
                                
def test_contains_name_match():
    assert contains_name_match(cons('Flatt', EMPTY_LIST), 'Flatt') == True
    assert contains_name_match(cons('Krishnamurthi', cons('Flatt', EMPTY_LIST)), 'Flatt') == True
    assert contains_name_match(EMPTY_LIST, 'Flatt') == False
    assert contains_name_match(cons('Krishnamurthi', cons('Flatt', cons('Findler', EMPTY_LIST))), 'Flatt') == True

def test_contains_name_if():
    assert contains_name_if(cons('Flatt', EMPTY_LIST), 'Flatt') == True
    assert contains_name_if(cons('Krishnamurthi', cons('Flatt', EMPTY_LIST)), 'Flatt') == True
    assert contains_name_if(EMPTY_LIST, 'Flatt') == False
    assert contains_name_if(cons('Krishnamurthi', cons('Flatt', cons('Findler', EMPTY_LIST))), 'Flatt') == True
        
def test_rest_match():
    assert rest_match(cons('Flatt', EMPTY_LIST)) == EMPTY_LIST
    assert rest_match(cons('Krishnamurthi', cons('Flatt', EMPTY_LIST))) == cons('Flatt', EMPTY_LIST)    
    assert rest_match(cons('Krishnamurthi', cons('Flatt', cons('Findler', EMPTY_LIST)))) == cons('Flatt', cons('Findler', EMPTY_LIST))

def test_how_many():
    assert how_many(EMPTY_LIST) == 0
    assert how_many(cons('Flatt', EMPTY_LIST)) == 1
    assert how_many(cons('Krishnamurthi', cons('Flatt', EMPTY_LIST))) == 2
    assert how_many(cons('Krishnamurthi', cons('Flatt', cons('Findler', EMPTY_LIST)))) == 3

def test_sum_list_of_amounts():
    assert sum_list_of_amounts(EMPTY_LIST) == 0
    assert sum_list_of_amounts(cons(1, EMPTY_LIST)) == 1
    assert sum_list_of_amounts(cons(2, cons(1, EMPTY_LIST))) == 3
    assert sum_list_of_amounts(cons(10, cons(9, cons(8, cons(4, EMPTY_LIST))))) == 31

def test_sum_list_of_amounts_if():
    assert sum_list_of_amounts_if(EMPTY_LIST) == 0
    assert sum_list_of_amounts_if(cons(1, EMPTY_LIST)) == 1
    assert sum_list_of_amounts_if(cons(2, cons(1, EMPTY_LIST))) == 3
    assert sum_list_of_amounts_if(cons(10, cons(9, cons(8, cons(4, EMPTY_LIST))))) == 31
