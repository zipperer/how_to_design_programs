from exercise78 import ThreeLetterWord, OneStringLowercase, OneStringLowercaseOrFalse
# Exercise 82. 
# Design the function compare-word. 
# The function consumes two three-letter words (see exercise 78). 
# It produces a word that indicates where the given ones agree and disagree. 
# The function retains the content of the structure fields if the two agree; 
# otherwise it places #false in the field of the resulting word. 
# Hint:
# The exercises mentions two tasks: the comparison of words and the comparison of “letters.” 

# compare-word
# ThreeLetterWord ThreeLetterWord -> ThreeLetterWord
# '''
# returns a ThreeLetterWord that indicates where the given ones agree and disagree.
# compare-word retains the content of the given structure fields where the two field agree;
# otherwise it places #false in the field of the resulting word.
# stub/header:
# def compare_word(three_letter_word_a : ThreeLetterWord,
#                  three_letter_word_b : ThreeLetterWord)
#                 -> ThreeLetterWord:
#   return ThreeLetterWord(first_letter='a',
#                          second_letter='i',
#                          third_letter='r')
# template:
# def compare_word(three_letter_word_a : ThreeLetterWord,
#                  three_letter_word_b : ThreeLetterWord)
#                 -> ThreeLetterWord:
#   return (...
#           (ThreeLetterWord(first_letter=...
#                            second_letter=...
#                            third_letter=...)
#           ...
#           three_letter_word_a.first_letter
#           ...
#           three_letter_word_a.second_letter
#           ...
#           three_letter_word_a.third_letter
#           ...
#           three_letter_word_b.first_letter
#           ...
#           three_letter_word_b.second_letter
#           ...
#           three_letter_word_b.third_letter
#           ...
#           )

def compare_word(three_letter_word_a : ThreeLetterWord,
                 three_letter_word_b : ThreeLetterWord
                 ) -> ThreeLetterWord:
  return ThreeLetterWord(first_letter=compare_letter(three_letter_word_a.first_letter,
                                                     three_letter_word_b.first_letter),
                         second_letter=compare_letter(three_letter_word_a.second_letter,
                                                      three_letter_word_b.second_letter),
                         third_letter=compare_letter(three_letter_word_a.third_letter,
                                                     three_letter_word_b.third_letter))

# compare-letter
# OneStringLowercaseOrFalse OneStringLowercaseOrFalse -> OneStringLowercaseOrFalse
# when both inputs are OneStringLowercase and the inputs equal each other return the input
# otherwise return False
# stub/header:
# def compare_letter(one_string_lowercase_or_false_a : OneStringLowercaseOrFalse,
#                    one_string_lowercase_or_false_b : OneStringLowercaseOrFalse
#                   ) -> OneStringLowercaseOrFalse:
#   return False
# template:
# def compare_letter(one_string_lowercase_or_false_a : OneStringLowercaseOrFalse,
#                    one_string_lowercase_or_false_b : OneStringLowercaseOrFalse
#                   ) -> OneStringLowercaseOrFalse:
#   return (
#          ...
#          one_string_lowercase_or_false_b
#          ...
#          one_string_lowercase_or_false_b
#          ...
#          )
def compare_letter_match_with_comments(one_string_lowercase_or_false_a : OneStringLowercaseOrFalse,
                                       one_string_lowercase_or_false_b : OneStringLowercaseOrFalse
                                       ) -> OneStringLowercaseOrFalse:
    match one_string_lowercase_or_false_a:
        # when case OneStringLowercase(string_of_length_1_lowercase): got error due to assuming positional argument: exercise82.py:81: error: Class "onestring.OneStringLowercase" doesn't define "__match_args__"  [misc]
        # when case OneStringLowercase(string_of_length_1_lowercase=input_string_of_length_1_lowercase): it works, but it provides unnecessary binding string_of_length_1_lowercase=input_string_of_length_1_lowercase
        case OneStringLowercase():
            return one_string_lowercase_or_false_a if one_string_lowercase_or_false_a == one_string_lowercase_or_false_b else False
        case _:
            return False

