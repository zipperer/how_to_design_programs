String = str

#from enum import Enum
#class KeyEvent(Enum):
#    a = 'a'
#    ...

# def string_first(string_possibly_empty : String) -> OneString:
#     length_string_possibly_empty = len(string_possibly_empty)
#     if length_string_possibly_empty == 0:
#         return OneString('')
#     else:
#         return OneString(string_possibly_empty[0])

def string_first(string_possibly_empty : String) -> String:
     length_string_possibly_empty = len(string_possibly_empty)
     if length_string_possibly_empty == 0:
         return ''
     else:
         return string_possibly_empty[0]

def string_last(string_possibly_empty: String) -> String:
    length_string_possibly_empty = len(string_possibly_empty)
    if length_string_possibly_empty == 0:
        return ''
    else:
        return string_possibly_empty[-1] # equivalently string_possibly_empty[length_string_possibly_empty - 1]

def string_rest(string_possibly_empty: String) -> String:
    length_string_possibly_empty = len(string_possibly_empty)
    if length_string_possibly_empty == 0:
        return ''
    else:
        return string_possibly_empty[1:]

def string_remove_last(string_possibly_empty: String) -> String:
    length_string_possibly_empty = len(string_possibly_empty)
    if length_string_possibly_empty <= 1:
        return ''
    else:
        return string_possibly_empty[0:-1] # alternatively: string_possibly_empty[:-1] or string_possibly_empty[0:len(string_possibly_empty) - 1]

def string_append(*args):
    return str.join('', args)

from dataclasses import dataclass

@dataclass
class Editor:
    '''
    An Editor is a structure:
       Editor(editor_pre : String, editor_post : String)
    interpretation:
       Editor(editor_pre=pre0, editor_post=post0) represents an editor with
       - text before cursor pre0
       - text after cursor post0
       - cursor between editor_pre and editor_post
    See examples below.
    '''
    editor_pre: String
    editor_post: String

example_editor_empty_before_cursor_empty_after_cursor = Editor(editor_pre='', 
                                                               editor_post='')
example_editor_characters_before_cursor_empty_after_cursor = Editor(editor_pre='text before cursor',
                                                                    editor_post='')
example_editor_empty_before_cursor_characters_after_cursor = Editor(editor_pre='',
                                                                    editor_post='text after cursor')
example_editor_characters_before_cursor_characters_after_cursor = Editor(editor_pre='text before cursor',
                                                                         editor_post='text after cursor')

EDIT_KEYSTROKES_TO_IGNORE = {'\r', 
                             '\t'}

EDIT_LEFT_OR_RIGHT = {'left',
                      'right'}

def edit(editor : Editor,
         key_event : String # KeyEvent
         ) -> Editor:
    if key_event == '\b':
        return make_editor_apply_backspace(editor)
    elif key_event in EDIT_KEYSTROKES_TO_IGNORE:
        return editor
    elif key_event in EDIT_LEFT_OR_RIGHT:
        return make_editor_apply_direction_key_left_right(editor, key_event)
    elif len(key_event) == 1:
        return make_editor_insert_character_to_left_of_cursor(editor, key_event)
    else:
        return editor

def make_editor_apply_backspace(editor : Editor) -> Editor:
    return Editor(editor_pre=string_remove_last(editor.editor_pre),
                  editor_post=editor.editor_post)

def make_editor_apply_direction_key_left_right(editor : Editor,
                                               key_event : String # KeyEvent
                                               ) -> Editor:
    if key_event == 'left':
        return Editor(editor_pre=string_remove_last(editor.editor_pre),
                      editor_post=(string_append(string_last(editor.editor_pre), editor.editor_post)))
    else: # i.e. key_event == 'right'
        return Editor(editor_pre=string_append(editor.editor_pre, string_first(editor.editor_post)),
                      editor_post=string_rest(editor.editor_post))

def make_editor_insert_character_to_left_of_cursor(editor : Editor, 
                                                   key_event : String # KeyEvent
                                                   ) -> Editor:
    return Editor(editor_pre=string_append(editor.editor_pre, key_event),
                  editor_post=editor.editor_post)

import pytest

def test_string_first():
    assert string_first('apple') == 'a'
    assert string_first('bakery') == 'b'
    assert string_first('') == ''

def test_string_last():
    assert string_last('apple') == 'e'
    assert string_last('bakery') == 'y'
    assert string_last('') == ''

def test_string_rest():
    assert string_rest('apple') == 'pple'
    assert string_rest('bakery') == 'akery'
    assert string_rest('') == ''

