#import math
import decimal

def profit_for_movie_theater_at_price_per_ticket(price_per_ticket):
    revenue_for_movie_theater = revenue_for_movie_theater_at_price_per_ticket(price_per_ticket)
    cost_for_movie_theater = cost_for_movie_theater_at_price_per_ticket(price_per_ticket)
    return (revenue_for_movie_theater - cost_for_movie_theater)


def revenue_for_movie_theater_at_price_per_ticket(price_per_ticket):
    number_of_attendees = number_of_attendees_at_price_per_ticket_cached(price_per_ticket)
    revenue_for_movie_theater = number_of_attendees * price_per_ticket
    return revenue_for_movie_theater

number_of_attendees_at_price_per_ticket_cache = dict()

def number_of_attendees_at_price_per_ticket_cached(price_per_ticket):
    if price_per_ticket in number_of_attendees_at_price_per_ticket_cache:
        return number_of_attendees_at_price_per_ticket_cache[price_per_ticket]
    else:
        number_of_attendees = number_of_attendees_at_price_per_ticket(price_per_ticket)
        number_of_attendees_at_price_per_ticket_cache[price_per_ticket] = number_of_attendees
        return number_of_attendees

def number_of_attendees_at_price_per_ticket(price_per_ticket):
    number_of_attendees_at_five_dollars_per_ticket = 120
    number_of_attendees_change_given_price_per_ticket = calculate_number_of_attendees_change_given_price_per_ticket(price_per_ticket)
    number_of_attendees_as_float = number_of_attendees_at_five_dollars_per_ticket + number_of_attendees_change_given_price_per_ticket
    #number_of_attendees = math.floor(number_of_attendees_as_float)
    number_of_attendees = number_of_attendees_as_float
    return number_of_attendees

def calculate_number_of_attendees_change_given_price_per_ticket(price_per_ticket):
    number_of_attendees_change_per_ten_cent_change_in_price_from_five_dollars = 15
    # use decimal to avoid inaccuracy due to floating point.
    # I do not yet have a full grasp on this.
    difference_between_price_per_ticket_and_five_dollars = 5 - decimal.Decimal(price_per_ticket)
    number_of_ten_cent_changes_in_price_from_five_dollars_as_float = 10 * difference_between_price_per_ticket_and_five_dollars
    number_of_ten_cent_changes_in_price_from_five_dollars_as_int = round(number_of_ten_cent_changes_in_price_from_five_dollars_as_float)
    number_of_ten_cent_changes_in_price_from_five_dollars = number_of_ten_cent_changes_in_price_from_five_dollars_as_int
    number_of_attendees_change_given_price_per_ticket = (number_of_attendees_change_per_ten_cent_change_in_price_from_five_dollars *
                                                         number_of_ten_cent_changes_in_price_from_five_dollars)
    return number_of_attendees_change_given_price_per_ticket

def cost_for_movie_theater_at_price_per_ticket(price_per_ticket):
    fixed_cost_for_movie_theater = 180
    variable_cost_for_movie_theater_at_price_per_ticket = calculate_variable_cost_for_movie_theater_at_price_per_ticket(price_per_ticket)
    total_cost_for_movie_theater_at_price_per_ticket = fixed_cost_for_movie_theater + variable_cost_for_movie_theater_at_price_per_ticket
    return total_cost_for_movie_theater_at_price_per_ticket

def calculate_variable_cost_for_movie_theater_at_price_per_ticket(price_per_ticket):
    variable_cost_for_movie_theater_per_attendee = .04
    number_of_attendees = number_of_attendees_at_price_per_ticket_cached(price_per_ticket)
    variable_cost_for_movie_theater_given_number_of_attendees = number_of_attendees * variable_cost_for_movie_theater_per_attendee
    return variable_cost_for_movie_theater_given_number_of_attendees

import unittest

class TestNumberOfAttendeesAtPricePerTicket(unittest.TestCase):

    def test_number_of_attendees_at_price_per_ticket(self):
        self.assertEqual(number_of_attendees_at_price_per_ticket(5), 120)
        self.assertEqual(number_of_attendees_at_price_per_ticket(5.10), 105)
        self.assertEqual(number_of_attendees_at_price_per_ticket(4.90), 135)

import pytest

def test_number_of_attendees_at_price_per_ticket_pytest():
    assert number_of_attendees_at_price_per_ticket(5) == 120
    assert number_of_attendees_at_price_per_ticket(5.10) == 105
    assert number_of_attendees_at_price_per_ticket(4.90) == 135
