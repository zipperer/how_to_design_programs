import unittest
from PIL import Image
import python_image_methods

class TestImageClassify(unittest.TestCase):

    def test_image_classify_as_tall_or_wide_or_square(self):
        with Image.open('images/racket_circle_radius_5_solid_red.png') as circle:
            self.assertEqual(python_image_methods.image_classify_as_tall_or_wide_or_square(circle), 'square')
        with Image.open('images/racket_square_length_5_solid_blue.png') as square:
            self.assertEqual(python_image_methods.image_classify_as_tall_or_wide_or_square(circle), 'square')
        with Image.open('images/racket_rectangle_width_5_height_10_solid_gray.png') as rectangle_tall:
            self.assertEqual(python_image_methods.image_classify_as_tall_or_wide_or_square(rectangle_tall), 'tall')
        with Image.open('images/racket_rectangle_width_10_height_5_solid_gray.png') as rectangle_wide:
            self.assertEqual(python_image_methods.image_classify_as_tall_or_wide_or_square(rectangle_wide), 'wide')
