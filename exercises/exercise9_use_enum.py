import unittest
from enum import Enum

class TypesRelevantToThisProblem(Enum):
    STR_TYPE = str
    INT_TYPE = int
    FLOAT_TYPE = float
    BOOL_TYPE = bool

# https://docs.python.org/3/tutorial/controlflow.html#match-statements -- see example that uses Enum
# do not know why this did not work
def convert_to_non_negative_integer_use_enum(value_with_type_unknown_to_program_designer):
    match type(value_with_type_unknown_to_program_designer):
      case TypesRelevantToThisProblem.STR_TYPE: # this fails to match for value_with_type_unknown_to_program_designer = 'hello'
        return len(value_with_type_unknown_to_program_designer)
      case TypesRelevantToThisProblem.INT_TYPE | TypesRelevantToThisProblem.FLOAT_TYPE:
        return abs(value_with_type_unknown_to_program_designer)
      case TypesRelevantToThisProblem.BOOL_TYPE:
        if value_with_type_unknown_to_program_designer:
            return 10
        else:
            return 20
      case _:
        return "convert_to_non_negative_integer_use_enum failed to recognize type"

class TestConvertToNonNegativeNumberUseEnum(unittest.TestCase):

    def test_convert_to_non_negative_integer_use_enum(self):
        self.assertEqual(convert_to_non_negative_integer_use_enum("hello"), 5)
        self.assertEqual(convert_to_non_negative_integer_use_enum(-1), 1)
        self.assertEqual(convert_to_non_negative_integer_use_enum(-1.0), 1.0)
        self.assertEqual(convert_to_non_negative_integer_use_enum(True), 10)
        self.assertEqual(convert_to_non_negative_integer_use_enum(False), 20)
