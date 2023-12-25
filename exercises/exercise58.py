# Sample Problem 
# The state of Tax Land has created a three-stage sales tax 
# to cope with its budget deficit. Inexpensive items, those costing less 
# than $1,000, are not taxed. Luxury items, with a price of more than $10,000, 
# are taxed at the rate of eight percent (8.00%). Everything in between comes
# with a five percent (5.00%) markup.

# Design a function for a cash register that, given the price of an item, computes the sales tax.

# Exercise 58. Introduce constant definitions that separate the intervals for low 
# prices and luxury prices from the others so that the legislators in Tax Land can 
# easily raise the taxes even more.

# data definitions
# signature, purpose statement, header
# functional examples
# function template
# fill in template
# write functional examples as tests and run them

# data definitions
# A Price is a Number in one of these three intervals:
# - [0, 1000) -- call it 'inexpensive'
# - [1000, 10000) -- call it 'expensive'
# - [10000, POSITIVE_INFINITY) -- call it 'luxury'

# A Tax is a Number

# signature, purpose statement, header
# Price -> Tax
# given the price of an item, computes the sales tax for the item
# def sales_tax(price : Number) -> Number:
#   return 0

from typing import Union
Number = Union[int, float]
Price = Number
Tax = Number

#def sales_tax(price : Price) -> Tax:
#    return ... price ...

EXPENSIVE_PRICE_THRESHOLD : int = 1000
LUXURY_PRICE_THRESHOLD : int = 10000

def inexpensive(price : Price) -> bool:
    return ((price >= 0) and
            (price < EXPENSIVE_PRICE_THRESHOLD))

def expensive(price : Price) -> bool:
    return ((price >= EXPENSIVE_PRICE_THRESHOLD) and
            (price < LUXURY_PRICE_THRESHOLD))

def luxury(price : Price) -> bool:
    return (price >= LUXURY_PRICE_THRESHOLD)

EXPENSIVE_SALES_TAX_PERCENTAGE : float = .05 # still need to learn about decimal.Decimal for money
LUXURY_SALES_TAX_PERCENTAGE : float = .08

def sales_tax(price : Price) -> Tax:
    if inexpensive(price):
        return 0
    elif expensive(price):
        return EXPENSIVE_SALES_TAX_PERCENTAGE * price
    elif luxury(price):
        return LUXURY_SALES_TAX_PERCENTAGE * price
    else:
        raise Exception('should not reach this case')

import unittest

class TestSalesTax(unittest.TestCase):

    def test_sales_tax(self):
        self.assertEqual(sales_tax(0), 0)
        self.assertEqual(sales_tax(999), 0)
        self.assertEqual(sales_tax(1000), 1000 * .05)
        self.assertEqual(sales_tax(9999), 9999 * .05)
        self.assertEqual(sales_tax(10000), 10000 * .08)
        self.assertEqual(sales_tax(12329), 12329 * .08)

import pytest

def test_sales_tax_pytest():
    assert sales_tax(0) == 0
    assert sales_tax(999) == 0
    assert sales_tax(1000) == 1000 * .05
    assert sales_tax(9999) == 9999 * .05
    assert sales_tax(10000) == 10000 * .08
    assert sales_tax(12329) == 12329 * .08

