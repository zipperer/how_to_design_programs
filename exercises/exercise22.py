from math import sqrt

def sqr(x):
    return pow(x, 2)

def distance_to_origin(x, y):
    #breakpoint()
    return sqrt(sqr(x) + sqr(y))

distance_to_origin(3, 4)

# just for fun
# alternative with operator that looks more like prefix notation from Beginning Student Language
from operator import add

def distance_to_origin_alternative_with_operator(x, y):
    return sqrt(add(sqr(x), sqr(y)))


# given file above in emacs, I 
# - typed C-c C-p to start a python interpreter
# - typed C-c C-c to send contents of file to interpreter
# - used commands from pdb command language to step through evaluation of distance_to_origin(3, 4)
#
# While I stepped through the evaluation, emacs showed a => next to the line currently executing.
#
# __PYTHON_EL_eval("from math import sqrt\n\ndef sqr(x):\n    return pow(x, 2)\n\ndef distance_to_origin(x, y):\n    breakpoint()\n    return sqrt(sqr(x) + sqr(y))\n\ndistance_to_origin(3, 4)\n\n# just for fun\n# alternative with operator that looks more like prefix notation from Beginning Student Language\nfrom operator import add\n\ndef distance_to_origin_alternative_with_operator(x, y):\n    return sqrt(add(sqr(x), sqr(y)))\n", "/Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise22.py")
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise22.py(8)distance_to_origin()
# -> return sqrt(sqr(x) + sqr(y))
# (Pdb) l
# l
#   3  	def sqr(x):
#   4  	    return pow(x, 2)
#   5  	
#   6  	def distance_to_origin(x, y):
#   7  	    breakpoint()
#   8  ->	    return sqrt(sqr(x) + sqr(y))
#   9  	
#  10  	distance_to_origin(3, 4)
#  11  	
#  12  	# just for fun
#  13  	# alternative with operator that looks more like prefix notation from Beginning Student Language
# (Pdb) p x
# p x
# 3
# (Pdb) p y
# p y
# 4
# (Pdb) display sqr(x)
# display sqr(x)
# display sqr(x): 9
# (Pdb) display sqr(y)
# display sqr(y)
# display sqr(y): 16
# (Pdb) display sqrt(sqr(x) + sqr(y))
# display sqrt(sqr(x) + sqr(y))
# display sqrt(sqr(x) + sqr(y)): 5.0
# (Pdb) s
# s
# --Call--
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise22.py(3)sqr()
# -> def sqr(x):
# (Pdb) s
# s
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise22.py(4)sqr()
# -> return pow(x, 2)
# (Pdb) s
# s
# --Return--
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise22.py(4)sqr()->9
# -> return pow(x, 2)
# (Pdb) s
# s
# --Call--
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise22.py(3)sqr()
# -> def sqr(x):
# (Pdb) s
# s
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise22.py(4)sqr()
# -> return pow(x, 2)
# (Pdb) s
# s
# --Return--
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise22.py(4)sqr()->16
# -> return pow(x, 2)
# (Pdb) s
# s
# --Return--
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise22.py(8)distance_to_origin()->5.0
# -> return sqrt(sqr(x) + sqr(y))
# (Pdb)
