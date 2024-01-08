# Exercise 108
# In its default state, a pedestrian crossing light shows an orange person standing, on a black background. 
# When it is time to allow the pedestrian to cross the street, the light receives a signal and switches to 
# a green, walking person. This phase lasts for 10 seconds. 
# After that the light displays the digits 9, 8, ..., 0 with odd numbers colored orange and even numbers colored green. 
# When the countdown reaches 0, the light switches back to its default state.

# Design a world program that implements such a pedestrian traffic light. 
# The light switches from its default state when you press the space bar on your keyboard. 
# All other transitions must be reactions to clock ticks.

from typing import Union, Literal, Any
from dataclasses import dataclass

# A PedestrianLightWorldState is one of:
# - "standing"
# - WalkingStateWithCountdown
# - [0, 9]

def enforce_integer(value : Any) -> None:
    assert type(value) == int

def enforce_value_between_0_and_9_inclusive_inclusive(value : Any) -> None:
    assert value >= 0
    assert value <= 9

class Integer0To9:

    def __init__(self,
                 value : int
                 ) -> None:
        enforce_integer(value)
        enforce_value_between_0_and_9_inclusive_inclusive(value)
        self.value = value

    def __eq__(self, other : Any) -> bool:
        return (isinstance(other, Integer0To9) and
                self.value == other.value)

@dataclass
class WalkingStateWithCountdown:
    seconds_remaining: Integer0To9


PedestrianLightWorldState = Union[Literal["standing"],
                                  WalkingStateWithCountdown,
                                  Integer0To9]

def handle_key(pedestrian_light_world_state : PedestrianLightWorldState,
               key_event : str # KeyEvent
               ) -> PedestrianLightWorldState:
    match key_event:
        case " ":
            match pedestrian_light_world_state:
                case "standing":
                    return WalkingStateWithCountdown(seconds_remaining=Integer0To9(9))
                case _:
                    return pedestrian_light_world_state
        case _:
            return pedestrian_light_world_state

def handle_tick(pedestrian_light_world_state : PedestrianLightWorldState) -> PedestrianLightWorldState:
    match pedestrian_light_world_state:
        case WalkingStateWithCountdown(seconds_remaining=Integer0To9(value=n)):
            if n > 0:
                return WalkingStateWithCountdown(seconds_remaining=Integer0To9(value=n - 1))
            else:
                return Integer0To9(value=9)
        case Integer0To9(value=n):
            if n > 0:
                return Integer0To9(value=(n - 1))
            else:
                return "standing"
        case _:
            return pedestrian_light_world_state
    return pedestrian_light_world_state

import pytest

def test_handle_key():
    assert handle_key("standing", " ") == WalkingStateWithCountdown(seconds_remaining=Integer0To9(value=9))
    assert handle_key("standing", "a") == "standing"
    assert handle_key(WalkingStateWithCountdown(seconds_remaining=Integer0To9(value=9)), " ") == WalkingStateWithCountdown(seconds_remaining=Integer0To9(value=9))
    assert handle_key(WalkingStateWithCountdown(seconds_remaining=Integer0To9(value=9)), "a") == WalkingStateWithCountdown(seconds_remaining=Integer0To9(value=9))
    assert handle_key(Integer0To9(value=9), " ") == Integer0To9(value=9)
    assert handle_key(Integer0To9(value=9), "a") == Integer0To9(value=9)
    

def test_handle_tick():
    assert handle_tick("standing") == "standing"
    assert handle_tick(WalkingStateWithCountdown(seconds_remaining=Integer0To9(value=9))) == WalkingStateWithCountdown(seconds_remaining=Integer0To9(value=8))
    assert handle_tick(WalkingStateWithCountdown(seconds_remaining=Integer0To9(value=1))) == WalkingStateWithCountdown(seconds_remaining=Integer0To9(value=0))
    assert handle_tick(WalkingStateWithCountdown(seconds_remaining=Integer0To9(value=0))) == Integer0To9(value=9)
    assert handle_tick(Integer0To9(value=9)) == Integer0To9(value=8)
    assert handle_tick(Integer0To9(value=1)) == Integer0To9(value=0)
    assert handle_tick(Integer0To9(value=0)) == "standing"
