from enum import Enum

# A TrafficLight is one of the following:
# - RED
# - GREEN
# - YELLOW
# interpretation: the three symbolic constants represent the
#  three possible states that a trafflic light may assume
class TrafficLight(Enum):
    RED = "red"
    GREEN = "green"
    YELLOW = "yellow"

def case_on_traffic_light(traffic_light):
    match traffic_light:
        case TrafficLight.YELLOW:
            print('YELLOW - PREPARE TO STOP')
        case TrafficLight.RED:
            print('RED - STOP')
        case TrafficLight.GREEN:
            print('GREEN - PROCEED')


case_on_traffic_light(TrafficLight.RED)
case_on_traffic_light(TrafficLight.YELLOW)
case_on_traffic_light(TrafficLight.GREEN)

case_on_traffic_light(TrafficLight('green'))
case_on_traffic_light(TrafficLight('yellow'))
case_on_traffic_light(TrafficLight('red'))

# TrafficLight -> TrafficLight
# yields the next state given current state traffic_light_current_state
def traffic_light_next(traffic_light_current_state):
    #assert isinstance(traffic_light_current_state, TrafficLight) == True
    match traffic_light_current_state:
        case TrafficLight.RED:
            return TrafficLight.GREEN
        case TrafficLight.GREEN:
            return TrafficLight.YELLOW
        case TrafficLight.YELLOW:
            return TrafficLight.RED
        case _:
            # alternatively, could assert that traffic_light_current_state has correct type. See below
            raise Exception('We should not reach this step, because at this point we have exhausted the members of the enumeration TrafficLight.')

def traffic_light_next_with_assertion_error(traffic_light_current_state):
    assert isinstance(traffic_light_current_state, TrafficLight) == True
    match traffic_light_current_state:
        case TrafficLight.RED:
            return TrafficLight.GREEN
        case TrafficLight.GREEN:
            return TrafficLight.YELLOW
        case TrafficLight.YELLOW:
            return TrafficLight.RED

import pytest

def test_traffic_light_next():
    assert traffic_light_next(TrafficLight('red')) == TrafficLight('green')
    assert traffic_light_next(TrafficLight('green')) == TrafficLight('yellow')
    assert traffic_light_next(TrafficLight('yellow')) == TrafficLight('red')
    with pytest.raises(Exception) as info_about_exception:
        assert traffic_light_next(0) == True
        print(info_about_exception)

def test_traffic_light_next_with_assertion_error():
    with pytest.raises(AssertionError) as info_about_assertion_error:
        assert traffic_light_next_with_assertion_error(1) == False
        print(info_about_assertion_error)
