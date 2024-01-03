# Exercise 87 
# Develop a data representation for an editor based on our first idea, 
# using a string and an index. Then solve the preceding exercises again. 
# Retrace the design recipe.

# We can imagine several different ways of going from the information to data and back. 
# For example, one field in the structure may contain the entire text entered, and the 
# other the number of characters between the first character (counting from the left) and the cursor.

from dataclasses import dataclass

String = str

@dataclass
class Editor:
    '''
    An Editor is a structure:
       Editor(editor_text : String, editor_number_characters_between_first_character_and_cursor: int)
    interpretation:
       Editor(editor_text=editor_text0, editor_number_characters_between_first_character_and_cursor=num_chars)
       represents an editor with text editor_text0 and num_chars characters between first character and cursor.
    '''
    editor_text: String
    editor_number_characters_between_first_character_and_cursor: int

# For example:
editor_with_text_a_and_cursor_to_left_of_first_character = Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=-1) # represents an editor with text 'a' and the cursor to the left of the first character.
editor_with_text_a_and_cursor_to_right_of_first_character = Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=0) # represents an editor with text 'a' and the cursor to the right of the first character.
editor_with_text_ab_and_cursor_to_right_of_first_character = Editor(editor_text='ab', editor_number_characters_between_first_character_and_cursor=0) # represents an editor with text 'ab' and the cursor to the right of the first character.
editor_with_text_ab_and_cursor_to_the_right_of_the_second_character = Editor(editor_text='ab', editor_number_characters_between_first_character_and_cursor=1) # represents an editor with text 'ab' and the cursor to the right of the second character.
editor_with_text_abc_and_cursor_to_right_of_second_character = Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=1) # represents an editor with text 'abc' and the cursor to the right of the second character.
editor_with_text_abc_and_cursor_to_right_of_third_character = Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=2) # represents an editor with text 'abc' and the cursor to the right of the third character.
# Observe that editor_number_characters_between_first_character_and_cursor is in the interval [-1, len(editor_text) -1]

# Exercise 84
# Design edit.
# The function consumes two inputs, an editor ed and a KeyEvent ke, and it produces another editor. 
# Its task is to add a single-character KeyEvent ke to the end of the pre field of ed, 
# unless ke denotes the backspace ("\b") key. In that case, it deletes the character immediately 
# to the left of the cursor (if there are any). 
# The function ignores the tab key ("\t") and the return key ("\r").
# The function pays attention to only two KeyEvents longer than one letter: "left" and "right". 
# The left arrow moves the cursor one character to the left (if any), and the right arrow moves 
# it one character to the right (if any). All other such KeyEvents are ignored.

# Develop a goodly number of examples for edit, paying attention to special cases. 
# When we solved this exercise, we created 20 examples and turned all of them into tests.

# Hint:
# Think of this function as consuming KeyEvents, a collection that is specified as an enumeration. 
# It uses auxiliary functions to deal with the Editor structure. 
# Keep a wish list handy; you will need to design additional functions for most of these auxiliary 
# functions, such as string-first, string-rest, string-last, and string-remove-last.

# Editor KeyEvent -> Editor
# apply KeyEvent to given Editor to produce a new Editor
# - when the KeyEvent is "\b" and there is a character to the left of the cursor, remove that character
# - when the KeyEvent is "\t" or "\r", ignore it
# - when the KeyEvent is "left" or "right", move the cursor in that direction if possible
# -- moving the cursor is not possible when the cursor is to the left of the left-most character or to the right of
#    the right-most character
# - when the KeyEvent is a letter, number, ..., add that character to the Editor

from enum import Enum
class KeyEventNamedKeys(Enum):
    BACKSPACE_KEY='\b'
    TAB_KEY='\t'
    RETURN_KEY='\r'

def edit(editor : Editor,
         key_event : String # KeyEvent
         ) -> Editor:
    # editor.editor_text # String
    # editor.editor_number_characters_between_first_character_and_cursor # int
    # key_event # String
    match key_event:
        case KeyEventNamedKeys.BACKSPACE_KEY:
            return make_editor_apply_backspace(editor)
        case KeyEventNamedKeys.TAB_KEY | KeyEventNamedKeys.RETURN_KEY:
            return editor
        case 'left' | 'right':
            return make_editor_apply_arrow_key(editor, key_event)
        case _:
            return make_editor_apply_character(editor, key_event, LIMIT_WIDTH_OF_EDITOR_TEXT)

