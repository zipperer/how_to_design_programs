# Exercise 171. 

# You know what the data definition for List-of-strings looks like. Spell it out. 

# Make sure that you can represent Piet Hein’s poem as an instance of the definition 
#   where each line is represented as a string and another instance where each word 
#   is a string. 
# Use read-lines and read-words to confirm your representation choices.

# Next develop the data definition for List-of-list-of-strings. 
#   Again, represent Piet Hein’s poem as an instance of the definition where 
#   each line is represented as a list of strings, one per word, and the entire 
#   poem is a list of such line representations. 
# You may use read-words/line to confirm your choice.

from python_list_utilities import cons

# A List-of-strings is one of:
# []
# cons(String, List-of-strings)
# For example:
# []
# cons("hello", []) i.e. ["hello"]
# cons("hello", cons("friend", [])) i.e. ["hello", "friend"]

PIET_HEIN_POEM_AS_LIST_OF_STRINGS_ONE_STRING_PER_LINE  = [
    "TTT",
    "Put up in a place",
    "where it's easy to see",
    "the cryptic admonishment",
    "T.T.T.",
    "When you feel how depressingly",
    "slowly you climb",
    "it's well to remember that",
    "Things Take Time.",
    "Piet Hein"
]

PIET_HEIN_POEM_FILENAME = '../DrRacket/examples/arbitrarily_large_data/ttt-formatted.txt'

with open(PIET_HEIN_POEM_FILENAME, 'r', encoding='utf-8') as file_object:
    file_object_contents_as_list_of_strings_one_string_per_line = file_object.readlines()
    file_object_contents_as_list_of_strings_one_string_per_line_stripped = list(map(lambda line_as_string: line_as_string.strip(), file_object_contents_as_list_of_strings_one_string_per_line))
    print(file_object_contents_as_list_of_strings_one_string_per_line_stripped)


[
    'TTT', 
    '', 
    'Put up in a place', 
    "where it's easy to see", 
    'the cryptic admonishment', 
    'T.T.T.', 
    '', 
    'When you feel how depressingly', 
    'slowly you climb,',
    "it's well to remember that", 
    'Things Take Time.', 
    '', 
    'Piet Hein'
]



# To make 
# - PIET_HEIN_POEM_AS_LIST_OF_STRINGS_ONE_STRING_PER_WORD from 
# - PIET_HEIN_POEM_AS_LIST_OF_STRINGS_ONE_STRING_PER_LINE
# 
#import functools
#functools.reduce(
#    lambda first_list, second_list: first_list + second_list, 
#    map(lambda line: line.split(' '), PIET_HEIN_POEM_AS_LIST_OF_STRINGS_ONE_STRING_PER_LINE), 
#    [])

PIET_HEIN_POEM_AS_LIST_OF_STRINGS_ONE_STRING_PER_WORD = [
    'TTT', 
    'Put', 'up', 'in', 'a', 'place', 
    'where', "it's", 'easy', 'to', 'see', 
    'the', 'cryptic', 'admonishment', 
    'T.T.T.', 
    'When', 'you', 'feel', 'how', 'depressingly', 
    'slowly', 'you', 'climb', 
    "it's", 'well', 'to', 'remember', 'that', 
    'Things', 'Take', 'Time.', 
    'Piet', 'Hein'
]

import functools

# see also ../DrRacket/examples/arbitrarily_large_data/python_read_words.py -- read_words
with open(PIET_HEIN_POEM_FILENAME, 'r', encoding='utf-8') as file_object:
    file_object_contents_as_list_of_strings_one_string_per_line = file_object.readlines()
    file_object_contents_as_list_of_strings_one_string_per_line_stripped = list(map(lambda line_as_string: line_as_string.strip(), file_object_contents_as_list_of_strings_one_string_per_line))
    # ['line1 contents', 'line2 contents too'] -> iterable([['line1', 'contents'], ['line2', 'contents', 'too']])
    file_object_contents_as_iterable_of_lists_of_strings_one_string_per_word = map(
        lambda string_for_line: string_for_line.split(' '),
        file_object_contents_as_list_of_strings_one_string_per_line_stripped)
    file_object_contents_as_iterable_of_strings_one_string_per_word = functools.reduce(
        lambda list_of_strings_first, list_of_strings_second: list_of_strings_first + list_of_strings_second,
        file_object_contents_as_iterable_of_lists_of_strings_one_string_per_word)
    file_object_contents_as_list_of_strings_one_string_per_word = list(file_object_contents_as_iterable_of_strings_one_string_per_word)
    print(file_object_contents_as_list_of_strings_one_string_per_word)

['TTT', 
 '', 
 'Put', 'up', 'in', 'a', 'place', 
 'where', "it's", 'easy', 'to', 'see', 
 'the', 'cryptic', 'admonishment', 
 'T.T.T.', 
 '', 
 'When', 'you', 'feel', 'how', 'depressingly', 
 'slowly', 'you', 'climb,', 
 "it's", 'well', 'to', 'remember', 'that', 
 'Things', 'Take', 'Time.', 
 '', 
 'Piet', 'Hein'
 ]


# A List-of-list-of-strings is one of:
# []
# cons(List-of-strings, List-of-list-of-strings) -- i.e. [List-of-strings] + List-of-list-of-strings
# For example:
# []
# [['hello', 'friend']]
# [['hello', 'friend'], 
#  ['bonjour', 'ami']
#  ['hallo', 'freund']
# ]

PIET_HEIN_POEM_AS_LIST_OF_LIST_OF_STRINGS_ONE_STRING_PER_WORD = [
    ['TTT'], 
    ['Put', 'up', 'in', 'a', 'place'], 
    ['where', "it's", 'easy', 'to', 'see'], 
    ['the', 'cryptic', 'admonishment'], 
    ['T.T.T.'], 
    ['When', 'you', 'feel', 'how', 'depressingly'], 
    ['slowly', 'you', 'climb'], 
    ["it's", 'well', 'to', 'remember', 'that'], 
    ['Things', 'Take', 'Time.'], 
    ['Piet', 'Hein']
]

# To make
# PIET_HEIN_POEM_AS_LIST_OF_LIST_OF_STRINGS_ONE_STRING_PER_WORD from
# PIET_HEIN_POEM_AS_LIST_OF_STRINGS_ONE_STRING_PER_LINE
#
# list(map(lambda line_as_string: line_as_string.split(), PIET_HEIN_POEM_AS_LIST_OF_STRINGS_ONE_STRING_PER_LINE))

# see also ../DrRacket/examples/arbitrarily_large_data/python_read_words.py -- read_words_per_line
with open(PIET_HEIN_POEM_FILENAME, 'r', encoding='utf-8') as file_object:
    file_object_list_of_strings = file_object.readlines()
    file_object_list_of_strings_stripped = list(map(lambda line_as_string: line_as_string.strip(),
                                                    file_object_list_of_strings))
    file_object_list_of_list_of_strings = list(map(lambda line_as_string: line_as_string.split(' '),
                                                   file_object_list_of_strings_stripped))
    print(file_object_list_of_list_of_strings)
