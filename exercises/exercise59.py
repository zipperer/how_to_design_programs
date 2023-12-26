from enum import Enum

class TrafficLight(Enum):
    RED = 'red'
    GREEN = 'green'
    YELLOW = 'yellow'

def traffic_light_next(current_traffic_light : TrafficLight) -> TrafficLight:
    match current_traffic_light:
        case TrafficLight.RED:
            return TrafficLight.GREEN
        case TrafficLight.GREEN:
            return TrafficLight.YELLOW
        case TrafficLight.YELLOW:
            return TrafficLight.RED
        case _:
            raise Exception('should not reach this case')

def traffic_light_next_ifelif(current_traffic_light : TrafficLight) -> TrafficLight:
    if current_traffic_light == TrafficLight.RED:
        return TrafficLight.GREEN
    elif current_traffic_light == TrafficLight.GREEN:
        return TrafficLight.YELLOW
    elif current_traffic_light == TrafficLight.YELLOW:
        return TrafficLight.RED
    else:
        raise Exception('should not reach this case')


import pytest

def test_traffic_light_next():
    assert traffic_light_next(TrafficLight.RED) == TrafficLight.GREEN
    assert traffic_light_next(TrafficLight.GREEN) == TrafficLight.YELLOW
    assert traffic_light_next(TrafficLight.YELLOW) == TrafficLight.RED

    assert traffic_light_next(TrafficLight('red')) == TrafficLight.GREEN
    assert traffic_light_next(TrafficLight('green')) == TrafficLight.YELLOW
    assert traffic_light_next(TrafficLight('yellow')) == TrafficLight.RED

def test_traffic_light_next_ifelif():
    assert traffic_light_next_ifelif(TrafficLight.RED) == TrafficLight.GREEN
    assert traffic_light_next_ifelif(TrafficLight.GREEN) == TrafficLight.YELLOW
    assert traffic_light_next_ifelif(TrafficLight.YELLOW) == TrafficLight.RED

    assert traffic_light_next_ifelif(TrafficLight('red')) == TrafficLight.GREEN
    assert traffic_light_next_ifelif(TrafficLight('green')) == TrafficLight.YELLOW
    assert traffic_light_next_ifelif(TrafficLight('yellow')) == TrafficLight.RED
