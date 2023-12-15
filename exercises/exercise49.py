def version_with_if_statement(x):
    if x > 0:
        return 'greater than zero'
    else:
        return 'zero or less'

def version_with_if_expression(x):
    return 'greater than zero' if x > 0 else 'zero or less'

import unittest

class TestVersions(unittest.TestCase):

    def test_version_with_if_statement(self):
        self.assertEqual(version_with_if_statement(0), version_with_if_expression(0))
        self.assertEqual(version_with_if_statement(1), version_with_if_expression(1))

import pytest

def test_version_with_if_statement_pytest():
    assert version_with_if_statement(0) == version_with_if_expression(0)
    assert version_with_if_statement(1) == version_with_if_expression(1)
