import builtins
import unittest

def convert_to_non_negative_integer_use_builtins(value_with_type_unknown_to_program_designer):
    match type(value_with_type_unknown_to_program_designer):
      case builtins.str: # use builtins.str b/c using str alone causes str to be interpreted as a variable name, and anything will match to variable name
        return len(value_with_type_unknown_to_program_designer)
      # case Image -- have not looked for class that corresponds to (image? )
      case builtins.int | builtins.float: # either int or float. I intend this case corresponds roughly to case for (number? _)
        return abs(value_with_type_unknown_to_program_designer)
      case builtins.bool:
        if value_with_type_unknown_to_program_designer:
            return 10
        else:
            return 20
      case _:
        return "convert_to_non_negative_integer failed to recognize type"


class TestConvertToNonNegativeNumberUseBuiltins(unittest.TestCase):

    def test_convert_to_non_negative_integer_use_builtins(self):
        self.assertEqual(convert_to_non_negative_integer_use_builtins("hello"), 5)
        self.assertEqual(convert_to_non_negative_integer_use_builtins(-1), 1)
        self.assertEqual(convert_to_non_negative_integer_use_builtins(-1.0), 1.0)
        self.assertEqual(convert_to_non_negative_integer_use_builtins(True), 10)
        self.assertEqual(convert_to_non_negative_integer_use_builtins(False), 20)
        
