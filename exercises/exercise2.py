import unittest

prefix = "hello"
suffix = "world"

class TestConcatenate(unittest.TestCase):

    def test_concatenate(self):
        self.assertEqual(prefix + '_' + suffix, "hello_world")
        self.assertEqual(f'{prefix}_{suffix}', "hello_world")
        self.assertEqual('{prefix}_{suffix}'.format(prefix=prefix, suffix=suffix), "hello_world")
        self.assertEqual('{0}_{1}'.format(prefix, suffix), "hello_world")
        self.assertEqual('{}_{}'.format(prefix, suffix), "hello_world")
        self.assertEqual('_'.join([prefix, suffix]), "hello_world")