# Editor -> Editor
# when the KeyEvent is "\b" and there is a character to the left of the cursor, remove that character
# def make_editor_apply_backspace(editor):
#   return editor
# def make_editor_apply_backspace(editor):
#   ... editor.editor_text # String
#   ... editor.editor_number_characters_between_first_character_and_cursor # int
#   return editor
def make_editor_apply_backspace(editor : Editor) -> Editor:
    match editor.editor_number_characters_between_first_character_and_cursor:
        case -1:
            return editor
        case 0:
            return Editor(editor_text=string_rest(editor.editor_text),
                          editor_number_characters_between_first_character_and_cursor=-1)
        case _:
            return Editor(editor_text=string_append(editor.editor_text[:editor.editor_number_characters_between_first_character_and_cursor],
                                                    editor.editor_text[editor.editor_number_characters_between_first_character_and_cursor + 1:]),
                          editor_number_characters_between_first_character_and_cursor=sub1(editor.editor_number_characters_between_first_character_and_cursor))

# Editor KeyEvent -> Editor
# - when the KeyEvent is "left" or "right", move the cursor in that direction if possible
# -- moving the cursor is not possible when the cursor is to the left of the left-most character or to the right of
#    the right-most character
def make_editor_apply_arrow_key(editor : Editor, 
                                key_event : String
                                ) -> Editor:
    match key_event:
        case 'left' if editor.editor_number_characters_between_first_character_and_cursor == -1:
            return editor
        case 'left':
            return Editor(editor_text=editor.editor_text,
                          editor_number_characters_between_first_character_and_cursor=sub1(editor.editor_number_characters_between_first_character_and_cursor))
        case 'right' if editor.editor_number_characters_between_first_character_and_cursor == (len(editor.editor_text) - 1):
            return editor
        case _: # i.e. case 'right'
            return Editor(editor_text=editor.editor_text,
                          editor_number_characters_between_first_character_and_cursor=add1(editor.editor_number_characters_between_first_character_and_cursor))

LIMIT_WIDTH_OF_EDITOR_TEXT=True # True for Exercise 86
MAX_CHARACTERS_IN_EDITOR_TEXT = 25

# Editor KeyEvent-character -> Editor
# - when the KeyEvent is a letter, number, ..., add that character to the Editor
# def make_editor_apply_character(editor, key_event):
#   return editor
def make_editor_apply_character(editor : Editor, 
                                key_event : String,
                                limit_width_of_editor_text=False
                                ) -> Editor:
    match editor.editor_number_characters_between_first_character_and_cursor:
        case -1:
            return Editor(editor_text=string_append(key_event, editor.editor_text),
                          editor_number_characters_between_first_character_and_cursor=0)
        case 0:
            return Editor(editor_text=string_append(editor.editor_text, key_event),
                          editor_number_characters_between_first_character_and_cursor=1)
        case _:
            if len(editor.editor_text) >= MAX_CHARACTERS_IN_EDITOR_TEXT:
                return editor
            else:
                return Editor(editor_text=string_append(editor.editor_text[:editor.editor_number_characters_between_first_character_and_cursor + 1],
                                                        key_event,
                                                        editor.editor_text[editor.editor_number_characters_between_first_character_and_cursor + 1:]),
                              editor_number_characters_between_first_character_and_cursor=add1(editor.editor_number_characters_between_first_character_and_cursor))

# Exercise 86
# Notice that if you type a lot, your editor program does not display all of the text. 
# Instead the text is cut off at the right margin. 
# Modify your function edit from exercise 84 so that it ignores a keystroke if adding 
# it to the end of the pre field would mean the rendered text is too wide for your canvas. 

def sub1(number : int) -> int:
    return number - 1

def add1(number : int) -> int:
    return number + 1

def string_rest(string_possibly_empty: String) -> String:
    length_string_possibly_empty = len(string_possibly_empty)
    if length_string_possibly_empty == 0:
        return ''
    else:
        return string_possibly_empty[1:]

def string_append(*args : String) -> String:
    return str.join('', args)

import unittest

