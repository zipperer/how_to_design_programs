class PhoneNumber:

    def __init__(self,
                 area : int,
                 number : str) -> None:
        self.area = area
        self.number = number

class ContactEntry:

    def __init__(self, 
                 name : str, 
                 home : PhoneNumber,
                 office : PhoneNumber,
                 cell : PhoneNumber) -> None:
        self.name = name
        self.home = home
        self.office = office
        self.cell = cell


EXAMPLE_CONTACT_ENTRY = ContactEntry(name='Shriram Fisler',
                                     home=PhoneNumber(area=207, number='363-2421'),
                                     office=PhoneNumber(area=101, number='776-1099'),
                                     cell=PhoneNumber(area=208, number='112-9981'))

import pytest

def test_example_contact_entry():
    assert isinstance(EXAMPLE_CONTACT_ENTRY, ContactEntry) == True
    assert isinstance(EXAMPLE_CONTACT_ENTRY, PhoneNumber) == False
    assert isinstance(EXAMPLE_CONTACT_ENTRY.home, PhoneNumber) == True
    assert isinstance(EXAMPLE_CONTACT_ENTRY.home, ContactEntry) == False
    assert EXAMPLE_CONTACT_ENTRY.home.area == 207
    assert EXAMPLE_CONTACT_ENTRY.home.number == '363-2421'

