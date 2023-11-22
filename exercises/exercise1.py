import math
import unittest

class Point:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def distance_to_origin(self):
        return math.sqrt(pow(self.x, 2) + pow(self.y, 2))

    
class TestDistanceToOrigin(unittest.TestCase):

    def test_distance_to_origin(self):
        point_x_3_y_4 = Point(x=3, y=4)
        self.assertEqual(point_x_3_y_4.distance_to_origin(), 5)

        point_x_12_y_5 = Point(x=12, y=5)
        self.assertEqual(point_x_12_y_5.distance_to_origin(), 13)

# how_to_design_programs $ python3 -m unittest -v exercises/exercise1.py        
