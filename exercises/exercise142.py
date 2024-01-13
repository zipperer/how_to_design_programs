from PIL import Image
from python_image_methods import image_width, image_height
#from typing import Union, Literal, List

# Exercise 142
# Design the ill-sized? function, which consumes a list of images loi and a positive number n. 
# It produces the first image on loi that is not an n by n square; if it cannot find such an image, it produces #false.

# Hint: Use
# ImageOrFalse is one of:
# – Image
# – #false 
# for the result part of the signature.

#ImageOrFalse = Union[Image, Literal[False]]

#def ill_sized(list_of_images : List[Image]) -> ImageOrFalse:
#    return False

def ill_sized(list_of_images, # List[Image]
              side_length, # Number
              ): # -> ImageOrFalse
    match list_of_images:
        case []:
            return False
        case [first_image, *rest_of_images]:
            if (not (image_is_square_with_side_length first_image side_length)):
                return first_image
            else:
                return ill_sized(rest_of_images, side_length)

def image_is_square_with_side_length(image, # : Image
                                     side_length # : Number
                                     ) -> bool:
    
    return ((image_width(image) == side_length) and
            (image_height(image) == side_length))
