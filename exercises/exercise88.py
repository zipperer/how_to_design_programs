from dataclasses import dataclass
from typing_common import Number
from typing import Literal, Union
import pytest
#from sys import exit

# assert update_cat_x_coordinate_due_to_time(VirtualCatGame(cat_x_coordinate=0, 
#                                                           cat_happiness=100, 
#                                                           cat_direction='right')) == VirtualCatGame(cat_x_coordinate=(0 + CAT_SPEED),
#                                                                                                     cat_happiness=(100 - CAT_HAPPINESS_CHANGE_PER_CLOCK_TICK),
#                                                                                                     cat_direction='right')
Direction = Union[Literal['left'],Literal['right']]
String = str

@dataclass
class VirtualCatGame:
    '''
    A VirtualCatGame is a structure.
      VirtualCatGame(cat_x_coordinate, cat_happiness, cat_direction)
    interpretation:
      VirtualCatGame(cat_x_coordinate=x0, cat_happiness=h0, cat_direction=d0)
      represents a cat at position x0, with happiness h0, walking in direction d0.
    h0 is in the interval [0, 100]
    d0 is a Direction (i.e. either 'left' or 'right')

    Aside to self: in BSL/Racket, define-struct and data definition are separate.
    So far in Python I have combined the `class` and data definition, e.g.
     - I put the data definition in the comment of the class
     - I put the types on the fields of the class (rather than specifying types in the
         (make-...) schema in the data definition
    This is consequential if: in BSL/Racket we reuse the same define-struct for two
    different data definitions.
    '''
    cat_x_coordinate : Number
    cat_happiness : Number
    cat_direction : Direction

# Example instances of VirtualCatGame
example_cat_game_position_0_happiness_100_direction_right = VirtualCatGame(cat_x_coordinate=0,
                                                                           cat_happiness=100,
                                                                           cat_direction='right')
example_cat_game_position_10_happiness_50_direction_left = VirtualCatGame(cat_x_coordinate=10,
                                                                           cat_happiness=50,
                                                                           cat_direction='left')
example_cat_game_position_30_happiness_0_direction_left = VirtualCatGame(cat_x_coordinate=10,
                                                                           cat_happiness=0,
                                                                           cat_direction='left')

CANVAS_WIDTH = 100
CAT_SPEED = 10
CAT_INITIAL_HAPPINESS = 100
CAT_HAPPINESS_CHANGE_PER_CLOCK_TICK = .1
CAT_HAPPINESS_CHANGE_WITH_UP_ARROW = 1
CAT_HAPPINESS_CHANGE_WITH_DOWN_ARROW = 2
CAT_MINIMAL_HAPPINESS = 0

# on_tick helper
def update_cat_x_coordinate_due_to_time(vcg : VirtualCatGame) -> Number:
    match vcg.cat_direction:
        case 'left':
            potential_new_position = vcg.cat_x_coordinate - CAT_SPEED
            if potential_new_position >= 0:
                return potential_new_position
            else:
                return 0
        case _: # case 'right'
            potential_new_position = vcg.cat_x_coordinate + CAT_SPEED
            if potential_new_position <= CANVAS_WIDTH:
                return potential_new_position
            else:
                return CANVAS_WIDTH

def test_update_cat_x_coordinate_due_to_time():
    assert update_cat_x_coordinate_due_to_time(VirtualCatGame(cat_x_coordinate=0, 
                                                              cat_happiness=100, 
                                                              cat_direction='right')) == 0 + CAT_SPEED
    assert update_cat_x_coordinate_due_to_time(VirtualCatGame(cat_x_coordinate=20, 
                                                              cat_happiness=100, 
                                                              cat_direction='right')) == 20 + CAT_SPEED
    assert update_cat_x_coordinate_due_to_time(VirtualCatGame(cat_x_coordinate=CANVAS_WIDTH, 
                                                              cat_happiness=100, 
                                                              cat_direction='left')) == CANVAS_WIDTH - CAT_SPEED
    # how to make sure VirtualCatGame(cat_x_coordinate=CANVAS_WIDTH, cat_happiness=100, cat_direction='right') never occurs?
    # i.e. how to make sure never have direction 'right' and position CANVAS_WIDTH? Don't return it from a function that
    # makes a VirtualCatGame
    assert update_cat_x_coordinate_due_to_time(VirtualCatGame(cat_x_coordinate=(CANVAS_WIDTH - (CAT_SPEED / 2)), 
                                                              cat_happiness=100, 
                                                              cat_direction='right')) == CANVAS_WIDTH
    assert update_cat_x_coordinate_due_to_time(VirtualCatGame(cat_x_coordinate=(0 + (CAT_SPEED / 2)),
                                                              cat_happiness=100, 
                                                              cat_direction='left')) == 0

