import part_one_fahrenheit_to_celsius

def convert(in_file, out_file):
    #breakpoint()
    with open(in_file) as in_file_handle:
        fahrenheit_value_from_file_as_string = in_file_handle.read()
    fahrenheit_value_from_file_as_string = fahrenheit_value_from_file_as_string.rstrip() # in case there is a newline at right
    fahrenheit_value_from_file = float(fahrenheit_value_from_file_as_string)
    celsisus_value_as_float = part_one_fahrenheit_to_celsius.celsius_from_fahrenheit(fahrenheit_value_from_file)
    celsisus_value_as_string = str(celsisus_value_as_float)
    with open(out_file, 'w') as out_file_handle:
        out_file_handle.write(celsisus_value_as_string)
    return out_file

convert('sample-py.dat', 'part_one_fahrenheit_celsisus_output-2.txt')
# I used C-c C-p and C-c C-c to run this in stepper, and the operations
#   within open() and read() and write() I did not try to comprehend.
