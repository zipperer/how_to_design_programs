# Exercise 170. 

# Here is one way to represent a phone number:
# (define-struct phone [area switch four])
# A Phone is a structure: 
#   (make-phone Three Three Four)
# A Three is a Number between 100 and 999. 
# A Four is a Number between 1000 and 9999. 

# Design the function replace. 
#   It consumes and produces a list of Phones. 
#   It replaces all occurrence of area code 713 with 281.

from dataclasses import dataclass
from typing_common import Number
from typing import List
from python_list_utilities import cons

@dataclass
class Phone:
    '''
    A Phone is a structure that stores three numbers: area, switch, and four.
    Constraints:
      100 <= area <= 999
      100 <= switch <= 999
      1000 <= four <= 9999
    Interpretation:
      Phone(area=a0, switch=s0, four=f0) is a phone number with area a0, switch s0, and four f0.
    For example:
      Phone(area=713, switch=100, four=8781) is a phone number with area 713, switch 100, and four 8781.
      Phone(area=281, switch=100, four=8781)
      Phone(area=412, switch=222, four=5799)
    '''
    area : Number
    switch: Number
    four : Number

AREA_CODE_TO_REPLACE = 713
AREA_CODE_REPLACEMENT_VALUE = 281

def replace_area_code_where_applicable(list_of_phone : List[Phone]) -> List[Phone]:
    '''
    Parameters:
    - list_of_phone : List[Phone]
    -- list of instances of Phone

    Returns:
    - list of instances of Phone
    -- one instance per instance from the input
    -- for each instance from the input for which area code is AREA_CODE_TO_REPLACE, the area code
       for the instance in the output is AREA_CODE_REPLACEMENT_VALUE
    -- values for switch and four stay the same
    '''
    match list_of_phone:
        case []:
            return []
        case [first_phone, *rest_list_of_phone]:
            return cons(phone_replace_area_code_where_applicable(first_phone),
                        replace_area_code_where_applicable(rest_list_of_phone))

def test_replace_area_code_where_applicable():
    assert replace_area_code_where_applicable([]) == []
    assert replace_area_code_where_applicable([Phone(area=713, switch=100, four=8781)]) == [Phone(area=281, switch=100, four=8781)]
    assert replace_area_code_where_applicable([Phone(area=281, switch=100, four=8781), Phone(area=713, switch=100, four=8781)]) == [Phone(area=281, switch=100, four=8781), Phone(area=281, switch=100, four=8781)]
    assert replace_area_code_where_applicable([Phone(area=412, switch=222, four=5799), Phone(area=281, switch=100, four=8781), Phone(area=713, switch=100, four=8781), Phone(area=412, switch=222, four=5799)]) == [Phone(area=412, switch=222, four=5799), Phone(area=281, switch=100, four=8781), Phone(area=281, switch=100, four=8781), Phone(area=412, switch=222, four=5799)]

def phone_replace_area_code_where_applicable(phone : Phone) -> Phone:
    '''
    Parameters:
    - phone : Phone

    Returns:
    - instance of Phone
    -- output_phone.switch and output_phone.four are the same as phone.switch and phone.four
    -- output_phone.area is AREA_CODE_REPLACEMENT_VALUE when phone.area is AREA_CODE_TO_REPLACE
    '''
    area = phone.area
    if area == AREA_CODE_TO_REPLACE:
        area = AREA_CODE_REPLACEMENT_VALUE
    return Phone(area=area, 
                 switch=phone.switch,
                 four=phone.four)

def test_phone_replace_area_code_where_applicable():
    assert phone_replace_area_code_where_applicable(Phone(area=713, switch=100, four=8781)) == Phone(area=281, switch=100, four=8781)
    assert phone_replace_area_code_where_applicable(Phone(area=713, switch=100, four=8781)) == Phone(area=281, switch=100, four=8781)
    assert phone_replace_area_code_where_applicable(Phone(area=281, switch=100, four=8781)) == Phone(area=281, switch=100, four=8781)
    assert phone_replace_area_code_where_applicable(Phone(area=412, switch=222, four=5799)) == Phone(area=412, switch=222, four=5799)

def replace_area_code_where_applicable_map(list_of_phone : List[Phone]) -> List[Phone]:
    '''
    Parameters:
    - list_of_phone : List[Phone]
    -- list of instances of Phone

    Returns:
    - list of instances of Phone
    -- one instance per instance from the input
    -- for each instance from the input for which area code is AREA_CODE_TO_REPLACE, the area code
       for the instance in the output is AREA_CODE_REPLACEMENT_VALUE
    -- values for switch and four stay the same
    '''
    return list(map(phone_replace_area_code_where_applicable, list_of_phone))

def test_replace_area_code_where_applicable_map():
    assert replace_area_code_where_applicable_map([]) == []
    assert replace_area_code_where_applicable_map([Phone(area=713, switch=100, four=8781)]) == [Phone(area=281, switch=100, four=8781)]
    assert replace_area_code_where_applicable_map([Phone(area=281, switch=100, four=8781), Phone(area=713, switch=100, four=8781)]) == [Phone(area=281, switch=100, four=8781), Phone(area=281, switch=100, four=8781)]
    assert replace_area_code_where_applicable_map([Phone(area=412, switch=222, four=5799), Phone(area=281, switch=100, four=8781), Phone(area=713, switch=100, four=8781), Phone(area=412, switch=222, four=5799)]) == [Phone(area=412, switch=222, four=5799), Phone(area=281, switch=100, four=8781), Phone(area=281, switch=100, four=8781), Phone(area=412, switch=222, four=5799)]    
