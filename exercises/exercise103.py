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

from typing_common import Number

@dataclass
class SpaceForTransport:
    length : Number
    width: Number
    height: Number

@dataclass
class Spider:
    legs_remaining : int
    space_for_transport : SpaceForTransport

@dataclass
class Elephant:
    space_for_transport : SpaceForTransport

@dataclass
class BoaConstrictor:
    length : Number
    girth : Number
    
    # todo: look up whether dataclass recommends different format for instance methods
    #       or different convention for methods
    def boa_constrictor_space_for_transport(self):
        return SpaceForTransport(length = self.length * .8,
                                 width = self.length * .8,
                                 height = self.girth * 2)

# >>> my_boa_constrictor = BoaConstrictor(length=1, girth=.2)
# my_boa_constrictor = BoaConstrictor(length=1, girth=.2)
# >>> my_boa_constrictor.boa_constrictor_space_for_transport()
# my_boa_constrictor.boa_constrictor_space_for_transport()
# SpaceForTransport(length=0.8, width=0.8, height=0.4)

@dataclass
class Armadillo:
    nocturnal : bool
    space_for_transport : SpaceForTransport

from enum import Enum

class ZooAnimal(Enum):
    SPIDER=Spider
    ELEPHANT=Elephant
    BOA_CONSTRICTOR=BoaConstrictor
    ARMADILLO=Armadillo

from typing import Any

# commented due to not syntactically correct with `...`
# def function_that_consumes_zoo_animals(zoo_animal : ZooAnimal) -> Any:
#     match zoo_animal:
#         case ZooAnimal.SPIDER:
#             return ... zoo_animal.legs_remaining ... zoo_animal.space_for_transport ...
#         case ZooAnimal.ELEPHANT:
#             return ... zoo_animal.space_for_transport ...
#         case ZooAnimal.BOA_CONSTRICTOR:
#             return ... zoo_animal.length ... zoo_animal.girth ...
#         case ZooAnimal.ARMADILLO:
#             return ... zoo_animal.nocturnal ... zoo_animal.space_for_transport ...

from typing import Union

ZooAnimal_Alternative = Union[Spider, Elephant, BoaConstrictor, Armadillo]

# commented due to not syntactically correct with `...`
# def function_that_consumes_zoo_animals_without_enum(zoo_animal : ZooAnimal_Alternative) -> Any:
#     match zoo_animal:
#         case Spider(legs_remaining=spider_number_legs_remaining, space_for_transport=spider_space_for_transport)
#             return ... spider_number_legs_remaining ... spider_space_for_transport ...
#         case Elephant(space_for_transport=elephant_space_for_transport):
#             return ... elephant_space_for_transport ...
#         case BoaConstrictor(length=boa_constrictor_length, girth=boa_constrictor_girth):
#             return ... boa_constrictor_length ... boa_constrictor_girth ...
#         case Armadillo(nocturnal=armadillo_nocturnal, space_for_transport=armadillo_space_for_transport)
#             return ... armadillo_nocturnal ... armadillo_space_for_transport ...
#         case _:
#             raise Exception('function_that_consumes_zoo_animals_without_enum failed to match input zoo_animal')

def zoo_animal_fits(zoo_animal : ZooAnimal_Alternative,
                    cage_description : SpaceForTransport
                    ) -> bool:
    match zoo_animal:
        case Spider(legs_remaining=spider_number_legs_remaining, space_for_transport=spider_space_for_transport):
            return cage_description_meets_needs_of_animal_with_space_for_transport(cage_description, spider_space_for_transport)
        case Elephant(space_for_transport=elephant_space_for_transport):
            return cage_description_meets_needs_of_animal_with_space_for_transport(cage_description, elephant_space_for_transport)
        case BoaConstrictor(length=boa_constrictor_length, girth=boa_constrictor_girth):
            return cage_description_meets_needs_of_animal_with_space_for_transport(cage_description, zoo_animal.boa_constrictor_space_for_transport())
        case Armadillo(nocturnal=armadillo_nocturnal, space_for_transport=armadillo_space_for_transport):
            return cage_description_meets_needs_of_animal_with_space_for_transport(cage_description, armadillo_space_for_transport)

