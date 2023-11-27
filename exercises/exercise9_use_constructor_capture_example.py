import unittest

def case_on_type_use_constructor(input_value):
    match input_value:
        case str(input_value_string):
            print(input_value_string)
            print(input_value_string + '!')
        case int(input_value_int):
            print(input_value_int)
            print(input_value_int + 1)
        case list(input_value_list):
            print(input_value_list)
            input_value_list.append('a')
            print(input_value_list)
        case dict(input_value_dict):
            for key, value in input_value_dict.items():
                print(key, ':', value)
        case _:
            print('did not match constructor')
    return type(input_value)

class TestCaseOnTypeUseConstructor(unittest.TestCase):

    def test_case_on_type_use_constructor(self):
        self.assertEqual(case_on_type_use_constructor("hello"), str)
        self.assertEqual(case_on_type_use_constructor(1), int)
        self.assertEqual(case_on_type_use_constructor([1, 2, 3]), list)
        self.assertEqual(case_on_type_use_constructor({'x' : 1, 'y' : 2}), dict)
        self.assertEqual(case_on_type_use_constructor(set()), set)