def test_string_remove_last():
    assert string_remove_last('apple') == 'appl'
    assert string_remove_last('bakery') == 'baker'
    assert string_remove_last('') == ''

def test_string_append():
    assert string_append() == ''
    assert string_append('a') == 'a'
    assert string_append('a', 'b') == 'ab'
    assert string_append('a', 'b', 'c') == 'abc'

def test_make_editor_apply_backspace():
    new_editor_blank = Editor(editor_pre='', editor_post='')
    assert make_editor_apply_backspace(new_editor_blank) == Editor(editor_pre='', editor_post='')

    new_editor_with_a_in_editor_pre = Editor(editor_pre='a', editor_post='')
    assert make_editor_apply_backspace(new_editor_with_a_in_editor_pre) == Editor(editor_pre='', editor_post='')

    new_editor_with_ab_in_editor_pre = Editor(editor_pre='ab', editor_post='')
    assert make_editor_apply_backspace(new_editor_with_ab_in_editor_pre) == Editor(editor_pre='a', editor_post='')

    new_editor_with_ab_in_editor_pre_and_cd_in_editor_post = Editor(editor_pre='ab', editor_post='cd')
    assert make_editor_apply_backspace(new_editor_with_ab_in_editor_pre_and_cd_in_editor_post) == Editor(editor_pre='a', editor_post='cd')

def test_make_editor_apply_direction_key_left_right():
    new_editor_blank = Editor(editor_pre='', editor_post='')
    assert make_editor_apply_direction_key_left_right(new_editor_blank, 'left') == Editor(editor_pre='', editor_post='')
    assert make_editor_apply_direction_key_left_right(new_editor_blank, 'right') == Editor(editor_pre='', editor_post='')

    new_editor_with_a_in_editor_pre = Editor(editor_pre='a', editor_post='')
    assert make_editor_apply_direction_key_left_right(new_editor_with_a_in_editor_pre, 'left') == Editor(editor_pre='', editor_post='a')
    assert make_editor_apply_direction_key_left_right(new_editor_with_a_in_editor_pre, 'right') == Editor(editor_pre='a', editor_post='')

    new_editor_with_ab_in_editor_pre = Editor(editor_pre='ab', editor_post='')
    assert make_editor_apply_direction_key_left_right(new_editor_with_ab_in_editor_pre, 'left') == Editor(editor_pre='a', editor_post='b')
    assert make_editor_apply_direction_key_left_right(new_editor_with_ab_in_editor_pre, 'right') == Editor(editor_pre='ab', editor_post='')

    new_editor_with_ab_in_editor_pre_and_cd_in_editor_post = Editor(editor_pre='ab', editor_post='cd')
    assert make_editor_apply_direction_key_left_right(new_editor_with_ab_in_editor_pre_and_cd_in_editor_post, 'left') == Editor(editor_pre='a', editor_post='bcd')
    assert make_editor_apply_direction_key_left_right(new_editor_with_ab_in_editor_pre_and_cd_in_editor_post, 'right') == Editor(editor_pre='abc', editor_post='d')

def test_make_editor_insert_character_to_left_of_cursor():
    new_editor_blank = Editor(editor_pre='', editor_post='')
    assert make_editor_insert_character_to_left_of_cursor(new_editor_blank, 'a') == Editor(editor_pre='a', editor_post='')

    new_editor_with_a_in_editor_pre = Editor(editor_pre='a', editor_post='')
    assert make_editor_insert_character_to_left_of_cursor(new_editor_with_a_in_editor_pre, 'b') == Editor(editor_pre='ab', editor_post='')

    new_editor_with_ab_in_editor_pre = Editor(editor_pre='ab', editor_post='')
    assert make_editor_insert_character_to_left_of_cursor(new_editor_with_ab_in_editor_pre, 'c') == Editor(editor_pre='abc', editor_post='')

    new_editor_with_ab_in_editor_pre_and_cd_in_editor_post = Editor(editor_pre='ab', editor_post='cd')
    assert make_editor_insert_character_to_left_of_cursor(new_editor_with_ab_in_editor_pre_and_cd_in_editor_post, 'e') == Editor(editor_pre='abe', editor_post='cd')

    new_editor_with_empty_editor_pre_and_cd_in_editor_post = Editor(editor_pre='', editor_post='cd')
    assert make_editor_insert_character_to_left_of_cursor(new_editor_with_empty_editor_pre_and_cd_in_editor_post, 'e') == Editor(editor_pre='e', editor_post='cd')


