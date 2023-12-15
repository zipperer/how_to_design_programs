def celsius_from_fahrenheit(fahrenheit):
    return (5 / 9) * (fahrenheit - 32)

import unittest

class TestCelsiusFromFahrenheit(unittest.TestCase):

    def test_celsius_from_fahrenheit(self):
        self.assertEqual(celsius_from_fahrenheit(32), 0)
        self.assertEqual(celsius_from_fahrenheit(212), 100)
        self.assertEqual(celsius_from_fahrenheit(-40), -40)

import pytest

def test_celsius_from_fahrenheit_pytest():
    assert celsius_from_fahrenheit(32) == 0
    assert celsius_from_fahrenheit(212) == 100
    assert celsius_from_fahrenheit(-40) == -40
