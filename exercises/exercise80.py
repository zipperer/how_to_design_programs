from dataclasses import dataclass
import decimal
decimal.getcontext().prec = 2 # for arithmetic with prices. see https://docs.python.org/3/library/decimal.html and search for 'python decimal tutorial' and read result e.g. https://www.pythontutorial.net/advanced-python/python-decimal/
from exercise79 import Color

# Exercise 80
# Create templates for functions that consume instances of the following structure types:


@dataclass
class Movie:
    title : str
    director : str
    year : int

#def movie_function(movie : Movie) -> Any:
#    return (... movie.title  # str
#            ... movie.director # str
#            ... movie.year # int
#            ...
#            )

@dataclass
class Pet:
    name : str
    number : int

#def pet_function(pet : Pet) -> Any:
#    return (... pet.name # str
#            ... pet.number # int
#            ...
#            )

#(define-struct CD [artist title price])
@dataclass
class CD:
    artist : str
    title : str
    price : decimal.Decimal

#def cd_function(cd : CD) -> Any:
#    return ( ... cd.artist # str
#             ... cd.title # str
#             ... cd.price # decimal.Decimal
#             )

@dataclass
class Sweater:
    material : str
    size : str
    color : Color

#def sweater_function(sweater : Sweater) -> Any:
#    return (... sweater.material # str
#            ... sweater.size # str
#            ... sweater.color # Color
#            ...
#            )
