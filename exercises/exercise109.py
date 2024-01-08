# Exercise 109
# Design a world program that recognizes a pattern in a sequence of KeyEvents. 
# Initially the program shows a 100 by 100 white rectangle. 
# Once your program has encountered the first desired letter, it displays a yellow rectangle of the same size. 
# After encountering the final letter, the color of the rectangle turns green. 
# If any “bad” key event occurs, the program displays a red rectangle.

# The specific sequences that your program looks for start with "a", 
# followed by an arbitrarily long mix of "b" and "c", and ended by a "d". 
# Clearly, "acbd" is one example of an acceptable string; two others are "ad" 
# and "abcbbbcd". Of course, "da", "aa", or "d" do not match.
# See figure 37 or see DIAGRAM in exercise109.rkt

# ExpectsToSee.v1 is one of:
# - "start, expect an 'a'"
# - "expect 'b', 'c', or 'd'
# - "finished"
# - "error, illegal key"

# ExpectsToSee.v2 is one of:
# - AA
# - BB
# - DD
# - ER

#from typing import Union,Literal
#ExpectsToSeeV2 = Union[Literal[AA],
#                       Literal[BB],
#                       Literal[DD],
#                       Literal[ER]]

from enum import Enum
class ExpectsToSeeV2(Enum):
    AA = "start, expect an 'a'"
    BB = "expect 'b', 'c', or 'd'"
    DD = "finished"
    ER = "error, illegal key"

def handle_key(expects_to_see_v2 : ExpectsToSeeV2,
               key_event : str
               ) -> ExpectsToSeeV2:
    match expects_to_see_v2:
        case ExpectsToSeeV2.AA if key_event == 'a':
            return ExpectsToSeeV2.BB
        case ExpectsToSeeV2.BB if (key_event == 'b' or key_event == 'c'):
            return ExpectsToSeeV2.BB
        case ExpectsToSeeV2.BB if key_event == 'd':
            return ExpectsToSeeV2.DD
        case ExpectsToSeeV2.DD:
            return ExpectsToSeeV2.DD
        case ExpectsToSeeV2.ER:
            return ExpectsToSeeV2.ER
        case _:
            return ExpectsToSeeV2.ER

import pytest

def test_handle_key():
    assert handle_key(ExpectsToSeeV2.AA, 'a') == ExpectsToSeeV2.BB
    assert handle_key(ExpectsToSeeV2.AA, 'b') == ExpectsToSeeV2.ER
    assert handle_key(ExpectsToSeeV2.BB, 'b') == ExpectsToSeeV2.BB
    assert handle_key(ExpectsToSeeV2.BB, 'c') == ExpectsToSeeV2.BB
    assert handle_key(ExpectsToSeeV2.BB, 'a') == ExpectsToSeeV2.ER
    assert handle_key(ExpectsToSeeV2.BB, 'd') == ExpectsToSeeV2.DD
    assert handle_key(ExpectsToSeeV2.DD, 'x') == ExpectsToSeeV2.DD
    assert handle_key(ExpectsToSeeV2.ER, 'a') == ExpectsToSeeV2.ER
