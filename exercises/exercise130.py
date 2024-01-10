# Exercise 130
# Create an element of List-of-names that contains five Strings.

# A List-of-names is one of:
# – list()
# - cons(String, List-of-names)
# interpretation:
#   a list of invitees, by last name


from python_list_utilities import cons

LIST_OF_FIVE_NAMES = cons('Felleisen',
                          cons('Findler',
                               cons('Krishnamurthi',
                                    cons('Flatt',
                                         cons('Zipperer', list())))))

import pytest

def test_constant():
    assert LIST_OF_FIVE_NAMES == ['Felleisen', 'Findler', 'Krishnamurthi', 'Flatt', 'Zipperer']

# Explain why
#   cons("1", cons("2", list()))
# is an element of List-of-names and why 
#   cons(2, list())
# isn’t. 

# claim: cons("1", cons("2", list())) is an element of List-of-names.
# argument:
# a. list() is an element of List-of-names by the first clause in the itemization.
# b. "2" is a String and list() is an element of List-of-names by (a), so
#    cons("2", list()) matches the pattern cons(String, List-of-names), so
#    cons("2", list()) is an element of List-of-names by the second clause in
#    the itemization.
# c. "1" is a String and cons("2", list()) is a List-of-names by (b), so
#    cons("1", cons("2", list())) matches the pattern cons(String, List-of-names), so
#    cons("1", cons("2", list())) is an element of List-of-names by the second
#    clause in the itemization.


# claim: cons(2, list()) is not an element of List-of-names.
# argument:
# a. list() is an element of List-of-names by the first clause of the itemization.
# b. cons(2, list()) does not match the first clause of the itemization b/c
#    cons(2, list()) != list()
# c. cons(2, list() does not match the second clause of the itemization b/c
#    2 is not in String.
# d. So, cons(2, list() fails to match any clause in the itemization, so
#    cons(2, list() is not an element in List-of-names.
