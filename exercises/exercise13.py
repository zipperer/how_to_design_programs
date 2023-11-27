import unittest

def string_first(non_empty_string):
    '''compute first character in non-empty-string'''
    return non_empty_string[0]

class TestStringFirst(unittest.TestCase):

    def test_string_first(self):
        self.assertEqual(string_first('hello'), 'h')
        self.assertEqual(string_first('world'), 'w')
    
