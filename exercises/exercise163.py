# Exercise 163. 
# Design convertFC. 
# The function converts a list of measurements in Fahrenheit to a list of Celsius measurements. 
from typing import Union, List
Number = Union[int, float]
def fahrenheit_to_celsius(fahrenheit_temperature : Number) -> Number:
    '''converts fahrenheit temperature to celsius temperature'''
    return (fahrenheit_temperature - 32) * (5/9)

def test_fahrenheit_to_celsius():
    assert fahrenheit_to_celsius(212) == 100.0
    assert fahrenheit_to_celsius(32) == 0.0

def convertFC(list_of_fahrenheit_temperatures : List[Number]) -> List[Number]:
    '''
    takes list of fahrenheit temperatures
    returns list of celsius temperatures
    '''
    match list_of_fahrenheit_temperatures:
        case []:
            return []
        case [first_fahrenheit_temperature, *rest_of_fahrenheit_temperatures]:
            return (
                [fahrenheit_to_celsius(first_fahrenheit_temperature)] +
                convertFC(rest_of_fahrenheit_temperatures)
                )

def test_convertFC():
    assert convertFC([]) == []
    assert convertFC([32]) == [0.0]
    assert convertFC([212]) == [100.0]
    assert convertFC([32, 212]) == [0.0, 100.0]
    
# data definitions
# signature, header, purpose statement
# functional examples
# template
# fill-in template
# formulate functional examples as tests and run them

# data definitions
# Number
# List-of-numbers / List[Number], i.e. one of
## []
## [Number] + List-of-numbers

# signature
# List[Number] -> List[Number]

# header
# def convertFC(list_of_fahrenheit_temperatures: List[Number]) -> List[Number]:
#   return []

# purpose statement
# converts a list of Fahrenheit temperatures to a list of Celsius temperatures

# functional examples
# convertFC([32]) == [0.0]
# convertFC([212]) == [100.0]
# convertFC([32, 212]) == [0.0, 100.0]

# template 
# def convertFC(list_of_fahrenheit_temperatures: List[Number]) -> List[Number]:
#   match list_of_fahrenheit_temperatures:
#     case []:
#       return _
#     case [first_fahrenheit_temperature, *rest_list_of_fahrenheit_temperatures]:
#       return (...
#               first_fahrenheit_temperature # Number that represents a fahrenheit temperature
#               ...
#               convertFC(rest_list_of_fahrenheit_temperatures) # List[Number] that represents the list of celsius temperatures that results from converting each fahrenheit temperature in rest_list_of_fahrenheit_temperatures
#              ...
#              )

# fill-in template
# see function defintion for convertFC

# formulate functional examples as tests and run them
# see body of test_convertFC

def convertFC_side_effect_append(list_of_fahrenheit_temperatures: List[Number]) -> List[Number]:
    '''
    I intend same input-output behavior as convertFC
    '''
    list_of_celsius_temperatures : List[Number] = list()
    for fahrenheit_temperature in list_of_fahrenheit_temperatures:
        list_of_celsius_temperatures.append(fahrenheit_to_celsius(fahrenheit_temperature))
    return list_of_celsius_temperatures

def test_convertFC_side_effect_append():
    assert convertFC_side_effect_append([]) == []
    assert convertFC_side_effect_append([32]) == [0.0]
    assert convertFC_side_effect_append([212]) == [100.0]
    assert convertFC_side_effect_append([32, 212]) == [0.0, 100.0]

def convertFC_map(list_of_fahrenheit_temperatures: List[Number]) -> List[Number]:
    '''
    I intend same input-output behavior as convertFC
    '''
    return list(map(fahrenheit_to_celsius, list_of_fahrenheit_temperatures))

def test_convertFC_map():
    assert convertFC_map([]) == []
    assert convertFC_map([32]) == [0.0]
    assert convertFC_map([212]) == [100.0]
    assert convertFC_map([32, 212]) == [0.0, 100.0]
