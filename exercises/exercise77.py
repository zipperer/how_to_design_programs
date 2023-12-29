#Exercise 77
# Provide a structure type definition and a data definition
# for representing points in time since midnight.
# A point in time consists of three numbers: hours, minutes, and seconds.

from dataclasses import dataclass
from typing_common import Number

@dataclass
class PointInTimeSinceMidnight:
    '''
    interpretation:
      PointInTimeSinceMidnight(hours=h, minutes=m, seconds=s) is a point in time since midnight;
      in particular, it is the point in time h hours m minutes and s seconds since midnight.
    For example,
      PointInTimeSinceMidnight(hours=5, minutes=0, seconds=0) is 5 AM.
      PointInTimeSinceMidnight(hours=23, minutes=59, seconds=59) is one second before the next midnight.
    Since h is hours, m is minutes, and s is seconds,
      hours is in [0, 23]
      minutes is in [0, 59]
      seconds is in [0, 59]
    '''
    hours : Number
    minutes : Number
    seconds : Number
