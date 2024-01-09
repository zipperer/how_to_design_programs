# Exercise 113
# Design predicates for the following data definitions from the preceding section:
# - SIGS
# - Coordinate (exercise 105), and
# - VAnimal.

from dataclasses import dataclass
from typing_common import Number
from typing import Any, Union, Literal
from posn import Posn, is_posn, make_posn
from local_utilities import is_number, is_positive_number, is_negative_number

# For some of these data definitions, I treat the name of the class as the name of the set of values the data definition defines.
# E.g. Tank is both the name of the class and the set of values.
# For others, I treat the class name as defining a structure type and the set of values the data definition defines
#   includes instances of that structure type _that satisfy additional constraints_.
# E.g. CatPositionAndHappiness is the structure type, while VCat is the set of values the data definition defines.
# A VCat is an instance of CatPositionAndHappiness that satisfies additional constraints.

@dataclass
class Tank:
    '''
    A Tank is a structure:
      (make-tank Number Number)
    interpretation:
      (make-tank x dx) specifies
        tank position: (x, HEIGHT)
        tank speed: dx pixels/tick 
    '''
    location: Number
    velocity: Number

def make_tank(location : Number,
              velocity : Number
              ) -> Tank:
    return Tank(location=location, velocity=velocity)

def is_tank(value : Any) -> bool:
    return (isinstance(value, Tank) and
            is_number(value.location) and
            is_number(value.velocity))

class UFO(Posn):
    ''' 
    A UFO is a Posn. 
    interpretation: 
      (make-posn x y) is the UFO's location 
      (using the top-down, left-to-right convention)
    '''
    pass

def make_ufo(x_coordinate : Number,
             y_coordinate : Number
             ) -> UFO:
    return UFO(x=x_coordinate, y=y_coordinate)

def is_ufo(value : Any) -> bool:
    return (isinstance(value, UFO) and
            is_number(value.x) and
            is_number(value.y))

class Missile(Posn):
    ''' 
    A Missile is a Posn. 
    interpretation: 
      (make-posn x y) is the Missile's location 
      (using the top-down, left-to-right convention)
    '''
    pass

def make_missile(x_coordinate : Number,
                 y_coordinate : Number
                 ) -> Missile:
    return Missile(x=x_coordinate, y=y_coordinate)

def is_missile(value : Any) -> bool:
    return (isinstance(value, Missile) and
            is_number(value.x) and
            is_number(value.y))

# Currently, we don't use this class or the inheritance.
# Aim(SIGS) and Fired(SIGS) convey that Aim and Fired are child classes of SIGS,
# but is_sigs function does not ask whether a value is an instance of SIGS.
class SIGS:
    '''
    A SIGS is one of: 
    – (make-aim UFO Tank)
    – (make-fired UFO Tank Missile)
    interpretation: 
      represents the complete state of a space invader game
    '''
    pass

#def is_sigs(value : Any) -> bool:
#    return isinstance(value, SIGS)

@dataclass # a dataclass that inherits from a normal class. Are there unexpected consequences? Similar question for class inherits from dataclass
class Aim(SIGS):
    ufo: UFO
    tank : Tank

def make_aim(ufo : UFO,
             tank : Tank
             ) -> Aim:
    return Aim(ufo=ufo, tank=tank)

def is_aim(value : Any) -> bool:
    return (isinstance(value, Aim) and
            is_ufo(value.ufo) and
            is_tank(value.tank))

@dataclass
class Fired(SIGS):
    ufo: UFO
    tank : Tank
    missile : Missile

def make_fired(ufo : UFO,
               tank : Tank,
               missile : Missile
               ) -> Fired:
    return Fired(ufo=ufo, tank=tank, missile=missile)

def is_fired(value : Any) -> bool:
    return (isinstance(value, Fired) and
            is_ufo(value.ufo) and
            is_tank(value.tank) and
            is_missile(value.missile))

def is_sigs(value : Any) -> bool:
    return (is_aim(value) or
            is_fired(value))
           

# A Coordinate is one of: 
# – a NegativeNumber 
#   interpretation: on the y axis, distance from top
# – a PositiveNumber 
#   interpretation: on the x axis, distance from left
# – a Posn
#   interpretation: an ordinary Cartesian point

