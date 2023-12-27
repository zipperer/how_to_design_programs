from dataclasses import dataclass

@dataclass
class Movie:
    title: str
    producer: str
    year: int

# Movie(title, producer, year)
# Movie(...).title
# Movie(...).producer
# Movie(...).year
# isinstance(x, Movie)
# match x:
#   case Movie(title=movie_title, producer=movie_producer, year=movie_year):
#     ...

@dataclass
class Person:
    name: str
    hair: str
    eyes: str
    phone: str

# Person(name, hair, eyes, phone)
# Person(...).name
# Person(...).hair
# Person(...).eyes
# Person(...).phone
# isinstance(x, Person)
# match x:
#   case Person(name=person_name, hair=person_hair, eyes=person_eyes, phone=person_phone):
#     ... 

@dataclass
class Pet:
    name: str
    number: int

# Pet(name, number)
# Pet(...).name
# Pet(...).number
# isinstance(x, Pet)
# match x:
#   case Pet(name=pet_name, number=pet_number):
#     ...

@dataclass
class CD:
    artist: str
    title: str
    price: float

# CD(artist, title, price)
# CD(...).artist
# CD(...).title
# CD(...).price
# isisntance(x, CD)
# match x:
#   case CD(artist=cd_artist, title=cd_title, price=cd_price):
#     ...

@dataclass
class Sweater:
    material: str
    size: str
    producer: str

# Sweater(material, size, producer)
# Sweater(...).material
# Sweater(...).size
# Sweater(...).producer
# isinstance(x, Sweater)
# match x:
#   case Sweater(material=sweater_material, size=sweater_size, producer=sweater_producer):
#     ...
