import unittest

def string_last(non_empty_string):
    '''compute last character in non-empty-string'''
    index_of_last_character = -1
    last_character = non_empty_string[index_of_last_character]
    return last_character

class TestStringLast(unittest.TestCase):

    def test_string_last(self):
        self.assertEqual(string_last('hello'), 'o')
        self.assertEqual(string_last('world'), 'd')
