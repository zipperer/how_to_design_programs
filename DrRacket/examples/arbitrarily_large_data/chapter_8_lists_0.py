from typing import Any, List

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
        case _: # this relies on external type checking 
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
        return contains_flatt(rest(input_list))

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
#         case ['Flatt':remaining_list]:
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
    match input_list:
        case []:
            return False
        case ['Flatt', *remaining_list]: # https://peps.python.org/pep-0636/#matching-multiple-values
            return True
        case _:
            return contains_flatt_match(rest(input_list))

def contains_flatt_match_or(input_list : List) -> bool:
    match input_list:
        case []:
            return False
        case list():
            return ((first(input_list) == 'Flatt') or
                    contains_flatt_match_or(rest(input_list)))

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
                                                              cons("Friedman", EMPTY_LIST))))))) == True
                                
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