def is_coordinate(value : Any) -> bool:
    return (is_negative_number(value) or
            is_positive_number(value) or
            is_posn(value))

CatDirection = Union[Literal['left'],Literal['right']]
cat_directions = {'left', 'right'}

HappinessNumber = Number # see is_happiness_number

@dataclass
class CatPositionAndHappiness:
    x_coordinate : Number
    happiness : HappinessNumber
    direction : CatDirection

def is_cat_direction(value : Any) -> bool:
    return (isinstance(value, str) and
            (value in cat_directions))

def is_happiness_number(value : Any) -> bool:
    return (is_number(value) and
            (0 <= value) and
            (value <= 100))

def is_vcat(value : Any) -> bool:
    '''
    A VCat is a structure:
      (make-cat-position-and-happiness Number Number String)
    interpretation
      (make-cat-position-and-happiness x0 h0 d0) represents a cat at
    - x-coordinate x0 with
    - happiness h0
    - direction d0
    h0 is in interval [0, 100]
    d0 is one of 'right', 'left'
    '''
    return (isinstance(value, CatPositionAndHappiness) and
            is_number(value.x_coordinate) and
            is_happiness_number(value.happiness) and
            is_cat_direction(value.direction))

ChameleonBackgroundColor = Union[Literal['red'],Literal['green'],Literal['blue']]
chameleon_background_colors = {'red', 'green', 'blue'}

def is_chameleon_background_color(value : Any) -> bool:
    return (isinstance(value, str) and
            (value in chameleon_background_colors))

@dataclass 
class VirtualChameleonWorldState:
    x_position : Number
    happiness : HappinessNumber
    background_color : ChameleonBackgroundColor

def is_vcham(value : Any) -> bool:
    '''
    A VCham is a structure:
      (make-virtual-chameleon-world-state Number Number Color)
    interpretation:
      (make-virtual-chameleon-world-state x0 h0 c0) represents
      a world state with a chameleon at x-position x0 with happiness h0
      where the background-color is c0.
      x0 is in interval [0, BACKGROUND_WIDTH]
      h0 is in interval [0, 100]
    '''
    return (isinstance(value, VirtualChameleonWorldState) and
            is_number(value.x_position) and
            is_happiness_number(value.happiness) and
            is_chameleon_background_color(value.background_color))

def is_vanimal(value : Any) -> bool:
    '''
    A VAnimal is either
    – a VCat
    – a VCham
    '''
    return (is_vcat(value) or
            is_vcham(value))

# (define (background-color-for-vcham? value)
#   (and (image-color? value)
#        (or (string=? value "red")
#            (string=? value "green")
#            (string=? value "blue"))))

import pytest

def test_is_sigs():
    assert is_sigs(make_aim(make_ufo(1, 2), make_tank(0, 3))) == True
    assert is_sigs(make_aim(make_ufo(1, 2), make_tank(0, -3))) == True
    assert is_sigs(make_fired(make_ufo(1, 2), make_tank(0, 3), make_missile(2,10))) == True
    assert is_sigs(False) == False
    # positional arguments out of order
    assert is_sigs(make_fired(make_tank(0, 3), make_ufo(1, 2), make_missile(2, 10))) == False

def test_is_coordinate():
    assert is_coordinate(1) == True
    assert is_coordinate(-1) == True
    assert is_coordinate(make_posn(1, -1)) == True
    assert is_coordinate('a') == False
    assert is_coordinate(True) == False

def test_is_vcat():
    assert is_vcat(CatPositionAndHappiness(0, 100, 'right')) == True
    # 200 exceeds interval for is_happiness_number
    assert is_vcat(CatPositionAndHappiness(0, 200, 'right')) == False
    # "blue" is not one of the directions ("left" or "right")
    assert is_vcat(CatPositionAndHappiness(0, 100, 'blue')) == False
    assert is_vcat(True) == False

def test_is_vcham():
    assert is_vcham(VirtualChameleonWorldState(0, 100, 'red')) == True
    assert is_vcham(VirtualChameleonWorldState(0, 50, 'green')) == True
    # "pink" is not one of the background colors ("red", "green", or "blue")
    assert is_vcham(VirtualChameleonWorldState(0, 100, 'pink')) == False
    assert is_vcham(True) == False
