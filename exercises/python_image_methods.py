def image_width(image):
    return image.size[0]

def image_height(image):
    return image.size[1]

def image_area(image):
    return (image_width(image) * 
            image_height(image))

def image_classify_as_tall_or_wide_or_square(image):
    width = image_width(image)
    height = image_height(image)
    if height > width:
        return 'tall'
    elif width > height:
        return 'wide'
    else:
        return 'square'
