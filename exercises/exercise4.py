import unittest

string_to_test = "helloworld"
index_to_test_in_range = 5
index_to_test_outside_range_too_high = 10
index_to_test_outside_range_too_low = -1

def remove_character_at_index(string, index):
    if ((index >= 0) and
        (index < len(string))):
        return string[0:index] + string[index + 1:]
    else:
        return string

class TestRemoveCharacterAtIndex(unittest.TestCase):

    def test_remove_character_at_index(self):
        self.assertEqual(remove_character_at_index(string_to_test, index_to_test_in_range), 'helloorld')
        self.assertEqual(remove_character_at_index(string_to_test, index_to_test_outside_range_too_high), 'helloworld')
        self.assertEqual(remove_character_at_index(string_to_test, index_to_test_outside_range_too_low), 'helloworld')
