# Exercise 103
# Develop a data representation for the following four kinds of zoo animals:
# 1. spiders, whose relevant attributes are the number of remaining legs (we assume that spiders can lose legs in accidents) 
#    and the space they need in case of transport;
#
# 2. elephants, whose only attributes are the space they need in case of transport;
#
# 3. boa constrictors, whose attributes include length and girth; and
#
# 4. armadillos, for which you must determine appropriate attributes, 
#    including one that determines the space needed for transport.

# Develop a template for functions that consume zoo animals.

# Design the fits? function, which consumes a zoo animal and a description of a cage. 
# It determines whether the cage’s volume is large enough for the animal.

from dataclasses import dataclass

from typing import Any
from typing_common import Number

@dataclass
class SpaceForTransport:
    length : Number
    width: Number
    height: Number

class ZooAnimal:
    pass

class Spider(ZooAnimal):

    def __init__(self, 
                 legs_remaining : Number,
                 space_for_transport : SpaceForTransport
                 ) -> None:
        self.legs_remaining = legs_remaining
        self.space_for_transport = space_for_transport

    def get_space_for_transport(self) -> SpaceForTransport:
        return self.space_for_transport

class Elephant(ZooAnimal):

    def __init__(self,
                 space_for_transport : SpaceForTransport
                 ) -> None:
        self.space_for_transport = space_for_transport

    def get_space_for_transport(self) -> SpaceForTransport:
        return self.space_for_transport

class BoaConstrictor(ZooAnimal):

    def __init__(self,
                 length : Number,
                 girth : Number
                 ) -> None:
        self.length = length
        self.girth = girth
        #self.computed_space_for_transport = None

    def get_space_for_transport(self) -> SpaceForTransport:
        if hasattr(self, 'computed_space_for_transport'):
            #print('returned cached value')
            return self.computed_space_for_transport # type: ignore # Cannot determine type of "computed_space_for_transport"  [has-type]
#        if self.computed_space_for_transport:
#            return self.computed_space_for_transport
        else:
            computed_space_for_transport = SpaceForTransport(length=(.8 * self.length),
                                                    width=(.8 * self.length),
                                                    height=(2 * self.girth))
            self.computed_space_for_transport = computed_space_for_transport # Incompatible types in assignment (expression has type "SpaceForTransport", variable has type "None")  [assignment]
            #print('computed value')
            return computed_space_for_transport

class Armadillo(ZooAnimal):

    def __init__(self,
                 nocturnal : bool,
                 space_for_transport : SpaceForTransport
                 ) -> None:
        self.nocturnal = nocturnal
        self.space_for_transport = space_for_transport

    def get_space_for_transport(self) -> SpaceForTransport:
        return self.space_for_transport

def function_that_consumes_zoo_animals(zoo_animal : ZooAnimal) -> int:
    match zoo_animal:
        case Spider():
            return 0
        case Elephant():
            return 1
        case BoaConstrictor():
            return 2
        case Armadillo():
            return 3

def zoo_animal_fits(zoo_animal: ZooAnimal,
                    cage_description : SpaceForTransport
                    ) -> bool:
    #breakpoint()
    return cage_description_meets_needs_of_animal_with_space_for_transport(cage_description,
                                                                           zoo_animal.get_space_for_transport()) # uses instance method each child class implements

def cage_description_meets_needs_of_animal_with_space_for_transport(cage_description : SpaceForTransport,
                                                                    zoo_animal_space_for_transport : SpaceForTransport
                                                                    ) -> bool:
    return ((cage_description.length >= zoo_animal_space_for_transport.length) and
            (cage_description.width >= zoo_animal_space_for_transport.width) and
            (cage_description.height >= zoo_animal_space_for_transport.height))

import unittest

class TestZooAnimalFits(unittest.TestCase):

    def test_zoo_animal_fits(self):
        self.assertEqual(zoo_animal_fits(Spider(legs_remaining=8, space_for_transport=SpaceForTransport(length=1, width=1, height=1)),SpaceForTransport(length=1, width=1, height=1)), True)
        self.assertEqual(zoo_animal_fits(Spider(legs_remaining=8, space_for_transport=SpaceForTransport(length=1, width=1, height=1)),SpaceForTransport(length=1, width=1, height=.5)), False)
        self.assertEqual(zoo_animal_fits(Elephant(space_for_transport=SpaceForTransport(length=10, width=10, height=10)),SpaceForTransport(length=11, width=10, height=10)), True)
        self.assertEqual(zoo_animal_fits(Elephant(space_for_transport=SpaceForTransport(length=10, width=10, height=10)),SpaceForTransport(length=9.9, width=10, height=10)), False)
        self.assertEqual(zoo_animal_fits(BoaConstrictor(length=12, girth=2),SpaceForTransport(length=15, width=15, height=5)), True)
        self.assertEqual(zoo_animal_fits(BoaConstrictor(length=12, girth=2),SpaceForTransport(length=7, width=15, height=5)), False)
        self.assertEqual(zoo_animal_fits(BoaConstrictor(length=12, girth=2),SpaceForTransport(length=15, width=15, height=2)), False)

import pytest

def test_function_that_consumes_zoo_animals():
    assert function_that_consumes_zoo_animals(Spider(legs_remaining=1, space_for_transport=SpaceForTransport(length=1,
                                                                                                             width=1,
                                                                                                             height=1))) == 0
def test_zoo_animal_fits_pytest():
    assert zoo_animal_fits(Spider(legs_remaining=8, space_for_transport=SpaceForTransport(length=1, width=1, height=1)),
                           SpaceForTransport(length=1, width=1, height=1)) == True
    assert zoo_animal_fits(Spider(legs_remaining=8, space_for_transport=SpaceForTransport(length=1, width=1, height=1)),
                           SpaceForTransport(length=1, width=1, height=.5)) == False
    assert zoo_animal_fits(Elephant(space_for_transport=SpaceForTransport(length=10, width=10, height=10)),
                           SpaceForTransport(length=11, width=10, height=10)) == True
    assert zoo_animal_fits(Elephant(space_for_transport=SpaceForTransport(length=10, width=10, height=10)),
                           SpaceForTransport(length=9.9, width=10, height=10)) == False
    assert zoo_animal_fits(BoaConstrictor(length=12, girth=2),
                           SpaceForTransport(length=15, width=15, height=5)) == True
    assert zoo_animal_fits(BoaConstrictor(length=12, girth=2),
                           SpaceForTransport(length=7, width=15, height=5)) == False
    assert zoo_animal_fits(BoaConstrictor(length=12, girth=2),
                           SpaceForTransport(length=15, width=15, height=2)) == False
