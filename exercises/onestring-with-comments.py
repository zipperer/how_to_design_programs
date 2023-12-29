#OneString = str # how to enforce that each instance of OneString is a string with length 1?

# https://stackoverflow.com/questions/65521239/how-to-type-annotate-length-of-string
# ^ responders say that it cannot be done as a compile time check.
# One reponder recommends a check like the asserts in methods below
class OneString:

#    def enforce_type_and_length(self, string_of_length_1 : str) -> None:
#        assert type(string_of_length_1) == str # duplicates compile-time check via (a) type annotations and mypy with (b) run-time check
#        assert len(string_of_length_1) == 1

    # https://stackoverflow.com/questions/12179271/meaning-of-classmethod-and-staticmethod-for-beginner
    # ^ @staticmethod rather than adding self as first parameter i.e. enforce_type_and_length(self, string_of_length_1 : str) -> None

    @staticmethod
    def enforce_type_and_length(string_of_length_1 : str) -> None:
        assert type(string_of_length_1) == str # duplicates compile-time check via (a) type annotations and mypy with (b) run-time check
        assert len(string_of_length_1) == 1

    def __init__(self, string_of_length_1 : str) -> None:
        #self.enforce_type_and_length(string_of_length_1)
        self.enforce_type_and_length(string_of_length_1)
        # OneString.enforce_type_and_length(string_of_length_1) # can use self instead of OneString -- resulting code is 'DRYer' since don't repeat the name of class
        self.string_of_length_1 = string_of_length_1

class OneStringLowercase(OneString):

#    def enforce_lowercase(self, string_of_length_1_lowercase : str) -> None:
#        assert string_of_length_1_lowercase ==  string_of_length_1_lowercase.lower()

    @staticmethod
    def enforce_lowercase(string_of_length_1_lowercase : str) -> None:
        assert string_of_length_1_lowercase ==  string_of_length_1_lowercase.lower()

    def __init__(self, string_of_length_1_lowercase : str) -> None:
        #super().__init__(string_of_length_1_lowercase)
        #super().enforce_type_and_length(string_of_length_1_lowercase)
        OneString.enforce_type_and_length(string_of_length_1_lowercase)
        #self.enforce_type_and_length(string_of_length_1_lowercase) # AZ: don't need to use super since did not override enforce_type_and_length in child class. could use super if did override. 
        #super().__init__(string_of_length_1_lowercase) # alternatively could use super if using __init__ since parent class' init is overridden.
        self.enforce_lowercase(string_of_length_1_lowercase)
        # OneStringLowercase.enforce_lowercase(string_of_length_1_lowercase) # can use self instead of OneStringLowercase -- resulting code is 'DRYer' since don't repeat the name of class
        self.string_of_length_1_lowercase = string_of_length_1_lowercase


import pytest

def test_onestring_make_instances():
    assert isinstance(OneString('a'), OneString) == True
    assert isinstance(OneString('b'), OneString) == True
    with pytest.raises(AssertionError):
        assert isinstance(OneString(1), OneString) == True # exception due to 1 is not string
    with pytest.raises(AssertionError):
        assert isinstance(OneString('ab'), OneString) == True # exception due to 'ab' length 2 not length 1

def test_onestringlowercase_make_instances():
    assert isinstance(OneStringLowercase('a'), OneStringLowercase) == True
    assert isinstance(OneStringLowercase('b'), OneStringLowercase) == True
    with pytest.raises(AssertionError):
        assert isinstance(OneStringLowercase(1), OneStringLowercase) == True # exception due to 1 is not string
    with pytest.raises(AssertionError):
        assert isinstance(OneStringLowercase('ab'), OneStringLowercase) == True # exception due to 'ab' length 2 not length 1
    with pytest.raises(AssertionError):        
        assert isinstance(OneStringLowercase('A'), OneStringLowercase) == True # exception due to 'A'.lower() != 'A'