class TestEdit(unittest.TestCase):

    def test_edit(self):
        # backspace '\b'
        self.assertEqual(edit(Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=-1), '\b'),
                         Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=-1))
        self.assertEqual(edit(Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=0), '\b'),
                         Editor(editor_text='', editor_number_characters_between_first_character_and_cursor=-1))
        self.assertEqual(edit(Editor(editor_text='ab', editor_number_characters_between_first_character_and_cursor=1), '\b'),
                         Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=0))
        self.assertEqual(edit(Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=1), '\b'),
                         Editor(editor_text='ac', editor_number_characters_between_first_character_and_cursor=0))
        self.assertEqual(edit(Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=2), '\b'),
                         Editor(editor_text='ab', editor_number_characters_between_first_character_and_cursor=1))

        # left arrow key 'left'
        self.assertEqual(edit(Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=-1), 'left'),
                         Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=-1))
        self.assertEqual(edit(Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=0), 'left'),
                         Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=-1))
        self.assertEqual(edit(Editor(editor_text='ab', editor_number_characters_between_first_character_and_cursor=1), 'left'),
                         Editor(editor_text='ab', editor_number_characters_between_first_character_and_cursor=0))
        self.assertEqual(edit(Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=1), 'left'),
                         Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=0))
        self.assertEqual(edit(Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=2), 'left'),
                         Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=1))

        # left arrow key 'right'
        self.assertEqual(edit(Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=-1), 'right'),
                         Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=0))
        self.assertEqual(edit(Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=0), 'right'),
                         Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=0))
        self.assertEqual(edit(Editor(editor_text='ab', editor_number_characters_between_first_character_and_cursor=1), 'right'),
                         Editor(editor_text='ab', editor_number_characters_between_first_character_and_cursor=1))
        self.assertEqual(edit(Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=1), 'right'),
                         Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=2))
        self.assertEqual(edit(Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=2), 'right'),
                         Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=2))

        # '\t' and '\r'
        self.assertEqual(edit(Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=-1), '\t'),
                         Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=-1))
        self.assertEqual(edit(Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=0), '\r'),
                         Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=0))
        self.assertEqual(edit(Editor(editor_text='ab', editor_number_characters_between_first_character_and_cursor=1), '\t'),
                         Editor(editor_text='ab', editor_number_characters_between_first_character_and_cursor=1))
        self.assertEqual(edit(Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=1), '\r'),
                         Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=1))
        self.assertEqual(edit(Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=2), '\t'),
                         Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=2))

        # letters, digits, ...
        self.assertEqual(edit(Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=-1), 'z'),
                         Editor(editor_text='za', editor_number_characters_between_first_character_and_cursor=0))
        self.assertEqual(edit(Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=0), 'b'),
                         Editor(editor_text='ab', editor_number_characters_between_first_character_and_cursor=1))
        self.assertEqual(edit(Editor(editor_text='ab', editor_number_characters_between_first_character_and_cursor=1), 'c'),
                         Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=2))
        self.assertEqual(edit(Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=1), '8'),
                         Editor(editor_text='ab8c', editor_number_characters_between_first_character_and_cursor=2))
        self.assertEqual(edit(Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=2), 'd'),
                         Editor(editor_text='abcd', editor_number_characters_between_first_character_and_cursor=3))


    def test_make_editor_apply_backspace(self):
        # backspace '\b'
        self.assertEqual(make_editor_apply_backspace(Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=-1)),
                         Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=-1))
        self.assertEqual(make_editor_apply_backspace(Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=0)),
                         Editor(editor_text='', editor_number_characters_between_first_character_and_cursor=-1))
        self.assertEqual(make_editor_apply_backspace(Editor(editor_text='ab', editor_number_characters_between_first_character_and_cursor=1)),
                         Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=0))
        self.assertEqual(make_editor_apply_backspace(Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=1)),
                         Editor(editor_text='ac', editor_number_characters_between_first_character_and_cursor=0))
        self.assertEqual(make_editor_apply_backspace(Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=2)),
                         Editor(editor_text='ab', editor_number_characters_between_first_character_and_cursor=1))

    def test_make_editor_apply_arrow_key(self):
                # left arrow key 'left'
        self.assertEqual(make_editor_apply_arrow_key(Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=-1), 'left'),
                         Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=-1))
        self.assertEqual(make_editor_apply_arrow_key(Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=0), 'left'),
                         Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=-1))
        self.assertEqual(make_editor_apply_arrow_key(Editor(editor_text='ab', editor_number_characters_between_first_character_and_cursor=1), 'left'),
                         Editor(editor_text='ab', editor_number_characters_between_first_character_and_cursor=0))
        self.assertEqual(make_editor_apply_arrow_key(Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=1), 'left'),
                         Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=0))
        self.assertEqual(make_editor_apply_arrow_key(Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=2), 'left'),
                         Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=1))

        # left arrow key 'right'
        self.assertEqual(make_editor_apply_arrow_key(Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=-1), 'right'),
                         Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=0))
        self.assertEqual(make_editor_apply_arrow_key(Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=0), 'right'),
                         Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=0))
        self.assertEqual(make_editor_apply_arrow_key(Editor(editor_text='ab', editor_number_characters_between_first_character_and_cursor=1), 'right'),
                         Editor(editor_text='ab', editor_number_characters_between_first_character_and_cursor=1))
        self.assertEqual(make_editor_apply_arrow_key(Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=1), 'right'),
                         Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=2))
        self.assertEqual(make_editor_apply_arrow_key(Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=2), 'right'),
                         Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=2))


    def test_make_editor_apply_character(self):
        # letters, digits, ...
        self.assertEqual(make_editor_apply_character(Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=-1), 'z'),
                         Editor(editor_text='za', editor_number_characters_between_first_character_and_cursor=0))
        self.assertEqual(make_editor_apply_character(Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=0), 'b'),
                         Editor(editor_text='ab', editor_number_characters_between_first_character_and_cursor=1))
        self.assertEqual(make_editor_apply_character(Editor(editor_text='ab', editor_number_characters_between_first_character_and_cursor=1), 'c'),
                         Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=2))
        self.assertEqual(make_editor_apply_character(Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=1), '8'),
                         Editor(editor_text='ab8c', editor_number_characters_between_first_character_and_cursor=2))
        self.assertEqual(make_editor_apply_character(Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=2), 'd'),
                         Editor(editor_text='abcd', editor_number_characters_between_first_character_and_cursor=3))

        # after reach max number of letters, do not add letters
        ## before max
        self.assertEqual(make_editor_apply_character(Editor(editor_text='abcdefghijklmnopqrstuvwx', editor_number_characters_between_first_character_and_cursor=23), 'y'),
                     Editor(editor_text='abcdefghijklmnopqrstuvwxy', editor_number_characters_between_first_character_and_cursor=24))
        ## after max
        self.assertEqual(make_editor_apply_character(Editor(editor_text='abcdefghijklmnopqrstuvwxy', editor_number_characters_between_first_character_and_cursor=24), 'z'), 
                     Editor(editor_text='abcdefghijklmnopqrstuvwxy', editor_number_characters_between_first_character_and_cursor=24))
        
