# NumberOrFalse -> Number
# adds 3 to the given number; 3 otherwise

def add3 (number_or_false):
    match number_or_false:
        case False:
            return 3
        case int(number) | float(number) : # does not handle complex numbers or other number types from libraries
            return 3 + number
        case complex(real=input_complex_number_real_part, imag=input_complex_number_imaginary_part):
            return complex(real=(3 + input_complex_number_real_part), imag=input_complex_number_imaginary_part)

def add3_without_using_match_keyword(number_or_false):
    if number_or_false is False:
        return 3
    else:
        number = number_or_false
        return 3 + number

import pytest

def test_add3():
    assert add3(False) == 3
    assert add3(1) == 4
    assert add3(1.0) == 4.0
    assert add3(complex(real=0, imag=0)) == 3+0j

def test_add3_without_using_match_keyword_without_using_match_keyword():
    assert add3_without_using_match_keyword(False) == 3
    assert add3_without_using_match_keyword(1) == 4
    assert add3_without_using_match_keyword(1.0) == 4.0
    assert add3_without_using_match_keyword(complex(real=0, imag=0)) == 3+0j
