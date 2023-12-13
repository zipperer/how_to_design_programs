# Exercise 36. Design the function image-area, which counts the number of pixels in a given image.

# data definitions
# signature, purpose statement, header
# functional examples
# take inventory, make template
# fill-in template
# write functional examples as tests and run them

# We represent:
# - an image as a PIL.Image
# - an area as a number

# PIL.Image -> number
# from given image, return count of pixels in image
# def image_area (image):
#   return 10
# given: circle with radius 5 on rectangular field with .5 pixel border around circle -> (2 * (5 + .5))^2 == 11^2 == 121
# given: rectangle with width 10 and height 5, with a borded of .5 pixels on each side -> (10 + (2 * .5)) * (5 + (2 * .5)) == 11 * 6 == 66
# def image_area (image):
#   return ... image ...

def image_area (image):
    width, height = image.size
    area = width * height
    return area

from PIL import Image
import unittest

class TestImageArea(unittest.TestCase):

    def test_image_area(self):
        with Image.open('images/racket_circle_radius_5_solid_red.png') as image_of_circle_with_radius_5_with_half_pixel_border:
            self.assertEqual(image_area(image_of_circle_with_radius_5_with_half_pixel_border), 121)

        with Image.open('images/racket_rectangle_width_10_height_5_solid_gray.png') as image_of_rectangle_with_width_10_and_height_5_with_half_pixel_border:
            self.assertEqual(image_area(image_of_rectangle_with_width_10_and_height_5_with_half_pixel_border), 66)

import pytest

def test_image_area_pytest():
    with Image.open('images/racket_circle_radius_5_solid_red.png') as image_of_circle_with_radius_5_with_half_pixel_border:
        assert image_area(image_of_circle_with_radius_5_with_half_pixel_border) == 121

    with Image.open('images/racket_rectangle_width_10_height_5_solid_gray.png') as image_of_rectangle_with_width_10_and_height_5_with_half_pixel_border:
        assert image_area(image_of_rectangle_with_width_10_and_height_5_with_half_pixel_border) == 66
