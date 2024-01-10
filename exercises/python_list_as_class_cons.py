from dataclasses import dataclass
from typing import Any, Union, Literal

#EMPTY = 'empty list'

@dataclass
class Cons:
    first : Any
    rest : ConsOrEmpty

#ConsOrEmpty = Union[Cons, EMPTY]
#ConsOrEmpty = Union[Cons, Literal[EMPTY]]
ConsOrEmpty = Union[Cons, Literal['empty list']]

def first(cons : Cons) -> Any:
    return cons.first

def rest(cons : Cons) -> ConsOrEmpty:
    return cons.rest

def cons(value : Any,
         rest : ConsOrEmpty
         ) -> Cons:
    return Cons(first=value, rest=rest)

def empty(value : Any) -> bool:
    return value == 'empty list'

import pytest

def test_cons_functions():
    assert isinstance(Cons(1, 'empty list'), Cons) == True
    assert isinstance('empty list', Cons) == False
    assert first(Cons(1, 'empty list')) == 1
    assert rest(Cons(1, 'empty list')) == 'empty list'
    
