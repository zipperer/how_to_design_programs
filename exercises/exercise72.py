#Exercise 72. 
# Formulate a data definition for the above phone structure type definition that accommodates the given examples.

import pytest

class PhoneNumber:
    '''
    A PhoneNumber is a structure:
      PhoneNumber(area=given_area, number=given_number)
    interpretation: area refers to the area code -- the first 3 digits of the phone number. [000,999]
                    number refers to the remaining seven digits, formatted with three digits,
                    a dash, and then 4 more digits. ['000-000','999-9999']
    '''
    def __init__(self,
                 area: int,
                 number: str
                 ) -> None:
        self.area = area
        self.number = number

example_phone_number = PhoneNumber(area=207, number='363-2421')

# Next formulate a data definition for phone numbers using this structure type definition:
# (define-struct phone# [area switch num])

#Historically, the first three digits make up the area code, the next three the code for the phone switch (exchange) of your neighborhood, and the last four the phone with respect to the neighborhood. Describe the content of the three fields as precisely as possible with intervals.

class PhoneNumber3:
    '''
    A PhoneNumber3 is a structure:
      PhoneNumber3(area=given_area, switch=given_switch, num=given_num)
    interpretation: 
      area refers to the area code -- the first 3 digits of the phone number. ['000','999']
      switch refers to the switch code (i.e. neighborhood code) -- the next 3 digits of the phone number. ['000','999']
      num refers to the number for the particular phone -- the next 4 digits of the phone number. ['0000','9999']
    '''
    def __init__(self,
                 area : str,
                 switch : str,
                 num : str
                 ) -> None:
        self.area = area
        self.switch = switch
        self.num = num

example_phone_number3 = PhoneNumber3(area='207', switch='363', num='2421')

def test_phone_number():
    assert isinstance(example_phone_number, PhoneNumber) == True
    assert isinstance(example_phone_number3, PhoneNumber) == False
    
def test_phone_number3():
    assert isinstance(example_phone_number3, PhoneNumber3) == True
    assert isinstance(example_phone_number3, PhoneNumber) == False