# Exercise 86
# Notice that if you type a lot, your editor program does not display all of the text. 
# Instead the text is cut off at the right margin. 
# Modify your function `edit` from exercise 84 so that it ignores a keystroke if adding it
# to the end of the pre field would mean the rendered text is too wide for your canvas.

def edit_with_limit_on_width(editor : Editor,
                             key_event : String # KeyEvent
                             ) -> Editor:
    if key_event == '\b':
        return make_editor_apply_backspace(editor)
    elif key_event in EDIT_KEYSTROKES_TO_IGNORE:
        return editor
    elif key_event in EDIT_LEFT_OR_RIGHT:
        return make_editor_apply_direction_key_left_right(editor, key_event)
    elif len(key_event) == 1:
        return make_editor_insert_character_to_left_of_cursor_with_limit_on_width(editor, key_event)
    else:
        return editor

TEXT_BOX_CHARACTER_MAX : int = 25 
# in Racket/BSL I used images and image-width.                               
# Since I do not yet use images here, I impose a limit with number of characters.
def text_exceeds_width_of_text_box(text_to_render : String) -> bool:
    return (len(text_to_render) > TEXT_BOX_CHARACTER_MAX)

def make_editor_insert_character_to_left_of_cursor_with_limit_on_width(editor : Editor, 
                                                                       key_event : String # KeyEvent
                                                                       ) -> Editor:
    if text_exceeds_width_of_text_box(string_append(editor.editor_pre, key_event, editor.editor_post)):
        return editor
    else:
        return Editor(editor_pre=string_append(editor.editor_pre, key_event),
                      editor_post=editor.editor_post)

def test_make_editor_insert_character_to_left_of_cursor_with_limit_on_width():
    assert make_editor_insert_character_to_left_of_cursor_with_limit_on_width(Editor(editor_pre='a',
                                                                                     editor_post=''),
                                                                              'b') == Editor(editor_pre='ab',
                                                                                             editor_post='')
    assert make_editor_insert_character_to_left_of_cursor_with_limit_on_width(Editor(editor_pre='ab',
                                                                                     editor_post=''),
                                                                              'c') == Editor(editor_pre='abc',
                                                                                             editor_post='')
    assert make_editor_insert_character_to_left_of_cursor_with_limit_on_width(Editor(editor_pre='abcdefghijklmnopqrstuvwx',
                                                                                     editor_post=''),
                                                                              'y') == Editor(editor_pre='abcdefghijklmnopqrstuvwxy',
                                                                                             editor_post='')
    assert make_editor_insert_character_to_left_of_cursor_with_limit_on_width(Editor(editor_pre='abcdefghijklmnopqrstuvwxy',
                                                                                     editor_post=''),
                                                                              'z') == Editor(editor_pre='abcdefghijklmnopqrstuvwxy',
                                                                                             editor_post='')

    assert make_editor_insert_character_to_left_of_cursor_with_limit_on_width(Editor(editor_pre='abcdefghi',
                                                                                     editor_post='klmnopqrstuvwxy'),
                                                                              'j') == Editor(editor_pre='abcdefghij',
                                                                                             editor_post='klmnopqrstuvwxy')
    assert make_editor_insert_character_to_left_of_cursor_with_limit_on_width(Editor(editor_pre='abcdefghi',
                                                                                     editor_post='klmnopqrstuvwxyz'),
                                                                              'j') == Editor(editor_pre='abcdefghi',
                                                                                             editor_post='klmnopqrstuvwxyz')
    

def test_text_exceeds_width_of_text_box():
    assert text_exceeds_width_of_text_box('a') == False
    assert text_exceeds_width_of_text_box('ab') == False
    assert text_exceeds_width_of_text_box('abcdefghijklmnopqrstuvwxy') == False
    assert text_exceeds_width_of_text_box('abcdefghijklmnopqrstuvwxyz') == True

# Instead of making a new function make_editor_insert_character_with_line_limit to replace
# make_editor_insert_character, I could have added a new parameter IMPOSE_LIMIT_ON_LINE_WIDTH to
# make_editor_insert_character. When IMPOSE_LIMIT_ON_LINE_WIDTH, then in cond clause
# for len(key_event) == 1, pass IMPOSE_LIMIT_ON_LINE_WIDTH through to
# make_editor_move_cursor_direction. New parameter IMPOSE_LIMIT_ON_LINE_WIDTH for 
# make_editor_move_cursor_direction controls whether to check text_exceeds_width_of_background.
    
# TO CONSIDER FOR FUTURE: use GUI library or graphics library to make world programs with python