import pytest

def test_edit_pytest():
        # backspace '\b'
        assert edit(Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=-1), '\b') == Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=-1)
        assert edit(Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=0), '\b') == Editor(editor_text='', editor_number_characters_between_first_character_and_cursor=-1)
        assert edit(Editor(editor_text='ab', editor_number_characters_between_first_character_and_cursor=1), '\b') == Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=0)
        assert edit(Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=1), '\b') == Editor(editor_text='ac', editor_number_characters_between_first_character_and_cursor=0)
        assert edit(Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=2), '\b') == Editor(editor_text='ab', editor_number_characters_between_first_character_and_cursor=1)

        # left arrow key 'left'
        assert edit(Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=-1), 'left') == Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=-1)
        assert edit(Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=0), 'left') == Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=-1)
        assert edit(Editor(editor_text='ab', editor_number_characters_between_first_character_and_cursor=1), 'left') == Editor(editor_text='ab', editor_number_characters_between_first_character_and_cursor=0)
        assert edit(Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=1), 'left') == Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=0)
        assert edit(Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=2), 'left') == Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=1)
        
        # left arrow key 'right'
        assert edit(Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=-1), 'right') == Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=0)
        assert edit(Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=0), 'right') == Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=0)
        assert edit(Editor(editor_text='ab', editor_number_characters_between_first_character_and_cursor=1), 'right') == Editor(editor_text='ab', editor_number_characters_between_first_character_and_cursor=1)
        assert edit(Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=1), 'right') == Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=2)
        assert edit(Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=2), 'right') == Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=2)
        
        # '\t' and '\r'
        assert edit(Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=-1), '\t') == Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=-1)
        assert edit(Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=0), '\r') == Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=0)
        assert edit(Editor(editor_text='ab', editor_number_characters_between_first_character_and_cursor=1), '\t') == Editor(editor_text='ab', editor_number_characters_between_first_character_and_cursor=1)
        assert edit(Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=1), '\r') == Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=1)
        assert edit(Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=2), '\t') == Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=2)
        
        # letters, digits, ...
        assert edit(Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=-1), 'z') == Editor(editor_text='za', editor_number_characters_between_first_character_and_cursor=0)
        assert edit(Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=0), 'b') == Editor(editor_text='ab', editor_number_characters_between_first_character_and_cursor=1)
        assert edit(Editor(editor_text='ab', editor_number_characters_between_first_character_and_cursor=1), 'c') == Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=2)
        assert edit(Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=1), '8') == Editor(editor_text='ab8c', editor_number_characters_between_first_character_and_cursor=2)
        assert edit(Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=2), 'd') == Editor(editor_text='abcd', editor_number_characters_between_first_character_and_cursor=3)
        
