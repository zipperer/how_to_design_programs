# Exercise 129
# Create lists that represent
# a list of celestial bodies, say, at least all the planets in our solar system;
# a list of items for a meal, for example, steak, french fries, beans, bread, water, Brie cheese, and ice cream; and
# a list of colors.

from python_list_utilities import cons

PLANETS_IN_SOLAR_SYSTEM = cons('Mercury',
                               cons('Venus',
                                    cons('Earth',
                                         cons('Mars',
                                              cons('Jupiter',
                                                   cons('Saturn',
                                                        cons('Uranus',
                                                             cons('Neptune',
                                                                  cons('Pluto', list())))))))))


ITEMS_FOR_MEAL = cons('steak',
                      cons('french fries',
                           cons('beans',
                                cons('bread',
                                     cons('water',
                                          cons('Brie cheese',
                                               cons('ice cream', list())))))))

COLORS = cons('red',
              cons('white',
                   cons('blue', list())))

import pytest

def test_constants():
    assert PLANETS_IN_SOLAR_SYSTEM == ['Mercury','Venus','Earth','Mars','Jupiter','Saturn','Uranus','Neptune','Pluto']
    assert ITEMS_FOR_MEAL == ['steak', 'french fries', 'beans', 'bread', 'water', 'Brie cheese', 'ice cream']
    assert COLORS == ['red', 'white', 'blue']
