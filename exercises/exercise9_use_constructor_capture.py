import unittest

def convert_to_non_negative_integer_use_constructor_capture(value_with_type_unknown_to_program_designer):
    match value_with_type_unknown_to_program_designer:
      case str(string_value):
        return len(string_value)
      case bool(truth_value): # this case is above int | float case, b/c each bool is an int, so if int | float case above bool case, then bools will match to int | float case
        if truth_value:
            return 10
        else:
            return 20
      case int(number_value) | float(number_value):
        return abs(number_value)
      case _:
        return "convert_to_non_negative_integer_use_constructor_capture failed to recognize type"


class TestConvertToNonNegativeNumberUseConstructorCapture(unittest.TestCase):

    def test_convert_to_non_negative_integer_use_constructor_capture(self):
        self.assertEqual(convert_to_non_negative_integer_use_constructor_capture("hello"), 5)
        self.assertEqual(convert_to_non_negative_integer_use_constructor_capture(-1), 1)
        self.assertEqual(convert_to_non_negative_integer_use_constructor_capture(-1.0), 1.0)
        self.assertEqual(convert_to_non_negative_integer_use_constructor_capture(True), 10)
        self.assertEqual(convert_to_non_negative_integer_use_constructor_capture(False), 20)
        
