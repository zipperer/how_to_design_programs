import unittest

def string_delete_index_valid(input_string, index_at_which_to_delete_character):
    input_string_length = len(input_string)
    return ((index_at_which_to_delete_character <= (input_string_length - 1)) and 
            (index_at_which_to_delete_character >= 0))

# string_delete_index_valid uses (input_string_length - 1). that could be input_string_length rather than (input_string_length - 1) b/c
# if my_string = "hey" 
# then my_string[3:] is ''.
# I use (input_string_length - 1) because in Beginning Student Language (substring string index_start) requires index_start be less than the length,
# and I chose to keep the .py version in line with the .rkt version

def string_delete(input_string, index_at_which_to_delete_character):
    ''' returns a string -- takes input_string and removes character at index_at_which_to_delete_character'''
    if string_delete_index_valid(input_string, index_at_which_to_delete_character):
        input_string_up_to_and_excluding_character_at_index = input_string[:index_at_which_to_delete_character]
        input_string_after_index = input_string[index_at_which_to_delete_character + 1:]
        output_string = input_string_up_to_and_excluding_character_at_index + input_string_after_index
        return output_string
    else:
        return input_string

class TestStringDelete(unittest.TestCase):

    def test_string_delete(self):
        self.assertEqual(string_delete('hey', 0), 'ey')
        self.assertEqual(string_delete('hey', 1), 'hy')
        self.assertEqual(string_delete('hey', 2), 'he')
        self.assertEqual(string_delete('hey', 3), 'hey')
        self.assertEqual(string_delete('hey', -1), 'hey')
        self.assertEqual(string_delete('', 0), '')
