import unittest

string_to_test = "helloworld"
index_to_test = 5

def add_underscore_to_string_at_index(string, index):
    return string[:index] + '_' + string[index:]

class TestAddUnderscoreToStringAtIndex(unittest.TestCase):

    def test_add_underscore_to_string_at_index(self):
        self.assertEqual(add_underscore_to_string_at_index(string_to_test, index_to_test), 'hello_world')
