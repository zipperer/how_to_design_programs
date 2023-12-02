# Options for stepper

# - https://docs.python.org/3/library/pdb.html -- breakpoint(), `step`, and p <variable>
# -- https://pymotw.com/3/pdb/
# -- https://github.com/spiside/pdb-tutorial
# -- https://docs.python.org/3/library/debug.html

# - in IntelliJ IDEA, click left margin of code line, click bug, and 'step into' or 'step over'
# -- https://www.jetbrains.com/help/pycharm/stepping-through-the-program.html#step-into

# https://pythontutor.com/

# https://thonny.org/

def ff (a):
    return 10 * a

ff(1 + 1)
ff(ff(1))
print(ff(1) + ff(1))

# example using pdb
# ayer:exercises $ python3 -m pdb exercise21.py
# python3 -m pdb exercise21.py
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise21.py(15)<module>()
# -> def ff (a):
# (Pdb) s
# s
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise21.py(18)<module>()
# -> ff(1 + 1)
# (Pdb) l
# l
#  13  	# https://thonny.org/
#  14  	
#  15  	def ff (a):
#  16  	    return 10 * a
#  17  	
#  18  ->	ff(1 + 1)
#  19  	ff(ff(1))
# [EOF]
# (Pdb) s
# s
# --Call--
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise21.py(15)ff()
# -> def ff (a):
# (Pdb) l
# l
#  10  	
#  11  	# https://pythontutor.com/
#  12  	
#  13  	# https://thonny.org/
#  14  	
#  15  ->	def ff (a):
#  16  	    return 10 * a
#  17  	
#  18  	ff(1 + 1)
#  19  	ff(ff(1))
# [EOF]
# (Pdb) s
# s
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise21.py(16)ff()
# -> return 10 * a
# (Pdb) l
# l
#  11  	# https://pythontutor.com/
#  12  	
#  13  	# https://thonny.org/
#  14  	
#  15  	def ff (a):
#  16  ->	    return 10 * a
#  17  	
#  18  	ff(1 + 1)
#  19  	ff(ff(1))
# [EOF]
# (Pdb) p a
# p a
# 2
# (Pdb) args
# args
# a = 2
# (Pdb) s
# s
# --Return--
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise21.py(16)ff()->20
# -> return 10 * a
# (Pdb) l
# l
#  11  	# https://pythontutor.com/
#  12  	
#  13  	# https://thonny.org/
#  14  	
#  15  	def ff (a):
#  16  ->	    return 10 * a
#  17  	
#  18  	ff(1 + 1)
#  19  	ff(ff(1))
# [EOF]
# (Pdb) args
# args
# a = 2
# (Pdb) s
# s
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise21.py(19)<module>()
# -> ff(ff(1))
# (Pdb) l
# l
#  14  	
#  15  	def ff (a):
#  16  	    return 10 * a
#  17  	
#  18  	ff(1 + 1)
#  19  ->	ff(ff(1))
# [EOF]
# (Pdb) s
# s
# --Call--
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise21.py(15)ff()
# -> def ff (a):
# (Pdb) ll
# ll
#  15  ->	def ff (a):
#  16  	    return 10 * a
# (Pdb) s
# s
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise21.py(16)ff()
# -> return 10 * a
# (Pdb) args
# args
# a = 1
# (Pdb) s
# s
# --Return--
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise21.py(16)ff()->10
# -> return 10 * a
# (Pdb) s
# s
# --Call--
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise21.py(15)ff()
# -> def ff (a):
# (Pdb) l
# l
#  10  	
#  11  	# https://pythontutor.com/
#  12  	
#  13  	# https://thonny.org/
#  14  	
#  15  ->	def ff (a):
#  16  	    return 10 * a
#  17  	
#  18  	ff(1 + 1)
#  19  	ff(ff(1))
# [EOF]
# (Pdb) args
# args
# a = 10
# (Pdb) s
# s
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise21.py(16)ff()
# -> return 10 * a
# (Pdb) s
# s
# --Return--
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise21.py(16)ff()->100
# -> return 10 * a
# (Pdb) args
# args
# a = 10
# (Pdb) s
# s
# --Return--
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise21.py(19)<module>()->None
# -> ff(ff(1))
# (Pdb) ll
# ll
#   1  	# Options for stepper
#   2  	
#   3  	# - https://docs.python.org/3/library/pdb.html -- breakpoint(), `step`, and p <variable>
#   4  	# -- https://pymotw.com/3/pdb/
#   5  	# -- https://github.com/spiside/pdb-tutorial
#   6  	# -- https://docs.python.org/3/library/debug.html
#   7  	
#   8  	# - in IntelliJ IDEA, click left margin of code line, click bug, and 'step into' or 'step over'
#   9  	# -- https://www.jetbrains.com/help/pycharm/stepping-through-the-program.html#step-into
#  10  	
#  11  	# https://pythontutor.com/
#  12  	
#  13  	# https://thonny.org/
#  14  	
#  15  	def ff (a):
#  16  	    return 10 * a
#  17  	
#  18  	ff(1 + 1)
#  19  ->	ff(ff(1))
# (Pdb) s
# s
# --Return--
# > <string>(1)<module>()->None
# (Pdb) s
# s
# > /Library/Frameworks/Python.framework/Versions/3.7/lib/python3.7/bdb.py(582)run()
# -> self.quitting = True
# (Pdb) q
# q
# Traceback (most recent call last):
#   File "/Library/Frameworks/Python.framework/Versions/3.7/lib/python3.7/pdb.py", line 1699, in main
#     pdb._runscript(mainpyfile)
#   File "/Library/Frameworks/Python.framework/Versions/3.7/lib/python3.7/pdb.py", line 1568, in _runscript
#     self.run(statement)
#   File "/Library/Frameworks/Python.framework/Versions/3.7/lib/python3.7/bdb.py", line 582, in run
#     self.quitting = True
#   File "/Library/Frameworks/Python.framework/Versions/3.7/lib/python3.7/bdb.py", line 582, in run
#     self.quitting = True
#   File "/Library/Frameworks/Python.framework/Versions/3.7/lib/python3.7/bdb.py", line 88, in trace_dispatch
#     return self.dispatch_line(frame)
#   File "/Library/Frameworks/Python.framework/Versions/3.7/lib/python3.7/bdb.py", line 113, in dispatch_line
#     if self.quitting: raise BdbQuit
# bdb.BdbQuit
# Uncaught exception. Entering post mortem debugging
# Running 'cont' or 'step' will restart the program
# > /Library/Frameworks/Python.framework/Versions/3.7/lib/python3.7/bdb.py(113)dispatch_line()
# -> if self.quitting: raise BdbQuit
# (Pdb) q
# q
# Post mortem debugger finished. The exercise21.py will be restarted
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise21.py(15)<module>()
# -> def ff (a):
# (Pdb) q
# q


