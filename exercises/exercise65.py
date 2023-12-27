class Movie:

    def __init__(self, title, producer, year):
        self.title = title
        self.producer = producer
        self.year = year

# Movie(title, producer, year)
# Movie(...).title
# Movie(...).producer
# Movie(...).year
# isinstance(x, Movie)
# match x:
#   case Movie(title=movie_title, producer=movie_producer, year=movie_year):
#     ...

class Person:

    def __init__(self, name, hair, eyes, phone):
        self.name = name
        self.hair = hair
        self.eyes = eyes
        self.phone = phone

# Person(name, hair, eyes, phone)
# Person(...).name
# Person(...).hair
# Person(...).eyes
# Person(...).phone
# isinstance(x, Person)
# match x:
#   case Person(name=person_name, hair=person_hair, eyes=person_eyes, phone=person_phone):
#     ... 

class Pet:

    def __init__(self, name, number):
        self.name = name
        self.number = number

# Pet(name, number)
# Pet(...).name
# Pet(...).number
# isinstance(x, Pet)
# match x:
#   case Pet(name=pet_name, number=pet_number):
#     ...

class CD:

    def __init__(self, artist, title, price):
        self.artist = artist
        self.title = title
        self.price = price

# CD(artist, title, price)
# CD(...).artist
# CD(...).title
# CD(...).price
# isisntance(x, CD)
# match x:
#   case CD(artist=cd_artist, title=cd_title, price=cd_price):
#     ...

class Sweater:

    def __init__(self, material, size, producer):
        self.material = material
        self.size = size
        self.producer = producer

# Sweater(material, size, producer)
# Sweater(...).material
# Sweater(...).size
# Sweater(...).producer
# isinstance(x, Sweater)
# match x:
#   case Sweater(material=sweater_material, size=sweater_size, producer=sweater_producer):
#     ...
