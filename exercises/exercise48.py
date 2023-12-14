def reward(score):
    #breakpoint()
    if (score <= 10):
        return "bronze"
    elif ((10 < score) and (score <= 20)):
        return "silver"
    else:
        return "gold"

import unittest

class TestReward(unittest.TestCase):

    def test_reward(self):
        self.assertEqual(reward(0), "bronze")
        self.assertEqual(reward(7), "bronze")
        self.assertEqual(reward(11), "silver")
        self.assertEqual(reward(20), "silver")
        self.assertEqual(reward(21), "gold")

import pytest

def test_reward_pytest():
    assert reward(0) == "bronze"
    assert reward(10) == "bronze"
    assert reward(11) == "silver"
    assert reward(20) == "silver"
    assert reward(21) == "gold"
