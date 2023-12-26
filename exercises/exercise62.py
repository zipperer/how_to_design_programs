from enum import Enum

class DoorState(Enum):
    LOCKED = 'locked'
    CLOSED = 'closed'
    OPEN = 'open'

# 1String is the set of Strings with length 1

class KeyboardDirectionalKeys(Enum):
    LEFT_ARROW = 'left'
    RIGHT_ARROW = 'right'
    UP_ARROW = 'up'
    DOWN_ARROW = 'down'

# KeyEvent = Union[1String,KeyboardDirectionalKeys]

def door_closer(door_state : DoorState) -> DoorState:
    match door_state:
      case DoorState.LOCKED:
          return DoorState.LOCKED
      case DoorState.CLOSED:
          return DoorState.CLOSED
      case DoorState.OPEN:
          return DoorState.CLOSED
      case _:
          raise Exception('should not reach this case')

def door_action(door_state : DoorState, 
                key_event # : KeyEvent
                ) -> DoorState:
    match door_state:
        case DoorState.LOCKED:
            match key_event:
                case 'u':
                    return DoorState.CLOSED
                case _:
                    return DoorState.LOCKED
        case DoorState.CLOSED:
            match key_event:
                case 'l':
                    return DoorState.LOCKED
                case ' ':
                    return DoorState.OPEN
                case _:
                    return DoorState.CLOSED
        case _:
            return door_state

def door_render(door_state : DoorState) -> str:
    match door_state:
        case DoorState.LOCKED:
            return 'locked'
        case DoorState.CLOSED:
            return 'closed'
        case DoorState.OPEN:
            return 'open'
        case _:
            raise Exception('should not reach this case')

import pytest

def test_door_closer():
    assert door_closer(DoorState.LOCKED) == DoorState.LOCKED
    assert door_closer(DoorState.CLOSED) == DoorState.CLOSED
    assert door_closer(DoorState.OPEN) == DoorState.CLOSED

def test_door_action():
    assert door_action(DoorState.LOCKED, 'u') == DoorState.CLOSED
    assert door_action(DoorState.LOCKED, ' ') == DoorState.LOCKED
    assert door_action(DoorState.CLOSED, ' ') == DoorState.OPEN
    assert door_action(DoorState.CLOSED, 'l') == DoorState.LOCKED
    assert door_action(DoorState.CLOSED, 'a') == DoorState.CLOSED
    assert door_action(DoorState.OPEN, 'a') == DoorState.OPEN

def test_door_render():
    assert door_render(DoorState.LOCKED) == 'locked'
    assert door_render(DoorState.CLOSED) == 'closed'
    assert door_render(DoorState.OPEN) == 'open'
    with pytest.raises(Exception): #as info_about_exception:
        assert door_render('invalid value') == 'invalid value'
        #print(info_about_exception)