# on_tick helper
def update_cat_happiness_due_to_time(vcg : VirtualCatGame) -> Number:
    cat_happiness_updated = vcg.cat_happiness - CAT_HAPPINESS_CHANGE_PER_CLOCK_TICK
    if cat_happiness_updated > 0:
        return cat_happiness_updated
    else:
        exit()

def test_update_cat_happiness_due_to_time():
     assert update_cat_happiness_due_to_time(VirtualCatGame(cat_x_coordinate=0, 
                                                               cat_happiness=100, 
                                                               cat_direction='right')) == 100 - CAT_HAPPINESS_CHANGE_PER_CLOCK_TICK
     assert update_cat_happiness_due_to_time(VirtualCatGame(cat_x_coordinate=0, 
                                                               cat_happiness=10, 
                                                               cat_direction='right')) == 10 - CAT_HAPPINESS_CHANGE_PER_CLOCK_TICK

# on_tick helper
def update_cat_direction_due_to_location_and_direction(vcg : VirtualCatGame) -> Direction:
    match vcg.cat_direction:
        case 'right' if vcg.cat_x_coordinate >= CANVAS_WIDTH:
            return 'left'
        case 'left' if vcg.cat_x_coordinate <= 0:
            return 'right'
        case _:
            return vcg.cat_direction

# since update_cat_x_coordinate_due_to_time updates the x_coordinate,
# that function has the info (i.e. whether x_coordinate in extremal value)
# to determine whether to change direction. Could use that function to return
# both an updated cat_x_coordinate and cat_direction. 

def test_update_cat_direction_due_to_location_and_direction():
    assert update_cat_direction_due_to_location_and_direction(VirtualCatGame(cat_x_coordinate=0,
                                                                             cat_happiness=100, 
                                                                             cat_direction='left')) == 'right'
    assert update_cat_direction_due_to_location_and_direction(VirtualCatGame(cat_x_coordinate=CANVAS_WIDTH, 
                                                                             cat_happiness=10, 
                                                                             cat_direction='right')) == 'left'
# on_tick
def update_virtual_cat_game_due_to_time(vcg : VirtualCatGame) -> VirtualCatGame:
    return VirtualCatGame(cat_x_coordinate=update_cat_x_coordinate_due_to_time(vcg),
                          cat_happiness=update_cat_happiness_due_to_time(vcg),
                          cat_direction=update_cat_direction_due_to_location_and_direction(vcg))


def test_update_virtual_cat_game_due_to_time():
    assert update_virtual_cat_game_due_to_time(VirtualCatGame(cat_x_coordinate=0, 
                                                              cat_happiness=100, 
                                                              cat_direction='right')) == VirtualCatGame(cat_x_coordinate=(0 + CAT_SPEED),
                                                                                                        cat_happiness=(100 - CAT_HAPPINESS_CHANGE_PER_CLOCK_TICK), 
                                                                                                        cat_direction='right')
    assert update_virtual_cat_game_due_to_time(VirtualCatGame(cat_x_coordinate=20, 
                                                              cat_happiness=100, 
                                                              cat_direction='right')) == VirtualCatGame(cat_x_coordinate=(20 + CAT_SPEED), 
                                                                                                        cat_happiness=(100 - CAT_HAPPINESS_CHANGE_PER_CLOCK_TICK), 
                                                                                                        cat_direction='right')
    assert update_virtual_cat_game_due_to_time(VirtualCatGame(cat_x_coordinate=CANVAS_WIDTH, 
                                                              cat_happiness=100, 
                                                              cat_direction='left')) == VirtualCatGame(cat_x_coordinate=(CANVAS_WIDTH - CAT_SPEED), 
                                                                                                       cat_happiness=(100 - CAT_HAPPINESS_CHANGE_PER_CLOCK_TICK),
                                                                                                       cat_direction='left')
    # how to make sure VirtualCatGame(cat_x_coordinate=CANVAS_WIDTH, cat_happiness=100, cat_direction='right') never occurs?
    # i.e. how to make sure never have direction 'right' and position CANVAS_WIDTH? Don't return it from a function that
    # makes a VirtualCatGame
    assert update_virtual_cat_game_due_to_time(VirtualCatGame(cat_x_coordinate=(CANVAS_WIDTH - (CAT_SPEED / 2)), 
                                                              cat_happiness=100, 
                                                              cat_direction='right')) == VirtualCatGame(cat_x_coordinate=CANVAS_WIDTH, 
                                                                                                        cat_happiness=(100 - CAT_HAPPINESS_CHANGE_PER_CLOCK_TICK),
                                                                                                        cat_direction='right')
    assert update_virtual_cat_game_due_to_time(VirtualCatGame(cat_x_coordinate=(0 + (CAT_SPEED / 2)),
                                                              cat_happiness=100, 
                                                              cat_direction='left')) == VirtualCatGame(cat_x_coordinate=0,
                                                                                                       cat_happiness=(100 - CAT_HAPPINESS_CHANGE_PER_CLOCK_TICK), 
                                                                                                       cat_direction='left')

    assert update_virtual_cat_game_due_to_time(VirtualCatGame(cat_x_coordinate=0, 
                                                           cat_happiness=100, 
                                                           cat_direction='right')) == VirtualCatGame(cat_x_coordinate=(0 + CAT_SPEED), 
                                                                                                     cat_happiness=(100 - CAT_HAPPINESS_CHANGE_PER_CLOCK_TICK),
                                                                                                     cat_direction='right')
    assert update_virtual_cat_game_due_to_time(VirtualCatGame(cat_x_coordinate=0, 
                                                           cat_happiness=10, 
                                                           cat_direction='right')) == VirtualCatGame(cat_x_coordinate=(0 + CAT_SPEED), 
                                                                                                     cat_happiness=(10 - CAT_HAPPINESS_CHANGE_PER_CLOCK_TICK),
                                                                                                     cat_direction='right')

    # this example and next show that on one tick at extremal position, direction changes but position does not
    assert update_virtual_cat_game_due_to_time(VirtualCatGame(cat_x_coordinate=0,
                                                              cat_happiness=100, 
                                                              cat_direction='left')) == VirtualCatGame(cat_x_coordinate=0,
                                                                                                       cat_happiness=(100 - CAT_HAPPINESS_CHANGE_PER_CLOCK_TICK),
                                                                                                       cat_direction='right')
    assert update_virtual_cat_game_due_to_time(VirtualCatGame(cat_x_coordinate=CANVAS_WIDTH, 
                                                              cat_happiness=10, 
                                                              cat_direction='right')) == VirtualCatGame(cat_x_coordinate=CANVAS_WIDTH, 
                                                                                                        cat_happiness=(10 - CAT_HAPPINESS_CHANGE_PER_CLOCK_TICK), 
                                                                                                        cat_direction='left')


