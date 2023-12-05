def implies(x, y):
    breakpoint()
    return ((not x) or y)

implies(True, False)

# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise24.py(3)implies()
# -> return ((not x) or y)
# (Pdb) p x
# p x
# True
# (Pdb) p y
# p y
# False
# (Pdb) s
# s
# --Return--
# > /Users/andrew/documents/learn-python/how_to_design_programs/exercises/exercise24.py(3)implies()->False
# -> return ((not x) or y)
# (Pdb) p (not x)
# p (not x)
# False
# (Pdb) q
# q
