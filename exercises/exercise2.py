import unittest

prefix = "hello"
suffix = "world"

class TestConcatenate(unittest.TestCase):

    def test_concatenate(self):
        self.assertEqual(prefix + '_' + suffix, "hello_world")
