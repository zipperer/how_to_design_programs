from exercise23 import substring

def string_append_binary(left_input_string, right_input_string):
    return left_input_string + right_input_string

def string_append(*args):
    return str.join('', args)

def string_insert(input_string, index_at_which_to_insert):
    breakpoint()
    return string_append(substring(input_string, 0, index_at_which_to_insert),
                         "_",
                         substring(input_string, index_at_which_to_insert))

string_insert('helloworld', 6)

# >>> 
# __PYTHON_EL_eval_file("/Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise23.py", "/var/folders/7f/wrw543qx25x272bnksy_kn_h0000gp/T/pyX171t8", True)
# >>> 
# __PYTHON_EL_eval("from exercise23 import substring\n\ndef string_append_binary(left_input_string, right_input_string):\n    return left_input_string + right_input_string\n\ndef string_append(*args):\n    return str.join('', args)\n\ndef string_insert(input_string, index_at_which_to_insert):\n    breakpoint()\n    return string_append(substring(input_string, 0, index_at_which_to_insert),\n                         \"_\",\n                         substring(input_string, index_at_which_to_insert))\n\nstring_insert('helloworld', 6)\n", "/Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise26.py")
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise26.py(11)string_insert()
# -> return string_append(substring(input_string, 0, index_at_which_to_insert),
# (Pdb) s input_string
# s input_string
# --Call--
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise23.py(20)substring()
# -> def substring(input_string, start_index, end_index_exclusive=None):
# (Pdb) args
# args
# input_string = 'helloworld'
# start_index = 0
# end_index_exclusive = 6
# (Pdb) s
# s
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise23.py(21)substring()
# -> if (end_index_exclusive and substring_index_valid(input_string, end_index_exclusive)):
# (Pdb) s
# s
# --Call--
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise23.py(13)substring_index_valid()
# -> def substring_index_valid(input_string, one_string_index):
# (Pdb) s
# s
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise23.py(14)substring_index_valid()
# -> if ((one_string_index >= 0) and
# (Pdb) s
# s
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise23.py(15)substring_index_valid()
# -> (one_string_index <= len(input_string))):
# (Pdb) s
# s
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise23.py(16)substring_index_valid()
# -> return True
# (Pdb) s
# s
# --Return--
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise23.py(16)substring_index_valid()->True
# -> return True
# (Pdb) s
# s
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise23.py(22)substring()
# -> return input_string[start_index:end_index_exclusive]
# (Pdb) s
# s
# --Return--
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise23.py(22)substring()->'hellow'
# -> return input_string[start_index:end_index_exclusive]
# (Pdb) s
# s
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise26.py(12)string_insert()
# -> "_",
# (Pdb) s
# s
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise26.py(13)string_insert()
# -> substring(input_string, index_at_which_to_insert))
# (Pdb) s
# s
# --Call--
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise23.py(20)substring()
# -> def substring(input_string, start_index, end_index_exclusive=None):
# (Pdb) s
# s
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise23.py(21)substring()
# -> if (end_index_exclusive and substring_index_valid(input_string, end_index_exclusive)):
# (Pdb) s
# s
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise23.py(24)substring()
# -> return input_string[start_index:]
# (Pdb) s
# s
# --Return--
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise23.py(24)substring()->'orld'
# -> return input_string[start_index:]
# (Pdb) args
# args
# input_string = 'helloworld'
# start_index = 6
# end_index_exclusive = None
# (Pdb) s
# s
# --Call--
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise26.py(6)string_append()
# -> def string_append(*args):
# (Pdb) s
# s
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise26.py(7)string_append()
# -> return str.join('', args)
# (Pdb) s
# s
# --Return--
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise26.py(7)string_append()->'hellow_orld'
# -> return str.join('', args)
# (Pdb) s
# s
# --Return--
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise26.py(13)string_insert()->'hellow_orld'
# -> substring(input_string, index_at_which_to_insert))
# (Pdb) s
# s
# --Return--
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise26.py(15)<module>()->'hellow_orld'
# -> string_insert('helloworld', 6)
# (Pdb) s
# s
# --Return--
# > <string>(19)__PYTHON_EL_eval()->'hellow_orld'
# (Pdb) 
