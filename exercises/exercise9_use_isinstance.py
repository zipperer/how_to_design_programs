import unittest

#https://docs.python.org/3/library/functions.html#isinstance

def is_string(value_with_type_unknown_to_program_designer):
    return isinstance(value_with_type_unknown_to_program_designer, str)

def is_number(value_with_type_unknown_to_program_designer):
    return ((isinstance(value_with_type_unknown_to_program_designer, int) or
             isinstance(value_with_type_unknown_to_program_designer, float)) and
            # each bool is an int, so can either:
            # a) check that value_with_type_unknown_to_program_designer is not bool, or
            # b) remember to order the checks so that check for bool before check for number
            # here we choose (a).
            # we could have alternatively chosen (b) and edited convert_to_non_negative_integer_use_isinstance by reordering the checks
            not isinstance(value_with_type_unknown_to_program_designer, bool))

def is_bool(value_with_type_unknown_to_program_designer):
    return isinstance(value_with_type_unknown_to_program_designer, bool)

def convert_to_non_negative_integer_use_isinstance(value_with_type_unknown_to_program_designer):
    if is_string(value_with_type_unknown_to_program_designer):
        return len(value_with_type_unknown_to_program_designer)
    elif is_number(value_with_type_unknown_to_program_designer):
        return abs(value_with_type_unknown_to_program_designer)
    elif is_bool(value_with_type_unknown_to_program_designer):
        if value_with_type_unknown_to_program_designer:
            return 10
        else:
            return 20
    else:
        return 'convert_to_non_negative_integer_use_isinstance failed to recognize type of input value'

class TestConvertToNonNegativeNumberUseIsinstance(unittest.TestCase):
    
    def test_convert_to_non_negative_integer_use_isinstance(self):
        self.assertEqual(convert_to_non_negative_integer_use_isinstance("hello"), 5)
        self.assertEqual(convert_to_non_negative_integer_use_isinstance(-1), 1)
        self.assertEqual(convert_to_non_negative_integer_use_isinstance(-1.0), 1.0)
        self.assertEqual(convert_to_non_negative_integer_use_isinstance(True), 10)
        self.assertEqual(convert_to_non_negative_integer_use_isinstance(False), 20)
