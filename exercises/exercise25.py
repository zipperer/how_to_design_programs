import python_image_methods
from PIL import Image

def image_classify_as_tall_or_wide_or_square_incorrect(image):
    breakpoint()
    width = python_image_methods.image_width(image)
    height = python_image_methods.image_height(image)
    if height >= width:
        return 'tall'
    elif height == width:
        return 'square'
    elif height < width:
        return 'wide'

with Image.open('images/racket_rectangle_width_10_height_10_solid_red.png') as image_of_rectangle_with_equal_width_and_height_so_a_square:
    image_classify_as_tall_or_wide_or_square_incorrect(image_of_rectangle_with_equal_width_and_height_so_a_square)
    # stepping through evaluation shows image height and width satisfy condition
    #   height >= width
    # where author expects height and width for input image satisfy condition height == width and no other conditions


# __PYTHON_EL_eval("import python_image_methods\nfrom PIL import Image\n\ndef image_classify_as_tall_or_wide_or_square_incorrect(image):\n    breakpoint()\n    width = python_image_methods.image_width(image)\n    height = python_image_methods.image_height(image)\n    if height >= width:\n        return 'tall'\n    elif height == width:\n        return 'square'\n    elif height < width:\n        return 'wide'\n\nwith Image.open('images/racket_rectangle_width_10_height_10_solid_red.png') as image_of_rectangle_with_equal_width_and_height_so_a_square:\n    image_classify_as_tall_or_wide_or_square_incorrect(image_of_rectangle_with_equal_width_and_height_so_a_square)\n", "/Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise25.py")
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise25.py(6)image_classify_as_tall_or_wide_or_square_incorrect()
# -> width = python_image_methods.image_width(image)
# (Pdb) p image
# p image
# <PIL.PngImagePlugin.PngImageFile image mode=RGBA size=11x11 at 0x7FA0A301B6D0>
# (Pdb) s
# s
# --Call--
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/python_image_methods.py(1)image_width()
# -> def image_width(image):
# (Pdb) s
# s
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/python_image_methods.py(2)image_width()
# -> return image.size[0]
# (Pdb) s
# s
# --Call--
# > /Library/Frameworks/Python.framework/Versions/3.7/lib/python3.7/site-packages/PIL/Image.py(529)size()
# -> @property
# (Pdb) s
# s
# > /Library/Frameworks/Python.framework/Versions/3.7/lib/python3.7/site-packages/PIL/Image.py(531)size()
# -> return self._size
# (Pdb) s
# s
# --Return--
# > /Library/Frameworks/Python.framework/Versions/3.7/lib/python3.7/site-packages/PIL/Image.py(531)size()->(11, 11)
# -> return self._size
# (Pdb) s
# s
# --Return--
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/python_image_methods.py(2)image_width()->11
# -> return image.size[0]
# (Pdb) s
# s
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise25.py(7)image_classify_as_tall_or_wide_or_square_incorrect()
# -> height = python_image_methods.image_height(image)
# (Pdb) s
# s
# --Call--
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/python_image_methods.py(4)image_height()
# -> def image_height(image):
# (Pdb) s
# s
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/python_image_methods.py(5)image_height()
# -> return image.size[1]
# (Pdb) s
# s
# --Call--
# > /Library/Frameworks/Python.framework/Versions/3.7/lib/python3.7/site-packages/PIL/Image.py(529)size()
# -> @property
# (Pdb) s
# s
# > /Library/Frameworks/Python.framework/Versions/3.7/lib/python3.7/site-packages/PIL/Image.py(531)size()
# -> return self._size
# (Pdb) s
# s
# --Return--
# > /Library/Frameworks/Python.framework/Versions/3.7/lib/python3.7/site-packages/PIL/Image.py(531)size()->(11, 11)
# -> return self._size
# (Pdb) s
# s
# --Return--
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/python_image_methods.py(5)image_height()->11
# -> return image.size[1]
# (Pdb) s
# s
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise25.py(8)image_classify_as_tall_or_wide_or_square_incorrect()
# -> if height >= width:
# (Pdb) p height
# p height
# 11
# (Pdb) p width
# p width
# 11
# (Pdb) s
# s
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise25.py(9)image_classify_as_tall_or_wide_or_square_incorrect()
# -> return 'tall'
# (Pdb) s
# s
# --Return--
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise25.py(9)image_classify_as_tall_or_wide_or_square_incorrect()->'tall'
# -> return 'tall'
# (Pdb) 
