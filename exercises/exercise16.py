import unittest
import python_image_methods
from PIL import Image

class TestImageArea(unittest.TestCase):

    def test_image_area(self):
        # when I saved these images, the resulting image had an extra pixel of width and height, so 
        with Image.open('images/racket_circle_radius_5_solid_red.png') as circle:
            self.assertEqual(python_image_methods.image_area(circle), 121) # this is 11 * 11 rather than 10 * 10
        with Image.open('images/racket_square_length_5_solid_blue.png') as square:
            self.assertEqual(python_image_methods.image_area(square), 36) # this is 6 * 6, rather than 5 * 5