def cage_description_meets_needs_of_animal_with_space_for_transport(cage_description : SpaceForTransport,
                                                                    zoo_animal_space_for_transport : SpaceForTransport
                                                                    ) -> bool:
    return ((cage_description.length >= zoo_animal_space_for_transport.length) and
            (cage_description.width >= zoo_animal_space_for_transport.width) and
            (cage_description.height >= zoo_animal_space_for_transport.height))


def zoo_animal_fits_alternative(zoo_animal : ZooAnimal_Alternative,
                                cage_description : SpaceForTransport
                                ) -> bool:
    return cage_description_meets_needs_of_animal_with_space_for_transport(cage_description,
                                                                           zoo_animal_space_for_transport(zoo_animal))

def zoo_animal_space_for_transport(zoo_animal : ZooAnimal_Alternative) -> SpaceForTransport:
    match zoo_animal:
        # claim: can drop legs_remaining binding since do not use
        case Spider(legs_remaining=spider_number_legs_remaining, space_for_transport=spider_space_for_transport):
            return spider_space_for_transport
        case Elephant(space_for_transport=elephant_space_for_transport):
            return elephant_space_for_transport
        case BoaConstrictor(length=boa_constrictor_length, girth=boa_constrictor_girth):
            return zoo_animal.boa_constrictor_space_for_transport()
        # claim: can drop nocturnal binding since do not use
        case Armadillo(nocturnal=armadillo_nocturnal, space_for_transport=armadillo_space_for_transport):
            return armadillo_space_for_transport

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

    def test_zoo_animal_fits_alternative(self):
        self.assertEqual(zoo_animal_fits_alternative(Spider(legs_remaining=8, space_for_transport=SpaceForTransport(length=1, width=1, height=1)),SpaceForTransport(length=1, width=1, height=1)), True)
        self.assertEqual(zoo_animal_fits_alternative(Spider(legs_remaining=8, space_for_transport=SpaceForTransport(length=1, width=1, height=1)),SpaceForTransport(length=1, width=1, height=.5)), False)
        self.assertEqual(zoo_animal_fits_alternative(Elephant(space_for_transport=SpaceForTransport(length=10, width=10, height=10)),SpaceForTransport(length=11, width=10, height=10)), True)
        self.assertEqual(zoo_animal_fits_alternative(Elephant(space_for_transport=SpaceForTransport(length=10, width=10, height=10)),SpaceForTransport(length=9.9, width=10, height=10)), False)
        self.assertEqual(zoo_animal_fits_alternative(BoaConstrictor(length=12, girth=2),SpaceForTransport(length=15, width=15, height=5)), True)
        self.assertEqual(zoo_animal_fits_alternative(BoaConstrictor(length=12, girth=2),SpaceForTransport(length=7, width=15, height=5)), False)
        self.assertEqual(zoo_animal_fits_alternative(BoaConstrictor(length=12, girth=2),SpaceForTransport(length=15, width=15, height=2)), False)

import pytest

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

def test_zoo_animal_fits_alternative_pytest():
    assert zoo_animal_fits_alternative(Spider(legs_remaining=8, space_for_transport=SpaceForTransport(length=1, width=1, height=1)),
                           SpaceForTransport(length=1, width=1, height=1)) == True
    assert zoo_animal_fits_alternative(Spider(legs_remaining=8, space_for_transport=SpaceForTransport(length=1, width=1, height=1)),
                           SpaceForTransport(length=1, width=1, height=.5)) == False
    assert zoo_animal_fits_alternative(Elephant(space_for_transport=SpaceForTransport(length=10, width=10, height=10)),
                           SpaceForTransport(length=11, width=10, height=10)) == True
    assert zoo_animal_fits_alternative(Elephant(space_for_transport=SpaceForTransport(length=10, width=10, height=10)),
                           SpaceForTransport(length=9.9, width=10, height=10)) == False
    assert zoo_animal_fits_alternative(BoaConstrictor(length=12, girth=2),
                           SpaceForTransport(length=15, width=15, height=5)) == True
    assert zoo_animal_fits_alternative(BoaConstrictor(length=12, girth=2),
                           SpaceForTransport(length=7, width=15, height=5)) == False
    assert zoo_animal_fits_alternative(BoaConstrictor(length=12, girth=2),
                           SpaceForTransport(length=15, width=15, height=2)) == False
