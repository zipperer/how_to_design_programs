with open('sample-py.dat', 'w') as file_to_write:
    file_to_write.write('212')

# ayer:examples $ python
# Python 3.8.2 (default, Jun  8 2020, 11:14:09) 
# [Clang 10.0.0 (clang-1000.10.44.4)] on darwin
# Type "help", "copyright", "credits" or "license" for more information.
# >>> with open('sample-py.dat', 'r') as file_to_read:
# ...     contents_of_file = file_to_read.read()
# ...     print(contents_of_file)
# ... 
# 212
