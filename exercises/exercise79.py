# Exercise 79
# Create examples for the following data definitions:

# 1. 
# A Color is one of: 
# — "white"
# — "yellow"
# — "orange"
# — "green"
# — "red"
# — "blue"
# — "black"

from enum import Enum

class Color(Enum):
    WHITE = "white"
    YELLOW = "yellow"
    ORANGE = "orange"
    GREEN = "green"
    RED = "red"
    BLUE = "blue"
    BLACK = "black"    

# Examples include: 
color_example0 = Color.RED
color_example1 = Color.WHITE
color_example2 = Color.BLUE

# 2. 
# H is a Number between 0 and 100.
# interpretation represents a happiness value

class Happiness:

    def happines_value_is_valid(self, value):
        assert (0 <= value) and (value <= 100)

    def __init__(self, value : int) -> None:
        self.happines_value_is_valid(value)
        self.value = value
        
# For example,
happiness_example_0 = Happiness(value=0)
happiness_example_1 = Happiness(value=100)
happiness_example_2 = Happiness(value=61)

# 3. 
#(define-struct person [fstname lstname male?])
# A Person is a structure:
#   (make-person String String Boolean)

from dataclasses import dataclass

@dataclass
class Person:
    fstname : str
    lstname : str
    is_male : bool # male? gave 'invalid syntax'

# For example:
BRUCE_WILLIS = Person(fstname="Bruce", lstname="Willis", is_male=True) # represents Bruce Willis
BRUCINA_WILLIS = Person(fstname="Brucina", lstname="Willis", is_male=False) # represents Brucina Willis

 
# Question: Is it a good idea to use a field name that looks like the name of a predicate?
# Answer: No, because the selector looks like it is asking a question rather than selecting
#         the value for a field.
# Counterpoint: Given that the value for the field is a boolean, then selecting the value
#               from that field is at least akin to asking the question and could be seen
#               as equivalent to asking the question.
# Counter-counterpoint: So far we have seen predicates only for types of data, e.g.
#                       number?, string?, posn?. (person-male? x) -- if seen as a question
#                       like the others -- looks like it is asking whether x is an instance
#                       of datatype person-male. To read it as asking whether the person x
#                       is male requires reading it differently than we read number? string?
#                       and posn?.

# 4.
#(define-struct dog [owner name age happiness])
# A Dog is a structure:
#   (make-dog Person String PositiveInteger H)

class Dog:

    def __init__(self,
                 owner : Person,
                 name : str,
                 age : int,
                 happiness : Happiness) -> None:
        self.owner = owner
        self.name = name
        self.age = age
        self.happiness = happiness

# For example:
BABY_BRUCE = Dog(owner=BRUCE_WILLIS,
                  name='BABY BRUCE',
                  age=6,
                  happiness=Happiness(value=94))

# Add an interpretation to this data definition, too.

# A Weapon is one of: 
# — #false
# — Posn
# interpretation #false means the missile hasn't 
# been fired yet# a Posn means it is in flight

from posn import Posn
from typing import Union, Literal

Weapon = Union[Literal[False],Posn]

# For example:
example_weapon_0 : Weapon = False # represents the missile has not yet been fired
example_weapon_1 : Weapon = Posn(x=10, y=20) # represents a missile in flight at x coordinate 10 and y coordinate 20 on the map
 
# The last definition is an unusual itemization,
# combining built-in data with a structure type.
# The next chapter deals with such definitions in depth. 
