# Exercise 104
# Your home town manages a fleet of vehicles: automobiles, vans, buses, and SUVs. 
# Develop a data representation for vehicles. 
# The representation of each vehicle must describe: 
# - the number of passengers that it can carry, 
# - its license plate number, 
# - and its fuel consumption (miles per gallon). 
# Develop a template for functions that consume vehicles. 

from dataclasses import dataclass
from typing import Any

@dataclass
class Vehicle:
    passengers_limit : int
    license_plate : str
    miles_per_gallon : float

    def function_that_consumes_vehicle(self):
        match self:
            case Automobile():
                return 'auto'
            case Van():
                return 'van'
            case Bus():
                return 'bus'
            case SUV():
                return 'suv'

class Automobile(Vehicle):
    pass

class Van(Vehicle):
    pass

class Bus(Vehicle):
    pass

class SUV(Vehicle):
    pass

def function_that_consumes_vehicle_not_instance_method(vehicle : Vehicle) -> Any:
    match vehicle:
        case Automobile():
            return 'auto'
        case Van():
            return 'van'
        case Bus():
            return 'bus'
        case SUV():
            return 'suv'

import pytest

def test_function_that_consumes_vehicle():
    assert Automobile(passengers_limit=2, license_plate='ASB', miles_per_gallon=10).function_that_consumes_vehicle() == 'auto'
    assert Van(passengers_limit=4, license_plate='UBC', miles_per_gallon=8).function_that_consumes_vehicle() == 'van'
    assert Bus(passengers_limit=40, license_plate='TAZ', miles_per_gallon=2).function_that_consumes_vehicle() == 'bus'
    assert SUV(passengers_limit=8, license_plate='HTV', miles_per_gallon=9).function_that_consumes_vehicle() == 'suv'

def test_function_that_consumes_vehicle_not_instance_method():
    assert function_that_consumes_vehicle_not_instance_method(Automobile(passengers_limit=2, license_plate='ASB', miles_per_gallon=10)) == 'auto'
    assert function_that_consumes_vehicle_not_instance_method(Van(passengers_limit=4, license_plate='UBC', miles_per_gallon=8))== 'van'
    assert function_that_consumes_vehicle_not_instance_method(Bus(passengers_limit=40, license_plate='TAZ', miles_per_gallon=2)) == 'bus'
    assert function_that_consumes_vehicle_not_instance_method(SUV(passengers_limit=8, license_plate='HTV', miles_per_gallon=9)) == 'suv'    
