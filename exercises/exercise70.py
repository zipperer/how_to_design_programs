# Exercise 70
# Spell out the laws for these structure type definitions:

# (define-struct phone [area number])

# ; laws of computation for phone
# ; (phone-area (make-phone a0 n0)) == a0
# ; (phone-number (make-phone a0 n0)) == n0

class PhoneNumber:

    def __init__(self,
                 area: int,
                 number: str
                 ) -> None:
        self.area = area
        self.number = number

# laws of computation for PhoneNumber:
# PhoneNumber(area=a0, number=n0).area == a0
# PhoneNumber(area=a0, number=n0).number = n0

# (define-struct centry [name home office cell])

# ; laws of computation for centry:
# ; (centry-name (make-centry n0 h0 o0 c0)) == n0
# ; (centry-home (make-centry n0 h0 o0 c0)) == h0
# ; (centry-office (make-centry n0 h0 o0 c0)) == o0
# ; (centry-office (make-centry n0 h0 o0 c0)) == c0

class ContactEntry:

    def __init__(self,
                 name: str,
                 home: PhoneNumber,
                 office: PhoneNumber,
                 cell: PhoneNumber
                 ) -> None:

        self.name = name
        self.home = home
        self.office = office
        self.cell = cell

# laws of computation for ContactEntry:
# ContactEntry(name=n0, home=h0, office=o0, cell=c0).name == n0
# ContactEntry(name=n0, home=h0, office=o0, cell=c0).home == h0
# ContactEntry(name=n0, home=h0, office=o0, cell=c0).office == o0
# ContactEntry(name=n0, home=h0, office=o0, cell=c0).cell == c0

# ; Use DrRacket’s stepper to confirm 101 as the value of this expression:
# (phone-area
#  (centry-office
#   (make-centry "Shriram Fisler"
#     (make-phone 207 "363-2421")
#     (make-phone 101 "776-1099")
#     (make-phone 208 "112-9981"))))

import pytest

def test_contact_entry_and_phone_number_laws_of_computation():
    #breakpoint()
    assert ContactEntry(name='Shriram Fisler',
                        home=PhoneNumber(area=207, number='363-2421'),
                        office=PhoneNumber(area=101, number='776-1099'),
                        cell=PhoneNumber(area=208, number='112-9981')).office.area == 101
    # alternatively:
    contact_entry = ContactEntry(name='Shriram Fisler',
                                 home=PhoneNumber(area=207, number='363-2421'),
                                 office=PhoneNumber(area=101, number='776-1099'),
                                 cell=PhoneNumber(area=208, number='112-9981'))
    assert contact_entry.office.area == 101
