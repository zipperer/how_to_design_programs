import unittest

def implies (antecedent_truth_value, consequent_truth_value):
    return ((not antecedent_truth_value) or consequent_truth_value)

class TestImplies(unittest.TestCase):

    def test_implies(self):
        self.assertEqual(implies(True, True), True)
        self.assertEqual(implies(True, False), False)
        self.assertEqual(implies(False, True), True)
        self.assertEqual(implies(False, False), True)
