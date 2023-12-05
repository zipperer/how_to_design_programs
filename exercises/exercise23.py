evaluate_top_level_forms = False

def string_first(input_string):
    #breakpoint()
    return input_string[0:1]

if evaluate_top_level_forms:
    string_first("hello world")

# just for fun
# alternative that looks more like Beginning Student Language example

def substring_index_valid(input_string, one_string_index):
    if ((one_string_index >= 0) and
        (one_string_index <= len(input_string))):
        return True
    else:
        return False

def substring(input_string, start_index, end_index_exclusive=None):
    if (end_index_exclusive and substring_index_valid(input_string, end_index_exclusive)):
        return input_string[start_index:end_index_exclusive]
    else:
        return input_string[start_index:]

def string_first_using_substring(input_string):
    breakpoint()
    return substring(input_string, 0, 1)

if evaluate_top_level_forms:
    string_first_using_substring("hello world")

# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise23.py(25)string_first_using_substring()
# -> return substring(input_string, 0, 1)
# (Pdb) l
# l
#  20  	    else:
#  21  	        return input_string[start_index:]
#  22  	
#  23  	def string_first_using_substring(input_string):
#  24  	    breakpoint()
#  25  ->	    return substring(input_string, 0, 1)
#  26  	
#  27  	string_first_using_substring("hello world")
# [EOF]
# (Pdb) p input_string
# p input_string
# 'hello world'
# (Pdb) s
# s
# --Call--
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise23.py(17)substring()
# -> def substring(input_string, start_index, end_index_exclusive=None):
# (Pdb) p input_string
# p input_string
# 'hello world'
# (Pdb) p start_index
# p start_index
# 0
# (Pdb) p end_index_exclusive
# p end_index_exclusive
# 1
# (Pdb) s
# s
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise23.py(18)substring()
# -> if (end_index_exclusive and substring_index_valid(input_string, end_index_exclusive)):
# (Pdb) s
# s
# --Call--
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise23.py(10)substring_index_valid()
# -> def substring_index_valid(input_string, one_string_index):
# (Pdb) s
# s
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise23.py(11)substring_index_valid()
# -> if ((one_string_index >= 0) and
# (Pdb) p one_string_index
# p one_string_index
# 1
# (Pdb) s
# s
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise23.py(12)substring_index_valid()
# -> (one_string_index <= len(input_string))):
# (Pdb) s
# s
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise23.py(13)substring_index_valid()
# -> return True
# (Pdb) s
# s
# --Return--
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise23.py(13)substring_index_valid()->True
# -> return True
# (Pdb) s
# s
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise23.py(19)substring()
# -> return input_string[start_index:end_index_exclusive]
# (Pdb) s
# s
# --Return--
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise23.py(19)substring()->'h'
# -> return input_string[start_index:end_index_exclusive]
# (Pdb) s
# s
# --Return--
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise23.py(25)string_first_using_substring()->'h'
# -> return substring(input_string, 0, 1)
# (Pdb) s
# s
# --Return--
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise23.py(27)<module>()->'h'
# -> string_first_using_substring("hello world")
# (Pdb) q
# q
