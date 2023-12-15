from enum import Enum

class MouseEvent(Enum):
    BUTTON_DOWN = 'button-down'
    BUTTON_UP = 'button-up'
    DRAG = 'drag'
    MOVE = 'move'
    ENTER = 'enter'
    LEAVE = 'leave'

def announce_mouse_event(mouse_event):
    match mouse_event:
        case MouseEvent.BUTTON_DOWN:
            print(MouseEvent.BUTTON_DOWN)
        case MouseEvent.BUTTON_UP:
            print(MouseEvent.BUTTON_UP)
        case MouseEvent.DRAG:
            print(MouseEvent.DRAG)
        case MouseEvent.MOVE:
            print(MouseEvent.MOVE)
        case MouseEvent.ENTER:
            print(MouseEvent.ENTER)
        case MouseEvent.LEAVE:
            print(MouseEvent.LEAVE)
        case _:
            print('should not reach this case')


announce_mouse_event(MouseEvent.BUTTON_DOWN)
announce_mouse_event(MouseEvent.BUTTON_UP)
announce_mouse_event(MouseEvent.DRAG)
announce_mouse_event(MouseEvent.MOVE)
announce_mouse_event(MouseEvent.ENTER)
announce_mouse_event(MouseEvent.LEAVE)

announce_mouse_event(MouseEvent('button-down'))
announce_mouse_event(MouseEvent('button-up'))
announce_mouse_event(MouseEvent('drag'))
announce_mouse_event(MouseEvent('move'))
announce_mouse_event(MouseEvent('enter'))
announce_mouse_event(MouseEvent('leave'))
