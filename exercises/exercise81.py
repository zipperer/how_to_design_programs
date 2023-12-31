from exercise77 import PointInTimeSinceMidnight
from typing_common import Number

# Exercise 81. 
# Design the function time->seconds, which consumes instances of time structures (see exercise 77)
#  and produces the number of seconds that have passed since midnight.
# For example, if you are representing 12 hours, 30 minutes, and 2 seconds with one of these structures 
# and if you then apply time->seconds to this instance, the correct result is 45002. 


SECONDS_PER_MINUTE : int = 60
MINUTES_PER_HOUR : int = 60
SECONDS_PER_HOUR : int = MINUTES_PER_HOUR * SECONDS_PER_MINUTE

# stub/header:
#def time_to_seconds(point_in_time_since_midnight : PointInTimeSinceMidnight) -> Number:
#    '''
#    computes number of seconds since midnight
#    '''
#    return 0

# template:
#def time_to_seconds(point_in_time_since_midnight : PointInTimeSinceMidnight) -> Number:
#    '''
#    computes number of seconds since midnight
#    '''
#    return ( ...
#             point_in_time_since_midnight.hours # Number
#             ...
#             point_in_time_since_midnight.minutes # Number
#             ...
#             point_in_time_since_midnight.seconds # Number
#             ...
#            )

def time_to_seconds(point_in_time_since_midnight : PointInTimeSinceMidnight) -> Number:
   '''
   computes number of seconds since midnight
   '''
   return ((SECONDS_PER_HOUR * point_in_time_since_midnight.hours) + 
           (SECONDS_PER_MINUTE * point_in_time_since_midnight.minutes) + 
           point_in_time_since_midnight.seconds)

import pytest

example_point_in_time_since_midnight_0_seconds = PointInTimeSinceMidnight(hours=0, minutes=0, seconds=0) # represents midnight
example_point_in_time_since_midnight_30_seconds = PointInTimeSinceMidnight(hours=0, minutes=0, seconds=30) # represents midnight plus 30 seconds
example_point_in_time_since_midnight_90_seconds = PointInTimeSinceMidnight(hours=0, minutes=1, seconds=30) # represents midnight plus 1 minute and 30 seconds
example_point_in_time_since_midnight_3600_seconds = PointInTimeSinceMidnight(hours=1, minutes=0, seconds=0) # represents midnight plus one hour
example_point_in_time_since_midnight_12_hours_30_minutes_2_seconds = PointInTimeSinceMidnight(hours=12, minutes=30, seconds=2) # represents 0 seconds after midnight

def test_time_to_seconds():
    assert time_to_seconds(example_point_in_time_since_midnight_0_seconds) == 0
    assert time_to_seconds(example_point_in_time_since_midnight_30_seconds) == 30
    assert time_to_seconds(example_point_in_time_since_midnight_90_seconds) == 90
    assert time_to_seconds(example_point_in_time_since_midnight_3600_seconds) == 3600
    assert time_to_seconds(example_point_in_time_since_midnight_12_hours_30_minutes_2_seconds) == 45002
