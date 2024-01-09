from typing import Any

def is_number(value : Any) -> bool:
    return ((type(value) == int) or
            (type(value) == float)) # or
#           (type(value) == complex)

def is_positive_number(value : Any) -> bool:
    return (is_number(value) and
            value >= 0)

def is_negative_number(value : Any) -> bool:
    return (is_number(value) and
            value < 0)
