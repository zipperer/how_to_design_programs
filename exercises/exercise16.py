from PIL import Image
import unittest

def image_width(image):
    return image.size[0]

def image_height(image):
    return image.size[1]

def image_area(image):
    return (image_width(image) * 
            image_height(image))

class TestImageArea(unittest.TestCase):

    def test_image_area(self):
        # when I saved these images, the resulting image had an extra pixel of width and height, so 
        self.assertEqual(image_area(Image.open('racket_circle_radius_5_solid_red.png')), 121) # this is 11 * 11 rather than 10 * 10
        self.assertEqual(image_area(Image.open('racket_square_length_5_solid_blue.png')), 36) # this is 6 * 6, rather than 5 * 5
