import unittest
import exercise18

def string_insert_valid_index(input_string, index_where_to_insert_underscore):
    input_string_length = len(input_string)
    return ((index_where_to_insert_underscore <= input_string_length) and
            (index_where_to_insert_underscore >= 0))
        
def string_insert(input_string, index_where_to_insert_underscore):
    ''' returns a string -- take input_string and insert _ at index_where_to_insert_underscore'''
    if string_insert_valid_index(input_string, index_where_to_insert_underscore):
        input_string_up_to_and_excluding_character_at_index = input_string[:index_where_to_insert_underscore]
        input_string_starting_at_index = input_string[index_where_to_insert_underscore:]
        output_string = exercise18.string_join(input_string_up_to_and_excluding_character_at_index, input_string_starting_at_index)
        return output_string
    else:
        return input_string
    
class TestStringInsert(unittest.TestCase):

    def test_string_insert(self):
        self.assertEqual(string_insert('hi', 1), 'h_i')
        self.assertEqual(string_insert('hi', 0), '_hi')
        self.assertEqual(string_insert('hi', 2), 'hi_')
        self.assertEqual(string_insert('hi', -1), 'hi')
        self.assertEqual(string_insert('', 0), '_')