# works
# but use of guard is new, so use simpler form below
def compare_letter_match_with_guard(one_string_lowercase_or_false_a : OneStringLowercaseOrFalse,
                   one_string_lowercase_or_false_b : OneStringLowercaseOrFalse
                  ) -> OneStringLowercaseOrFalse:
    match one_string_lowercase_or_false_a:
        case OneStringLowercase() if one_string_lowercase_or_false_a == one_string_lowercase_or_false_b:
                return one_string_lowercase_or_false_a
        case _:
            return False

def compare_letter(one_string_lowercase_or_false_a : OneStringLowercaseOrFalse,
                   one_string_lowercase_or_false_b : OneStringLowercaseOrFalse
                  ) -> OneStringLowercaseOrFalse:
    match one_string_lowercase_or_false_a:
        case OneStringLowercase():
            if one_string_lowercase_or_false_a == one_string_lowercase_or_false_b:
                return one_string_lowercase_or_false_a
            else:
                return False
        case _:
            return False

# works
# not currently used
# I used this when the compare_letter function above that uses match gave an error
# I would use a version like this if working with team that did not use match
def compare_letter_if_else(one_string_lowercase_or_false_a : OneStringLowercaseOrFalse,
                   one_string_lowercase_or_false_b : OneStringLowercaseOrFalse
                  ) -> OneStringLowercaseOrFalse:
    if (isinstance(one_string_lowercase_or_false_a, OneStringLowercase) and
        isinstance(one_string_lowercase_or_false_b, OneStringLowercase) and
        one_string_lowercase_or_false_a == one_string_lowercase_or_false_b):
        return one_string_lowercase_or_false_a
    else:
        return False

import pytest

three_letter_word_air = ThreeLetterWord(first_letter=OneStringLowercase('a'),
                                        second_letter=OneStringLowercase('i'),
                                        third_letter=OneStringLowercase('r'))
three_letter_word_fir = ThreeLetterWord(first_letter=OneStringLowercase('f'),
                                        second_letter=OneStringLowercase('i'),
                                        third_letter=OneStringLowercase('r'))
three_letter_word_false_ir = ThreeLetterWord(first_letter=False,
                                             second_letter=OneStringLowercase('i'),
                                             third_letter=OneStringLowercase('r'))
three_letter_word_fig = ThreeLetterWord(first_letter=OneStringLowercase('f'),
                                        second_letter=OneStringLowercase('i'),
                                        third_letter=OneStringLowercase('g'))
three_letter_word_fi_false = ThreeLetterWord(first_letter=OneStringLowercase('f'),
                                             second_letter=OneStringLowercase('i'),
                                             third_letter=False)
three_letter_word_false_false_false = ThreeLetterWord(first_letter=False,
                                                      second_letter=False,
                                                      third_letter=False)

def test_compare_word():

    assert compare_word(three_letter_word_air, three_letter_word_air) == three_letter_word_air
    assert compare_word(three_letter_word_air, three_letter_word_fir) == three_letter_word_false_ir
    assert compare_word(three_letter_word_fir, three_letter_word_fig) == three_letter_word_fi_false
    assert compare_word(three_letter_word_air, three_letter_word_false_false_false) == three_letter_word_false_false_false

one_string_or_false_false : OneStringLowercaseOrFalse = False
one_string_or_false_one_string_a : OneStringLowercaseOrFalse = OneStringLowercase('a')
one_string_or_false_one_string_b : OneStringLowercaseOrFalse = OneStringLowercase('b')

def test_compare_letter():
    assert compare_letter(one_string_or_false_false, one_string_or_false_false) == one_string_or_false_false
    # made __eq__() method for OneString, OneStringLowercase
    assert compare_letter(one_string_or_false_false, one_string_or_false_one_string_a) == one_string_or_false_false
    assert compare_letter(one_string_or_false_one_string_a, one_string_or_false_false) == one_string_or_false_false
    assert compare_letter(one_string_or_false_one_string_a, one_string_or_false_one_string_b) == one_string_or_false_false
    assert compare_letter(one_string_or_false_one_string_a, one_string_or_false_one_string_a) == one_string_or_false_one_string_a
