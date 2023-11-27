import unittest

def string_first(non_empty_string):
    '''compute first character in non-empty-string'''
    index_of_first_character = 0
    return non_empty_string[index_of_first_character]

class TestStringFirst(unittest.TestCase):

    def test_string_first(self):
        self.assertEqual(string_first('hello'), 'h')
        self.assertEqual(string_first('world'), 'w')
    
