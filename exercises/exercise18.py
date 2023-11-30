import unittest

def string_join(input_string_left, input_string_right):
    '''concatenates two strings with a _ between the strings'''
    output_string = input_string_left + '_' + input_string_right
    return output_string
    
class TestStringJoin(unittest.TestCase):

    def test_string_join(self):
        self.assertEqual(string_join('hello', 'world'), 'hello_world')
        self.assertEqual(string_join('right', 'on'), 'right_on')
