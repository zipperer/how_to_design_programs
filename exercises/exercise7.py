import unittest

sunny = True
friday = False

def good_day_to_go_to_mall(sunny, friday):
    return ((not sunny) or
            friday)

class TestGoodDayToGoToMall(unittest.TestCase):

    def test_good_day_to_go_to_mall(self):
        self.assertEqual(good_day_to_go_to_mall(sunny, friday), False)