# on_key helper
def make_virtual_cat_game_update_happiness_given_arrow_key(vcg : VirtualCatGame, 
                                                           key_event : String # KeyEvent -- 'up' or 'down'
                                                           ) -> VirtualCatGame:
    match key_event:
        case 'up':
            # could make new_happiness some factor (e.g. 5/4) of vcg.cat_happiness like exercise47.rkt.
            # here we just increase by a number
            cat_happiness_updated = vcg.cat_happiness + CAT_HAPPINESS_CHANGE_WITH_UP_ARROW
        case _: # case 'down'
            cat_happiness_updated = vcg.cat_happiness - CAT_HAPPINESS_CHANGE_WITH_DOWN_ARROW
    return VirtualCatGame(cat_x_coordinate=vcg.cat_x_coordinate,
                          cat_happiness=cat_happiness_updated,
                          cat_direction=vcg.cat_direction)


# on_key
def update_virtual_cat_game_due_to_key_event(vcg : VirtualCatGame,
                                             key_event : String # KeyEvent
                                             ) -> VirtualCatGame:
    match key_event:
        case 'up' | 'down':
            return make_virtual_cat_game_update_happiness_given_arrow_key(vcg, key_event)
        case _:
            return vcg

def test_make_virtual_cat_game_update_happiness_given_arrow_key():
    assert update_virtual_cat_game_due_to_key_event(VirtualCatGame(cat_x_coordinate=CANVAS_WIDTH, 
                                                                cat_happiness=10, 
                                                                   cat_direction='right'),
                                                    'up') == VirtualCatGame(cat_x_coordinate=CANVAS_WIDTH, 
                                                                            cat_happiness=(10 + CAT_HAPPINESS_CHANGE_WITH_UP_ARROW),
                                                                            cat_direction='right')
    assert update_virtual_cat_game_due_to_key_event(VirtualCatGame(cat_x_coordinate=CANVAS_WIDTH, 
                                                                   cat_happiness=10, 
                                                                   cat_direction='right'),
                                                    'down') == VirtualCatGame(cat_x_coordinate=CANVAS_WIDTH, 
                                                                              cat_happiness=(10 - CAT_HAPPINESS_CHANGE_WITH_DOWN_ARROW),
                                                                              cat_direction='right')
    assert update_virtual_cat_game_due_to_key_event(VirtualCatGame(cat_x_coordinate=CANVAS_WIDTH, 
                                                                   cat_happiness=10, 
                                                                   cat_direction='right'),
                                                    'a') == VirtualCatGame(cat_x_coordinate=CANVAS_WIDTH, 
                                                                           cat_happiness=10,
                                                                           cat_direction='right')        
