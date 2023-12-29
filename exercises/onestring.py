class OneString:

    def __init__(self, string_of_length_1 : str) -> None:
        self.enforce_type_and_length(string_of_length_1)
        self.string_of_length_1 = string_of_length_1

    @staticmethod
    def enforce_type_and_length(string_of_length_1 : str) -> None:
        assert type(string_of_length_1) == str
        assert len(string_of_length_1) == 1

class OneStringLowercase(OneString):

    def __init__(self, string_of_length_1_lowercase : str) -> None:
        self.enforce_type_and_length(string_of_length_1_lowercase)
        self.enforce_lowercase(string_of_length_1_lowercase)
        self.string_of_length_1_lowercase = string_of_length_1_lowercase

    @staticmethod
    def enforce_lowercase(string_of_length_1_lowercase : str) -> None:
        assert string_of_length_1_lowercase ==  string_of_length_1_lowercase.lower()


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
