# Exercise 169. 
# Design the function legal. 
#   Like translate from exercise 168, the function consumes and produces a list of Posns. 
#   The result contains all those Posns whose:
#   - x-coordinates are between 0 and 100 and
#   - y-coordinates are between 0 and 200.

from typing import List
from posn import Posn
from typing_common import Number
from python_list_utilities import cons

POSN_LEGAL_X_LOWERBOUND = 0
POSN_LEGAL_X_UPPERBOUND = 100

def posn_legal_x(posn : Posn) -> bool:
    return ((POSN_LEGAL_X_LOWERBOUND <= posn.x) and
            (posn.x <= POSN_LEGAL_X_UPPERBOUND))

def test_posn_legal_x():
    assert posn_legal_x(Posn(x=0, y=0)) == True
    assert posn_legal_x(Posn(x=-1, y=0)) == False
    assert posn_legal_x(Posn(x=50, y=100)) == True
    assert posn_legal_x(Posn(x=100, y=200)) == True
    assert posn_legal_x(Posn(x=100, y=201)) == True
    assert posn_legal_x(Posn(x=101, y=201)) == False

POSN_LEGAL_Y_LOWERBOUND = 0
POSN_LEGAL_Y_UPPERBOUND = 200

def posn_legal_y(posn : Posn) -> bool:
    return ((POSN_LEGAL_Y_LOWERBOUND <= posn.y) and
            (posn.y <= POSN_LEGAL_Y_UPPERBOUND))

def test_posn_legal_y():
    assert posn_legal_y(Posn(x=0, y=0)) == True
    assert posn_legal_y(Posn(x=-1, y=0)) == True
    assert posn_legal_y(Posn(x=50, y=100)) == True
    assert posn_legal_y(Posn(x=100, y=200)) == True
    assert posn_legal_y(Posn(x=100, y=201)) == False

def posn_legal(posn : Posn) -> bool:
    return (posn_legal_x(posn) and
            (posn_legal_y(posn)))

def test_posn_legal():
    assert posn_legal(Posn(x=0, y=0)) == True
    assert posn_legal(Posn(x=-1, y=0)) == False
    assert posn_legal(Posn(x=50, y=100)) == True
    assert posn_legal(Posn(x=100, y=200)) == True
    assert posn_legal(Posn(x=100, y=201)) == False

def legal(list_of_posn : List[Posn]) -> List[Posn]:
    '''
    Parameters:
     - list_of_posn : List[Posn]
     -- list of Posn to filter to list of _legal_ posn

    Returns:
     - List[Posn]
     -- those Posn from the input list that are _legal_
    '''
    match list_of_posn:
        case []:
            return []
        case [first_posn, *rest_list_of_posn] if posn_legal(first_posn):
            return cons(first_posn, legal(rest_list_of_posn))
        case [first_posn, *rest_list_of_posn]:
            return legal(rest_list_of_posn)

def test_legal():
    assert legal([]) == []
    assert legal([Posn(x=0, y=0)]) == [Posn(x=0, y=0)]
    assert legal([Posn(x=0, y=0), Posn(x=-1, y=0)]) == [Posn(x=0, y=0)]
    assert legal([Posn(x=-1, y=0), Posn(x=0, y=0), Posn(x=-1, y=0)]) == [Posn(x=0, y=0)]
    assert legal([Posn(x=50, y=100), Posn(x=-1, y=0), Posn(x=0, y=0), Posn(x=-1, y=0)]) == [Posn(x=50, y=100), Posn(x=0, y=0)]
    assert legal([Posn(x=50, y=100), Posn(x=-1, y=0), Posn(x=0, y=0), Posn(x=-1, y=0), Posn(x=100, y=200)]) == [Posn(x=50, y=100), Posn(x=0, y=0), Posn(x=100, y=200)]
    assert legal([Posn(x=100, y=201), Posn(x=50, y=100), Posn(x=-1, y=0), Posn(x=0, y=0), Posn(x=-1, y=0), Posn(x=100, y=200)]) == [Posn(x=50, y=100), Posn(x=0, y=0), Posn(x=100, y=200)]
    assert legal([Posn(x=100, y=201), Posn(x=50, y=100), Posn(x=-1, y=0), Posn(x=0, y=0), Posn(x=-1, y=0), Posn(x=100, y=200), Posn(x=101, y=201)]) == [Posn(x=50, y=100), Posn(x=0, y=0), Posn(x=100, y=200)]


def legal_filter(list_of_posn : List[Posn]) -> List[Posn]:
    '''
    Parameters:
     - list_of_posn : List[Posn]
     -- list of Posn to filter to list of _legal_filter_ posn

    Returns:
     - List[Posn]
     -- those Posn from the input list that are _legal_filter_
    '''
    return list(filter(posn_legal, list_of_posn))

def test_legal_filter():
    assert legal_filter([]) == []
    assert legal_filter([Posn(x=0, y=0)]) == [Posn(x=0, y=0)]
    assert legal_filter([Posn(x=0, y=0), Posn(x=-1, y=0)]) == [Posn(x=0, y=0)]
    assert legal_filter([Posn(x=-1, y=0), Posn(x=0, y=0), Posn(x=-1, y=0)]) == [Posn(x=0, y=0)]
    assert legal_filter([Posn(x=50, y=100), Posn(x=-1, y=0), Posn(x=0, y=0), Posn(x=-1, y=0)]) == [Posn(x=50, y=100), Posn(x=0, y=0)]
    assert legal_filter([Posn(x=50, y=100), Posn(x=-1, y=0), Posn(x=0, y=0), Posn(x=-1, y=0), Posn(x=100, y=200)]) == [Posn(x=50, y=100), Posn(x=0, y=0), Posn(x=100, y=200)]
    assert legal_filter([Posn(x=100, y=201), Posn(x=50, y=100), Posn(x=-1, y=0), Posn(x=0, y=0), Posn(x=-1, y=0), Posn(x=100, y=200)]) == [Posn(x=50, y=100), Posn(x=0, y=0), Posn(x=100, y=200)]
    assert legal_filter([Posn(x=100, y=201), Posn(x=50, y=100), Posn(x=-1, y=0), Posn(x=0, y=0), Posn(x=-1, y=0), Posn(x=100, y=200), Posn(x=101, y=201)]) == [Posn(x=50, y=100), Posn(x=0, y=0), Posn(x=100, y=200)]
    