def test_make_editor_apply_backspace_pytest():
            # backspace '\b'
        assert make_editor_apply_backspace(Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=-1)) == Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=-1)
        assert make_editor_apply_backspace(Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=0)) == Editor(editor_text='', editor_number_characters_between_first_character_and_cursor=-1)
        assert make_editor_apply_backspace(Editor(editor_text='ab', editor_number_characters_between_first_character_and_cursor=1)) == Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=0)
        assert make_editor_apply_backspace(Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=1)) == Editor(editor_text='ac', editor_number_characters_between_first_character_and_cursor=0)
        assert make_editor_apply_backspace(Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=2)) == Editor(editor_text='ab', editor_number_characters_between_first_character_and_cursor=1)

def test_make_editor_apply_arrow_key_pytest():
            # left arrow key 'left'
        assert make_editor_apply_arrow_key(Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=-1), 'left') == Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=-1)
        assert make_editor_apply_arrow_key(Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=0), 'left') == Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=-1)
        assert make_editor_apply_arrow_key(Editor(editor_text='ab', editor_number_characters_between_first_character_and_cursor=1), 'left') == Editor(editor_text='ab', editor_number_characters_between_first_character_and_cursor=0)
        assert make_editor_apply_arrow_key(Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=1), 'left') == Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=0)
        assert make_editor_apply_arrow_key(Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=2), 'left') == Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=1)
        
        # left arrow key 'right'
        assert make_editor_apply_arrow_key(Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=-1), 'right') == Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=0)
        assert make_editor_apply_arrow_key(Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=0), 'right') == Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=0)
        assert make_editor_apply_arrow_key(Editor(editor_text='ab', editor_number_characters_between_first_character_and_cursor=1), 'right') == Editor(editor_text='ab', editor_number_characters_between_first_character_and_cursor=1)
        assert make_editor_apply_arrow_key(Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=1), 'right') == Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=2)
        assert make_editor_apply_arrow_key(Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=2), 'right') == Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=2)

def test_make_editor_apply_character_pytest():
    # letters, digits, ...
    assert make_editor_apply_character(Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=-1), 'z') == Editor(editor_text='za', editor_number_characters_between_first_character_and_cursor=0)
    assert make_editor_apply_character(Editor(editor_text='a', editor_number_characters_between_first_character_and_cursor=0), 'b') == Editor(editor_text='ab', editor_number_characters_between_first_character_and_cursor=1)
    assert make_editor_apply_character(Editor(editor_text='ab', editor_number_characters_between_first_character_and_cursor=1), 'c') == Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=2)
    assert make_editor_apply_character(Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=1), '8') == Editor(editor_text='ab8c', editor_number_characters_between_first_character_and_cursor=2)
    assert make_editor_apply_character(Editor(editor_text='abc', editor_number_characters_between_first_character_and_cursor=2), 'd') == Editor(editor_text='abcd', editor_number_characters_between_first_character_and_cursor=3)


    # after reach max number of letters, do not add letters
    ## before max
    assert make_editor_apply_character(Editor(editor_text='abcdefghijklmnopqrstuvwx', editor_number_characters_between_first_character_and_cursor=23), 'y') == Editor(editor_text='abcdefghijklmnopqrstuvwxy', editor_number_characters_between_first_character_and_cursor=24)
    ## after max
    assert make_editor_apply_character(Editor(editor_text='abcdefghijklmnopqrstuvwxy', editor_number_characters_between_first_character_and_cursor=24), 'z') == Editor(editor_text='abcdefghijklmnopqrstuvwxy', editor_number_characters_between_first_character_and_cursor=24)
