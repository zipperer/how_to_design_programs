from dataclasses import dataclass

@dataclass
class Movie:
    title: str
    producer: str
    year: int

DIE_HARD = Movie('Die Hard', 
                 'Lawrence Gordon;Joel Silver',
                 1988)

@dataclass
class Person:
    name: str
    hair: str
    eyes: str
    phone: str

BRUCE_WILLIS = Person('Bruce Willis', 
                      'Brown', 
                      'Green', 
                      '8675309')

@dataclass
class Pet:
    name: str
    number: int

BRUCE_WILLIS_CAT = Pet('BABY BRUCE',
                       1)

@dataclass
class CD:
    artist: str
    title: str
    price: float

DIE_HARD_SOUNDTRACK = CD('Michael Kamen', 
                         'Die Hard: Original Motion Picture Soundtrack', 
                         9.99)

@dataclass
class Sweater:
    material: str
    size: str
    producer: str

BRUCE_WILLIS_SWEATER = Sweater('Kevlar', 
                               'Large', 
                               'Dupont')
