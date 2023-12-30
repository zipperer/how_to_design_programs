# Exercise 78
# Provide a structure type and a data definition for representing three-letter words.
# A word consists of lowercase letters, represented with the 1Strings "a" through "z"
# plus #false.
# Note:
# This exercise is a part of the design of a hangman game; see exercise 396.

from dataclasses import dataclass
from typing import Union, Literal
from onestring import OneStringLowercase

OneStringLowercaseOrFalse = Union[OneStringLowercase, Literal[False]]
# i.e. 
# A OneStringLowercaseOrFalse is one of:
# - OneStringLowercase
# - False
# For example:
example_one_string_lowercase_or_false_0 : OneStringLowercaseOrFalse = False
example_one_string_lowercase_or_false_1 : OneStringLowercaseOrFalse = OneStringLowercase('a')
example_one_string_lowercase_or_false_2 : OneStringLowercaseOrFalse = OneStringLowercase('z')
example_one_string_lowercase_or_false_3 : OneStringLowercaseOrFalse = OneStringLowercase('j')

# A OneStringLowercase is one of:
# - "a"
# - ...
# - "z"
example_one_string_lowercase_0 = OneStringLowercase('a')
example_one_string_lowercase_1 = OneStringLowercase('z')
example_one_string_lowercase_2 = OneStringLowercase('j')


# alternatively put:
# A OneStringLowercase is a OneString with constraint:
# - the OneString is lowercase, i.e. if os is a OneString, then os.lower() == os

@dataclass
class ThreeLetterWord:
    '''
    A ThreeLetterWord is a structure:
      ThreeLetterWord(OneStringLowercaseOrFalse, OneStringLowercaseOrFalse, OneStringLowercaseOrFalse)
    interpretation:
      ThreeLetterWord(first_letter0, second_letter0, third_letter0) represents a three letter word with first letter
      first_letter0, second letter second_letter0, and third letter third_letter0.
    Each of first_letter0, second_letter0, and third_letter0 are in OneStringLowercaseOrFalse.
    For example,
      ThreeLetterWord(first_letter='a', second_letter='i', third_letter='r') represents the word 'air'.
      ThreeLetterWord(first_letter='f', second_letter='i', third_letter='g') represents the word 'fig'.
      ThreeLetterWord(first_letter='f', second_letter=False, third_letter='g') represents the word 'f_g'.
    '''
    first_letter : OneStringLowercaseOrFalse
    second_letter : OneStringLowercaseOrFalse
    third_letter : OneStringLowercaseOrFalse

example_three_letter_word_0 = ThreeLetterWord(first_letter='a', second_letter='i', third_letter='r') # represents the word 'air'
example_three_letter_word_1 = ThreeLetterWord(first_letter='f', second_letter='i', third_letter='g') # represents the word 'fig'
example_three_letter_word_2 = ThreeLetterWord(first_letter='f', second_letter=False, third_letter='g') # represents the word 'f_g', i.e. the second letter is a blank. See exercise 396.
