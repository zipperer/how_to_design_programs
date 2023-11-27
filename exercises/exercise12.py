import unittest

def cube_volume(cube_length_side):
    ''' computes volume of equilateral cube given length of side of cube '''
    length = cube_length_side
    width = cube_length_side
    height = cube_length_side
    volume = length * width * height
    return volume

def cube_surface(cube_length_side):
    ''' computes total surface area of an equilateral cube given length of side of cube'''
    number_of_sides = 6
    area_of_each_side = pow(cube_length_side, 2)
    total_surface_area = number_of_sides * area_of_each_side
    return total_surface_area

class TestCubeVolume(unittest.TestCase):

    def test_cube_volume(self):
        self.assertEqual(cube_volume(1), 1)
        self.assertEqual(cube_volume(2), 8)


class TestCubeSurface(unittest.TestCase):

    def test_cube_surface(self):
        self.assertEqual(cube_surface(1), 6)
        self.assertEqual(cube_surface(2), 24)
