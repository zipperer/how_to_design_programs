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

# A OneStringLowercase is one of:
# - "a"
# - ...
# - "z"

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
