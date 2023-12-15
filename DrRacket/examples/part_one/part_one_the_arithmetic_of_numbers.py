import math

class Point:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def distance_to_origin(self):
        return math.sqrt(pow(self.x, 2) + pow(self.y, 2))

    
