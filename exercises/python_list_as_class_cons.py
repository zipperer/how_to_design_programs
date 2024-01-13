from dataclasses import dataclass
from typing import Any, Union, Literal

#EMPTY = 'empty list'

#ConsOrEmpty = Union[Cons, EMPTY]
#ConsOrEmpty = Union[Cons, Literal[EMPTY]]
ConsOrEmpty = Union['Cons', Literal['empty list']] # 'Cons' rather than Cons to 'forward-declare' # https://mypy.readthedocs.io/en/stable/cheat_sheet_py3.html#forward-references

@dataclass
class Cons:
    first : Any
    rest : ConsOrEmpty 

def first(cons : Cons) -> Any:
    # breakpoint() # Exercise 136
    return cons.first

def rest(cons : Cons) -> ConsOrEmpty:
    # breakpoint() # Exercise 136
    return cons.rest

def cons(value : Any,
         rest : ConsOrEmpty
         ) -> Cons:
    return Cons(first=value, rest=rest)

def empty(value : Any) -> bool:
    '''
    I use "empty list" instead of a special constant like '().
    I don't yet know how to mimic in python a special constant like that.
    '''
    return value == 'empty list'


# Exercise 136
# (our-first (our-cons "a" '())) == "a"
# (our-rest (our-cons "a" '())) == '()
# root@b8566b142e10:/how_to_design_programs/exercises# python3 -i python_list_as_class_cons.py
# >>> first(cons('a', list()))
# ...
# >>> rest(cons('a', list()))
# ...


import pytest

def test_cons_functions():
    assert isinstance(Cons(1, 'empty list'), Cons) == True
    assert isinstance('empty list', Cons) == False
    assert first(Cons(1, 'empty list')) == 1
    assert rest(Cons(1, 'empty list')) == 'empty list'