# ayer:exercises $ python3 -m pdb exercise21.py
# python3 -m pdb exercise21.py
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise21.py(15)<module>()
# -> def ff (a):
# (Pdb) n
# n
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise21.py(18)<module>()
# -> ff(1 + 1)
# (Pdb) n
# n
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise21.py(19)<module>()
# -> ff(ff(1))
# (Pdb) n
# n
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise21.py(20)<module>()
# -> print(ff(1) + ff(1))
# (Pdb) s
# s
# --Call--
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise21.py(15)ff()
# -> def ff (a):
# (Pdb) s
# s
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise21.py(16)ff()
# -> return 10 * a
# (Pdb) s
# s
# --Return--
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise21.py(16)ff()->10
# -> return 10 * a
# (Pdb) s
# s
# --Call--
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise21.py(15)ff()
# -> def ff (a):
# (Pdb) s
# s
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise21.py(16)ff()
# -> return 10 * a
# (Pdb) s
# s
# --Return--
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise21.py(16)ff()->10
# -> return 10 * a
# (Pdb) s
# s
# 20
# --Return--
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise21.py(20)<module>()->None
# -> print(ff(1) + ff(1))
# (Pdb) args
# args
# (Pdb) s
# s
# --Return--
# > <string>(1)<module>()->None
# (Pdb) s
# s
# > /Library/Frameworks/Python.framework/Versions/3.7/lib/python3.7/bdb.py(582)run()
# -> self.quitting = True
# (Pdb) q
# q
# Traceback (most recent call last):
#   File "/Library/Frameworks/Python.framework/Versions/3.7/lib/python3.7/pdb.py", line 1699, in main
#     pdb._runscript(mainpyfile)
#   File "/Library/Frameworks/Python.framework/Versions/3.7/lib/python3.7/pdb.py", line 1568, in _runscript
#     self.run(statement)
#   File "/Library/Frameworks/Python.framework/Versions/3.7/lib/python3.7/bdb.py", line 582, in run
#     self.quitting = True
#   File "/Library/Frameworks/Python.framework/Versions/3.7/lib/python3.7/bdb.py", line 582, in run
#     self.quitting = True
#   File "/Library/Frameworks/Python.framework/Versions/3.7/lib/python3.7/bdb.py", line 88, in trace_dispatch
#     return self.dispatch_line(frame)
#   File "/Library/Frameworks/Python.framework/Versions/3.7/lib/python3.7/bdb.py", line 113, in dispatch_line
#     if self.quitting: raise BdbQuit
# bdb.BdbQuit
# Uncaught exception. Entering post mortem debugging
# Running 'cont' or 'step' will restart the program
# > /Library/Frameworks/Python.framework/Versions/3.7/lib/python3.7/bdb.py(113)dispatch_line()
# -> if self.quitting: raise BdbQuit
# (Pdb) q
# q
# Post mortem debugger finished. The exercise21.py will be restarted
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise21.py(15)<module>()
# -> def ff (a):
# (Pdb) q
# q
# ayer:exercises $ 
