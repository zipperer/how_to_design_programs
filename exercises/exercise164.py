# Exercise 164
# Design the function convert-euro, which converts a list of US$ amounts into a list of € amounts. 
# Look up the current exchange rate on the web.

# Generalize convert-euro to the function convert-euro*, 
# which consumes an exchange rate and a list of US$ amounts and 
# converts the latter into a list of € amounts.

from typing import List, Union
from typing_common import Number

CURRENT_EXCHANGE_RATE_US_DOLLAR_TO_EURO = .93

def convert_us_dollar_to_euro(us_dollar_amount: Number) -> Number:
    return CURRENT_EXCHANGE_RATE_US_DOLLAR_TO_EURO * us_dollar_amount

def test_convert_us_dollar_to_euro():
    assert convert_us_dollar_to_euro(0) == 0.0
    assert convert_us_dollar_to_euro(1) == 1 * CURRENT_EXCHANGE_RATE_US_DOLLAR_TO_EURO
    assert convert_us_dollar_to_euro(2) == 2 * CURRENT_EXCHANGE_RATE_US_DOLLAR_TO_EURO

def convert_euro(list_of_us_dollar_amounts: List[Number]) -> List[Number]:
    '''
    takes list of US dollar amounts
    returns list of euro amounts
    '''
    match list_of_us_dollar_amounts:
        case []:
            return []
        case [first_us_dollar_amount, *rest_us_dollar_amounts]:
            return (
                [convert_us_dollar_to_euro(first_us_dollar_amount)]
                +
                convert_euro(rest_us_dollar_amounts)
            )
        
# template
# def convert_euro(list_of_us_dollar_amounts: List[Number]) -> List[Number]:
#     '''
#     takes list of US dollar amounts
#     returns list of euro amounts
#     '''
#     match list_of_us_dollar_amounts:
#         case []:
#             return []
#         case [first_us_dollar_amount, *rest_us_dollar_amounts]:
#             return (...
#                     first_us_dollar_amount # Number that represents a US dollar amount
#                     ...
#                     rest_us_dollar_amounts # List[Number] that represents list of remaining US dollar amounts after first
#                     ...
#                     convert_euro(rest_us_dollar_amounts) # List[Number] that represents the list of
#                           # euro amounts that correspond to converting the US dollar amounts to euro
#                 )

def test_convert_euro():
    assert convert_euro([]) == []
    assert convert_euro([1]) == [convert_us_dollar_to_euro(1)]
    assert convert_euro([2]) == [convert_us_dollar_to_euro(2)]
    assert convert_euro([1, 2]) == [convert_us_dollar_to_euro(1), convert_us_dollar_to_euro(2)]

def convert_us_dollar_amount_to_euro_given_exchange_rate(us_dollar_amount : Number,
                                                         exchange_rate : Number
                                                         ) -> Number:
    return exchange_rate * us_dollar_amount

def test_convert_us_dollar_amount_to_euro_given_exchange_rate():
    assert convert_us_dollar_amount_to_euro_given_exchange_rate(1, CURRENT_EXCHANGE_RATE_US_DOLLAR_TO_EURO) == CURRENT_EXCHANGE_RATE_US_DOLLAR_TO_EURO * 1
    assert convert_us_dollar_amount_to_euro_given_exchange_rate(2, CURRENT_EXCHANGE_RATE_US_DOLLAR_TO_EURO) == CURRENT_EXCHANGE_RATE_US_DOLLAR_TO_EURO * 2

def convert_euro_given_exchange_rate(list_of_us_dollar_amounts: List[Number],
                                     exchange_rate_us_dollar_to_euro: Number
                                     ) -> List[Number]:
    '''
    takes:
     - list of US dollar amounts
     - exchange rate from US dollar to euro
    returns list of euro amounts
    '''
    match list_of_us_dollar_amounts:
        case []:
            return []
        case [first_us_dollar_amount, *rest_us_dollar_amounts]:
            return (
                [convert_us_dollar_amount_to_euro_given_exchange_rate(first_us_dollar_amount, exchange_rate_us_dollar_to_euro)]
                +
                convert_euro_given_exchange_rate(rest_us_dollar_amounts, exchange_rate_us_dollar_to_euro)
                )

def test_convert_euro_given_exchange_rate():
    assert convert_euro_given_exchange_rate([], CURRENT_EXCHANGE_RATE_US_DOLLAR_TO_EURO) == []
    assert convert_euro_given_exchange_rate([1], CURRENT_EXCHANGE_RATE_US_DOLLAR_TO_EURO) == [convert_us_dollar_amount_to_euro_given_exchange_rate(1, CURRENT_EXCHANGE_RATE_US_DOLLAR_TO_EURO)]
    assert convert_euro_given_exchange_rate([2], CURRENT_EXCHANGE_RATE_US_DOLLAR_TO_EURO) == [convert_us_dollar_amount_to_euro_given_exchange_rate(2, CURRENT_EXCHANGE_RATE_US_DOLLAR_TO_EURO)]
    assert convert_euro_given_exchange_rate([1, 2], CURRENT_EXCHANGE_RATE_US_DOLLAR_TO_EURO) == [convert_us_dollar_amount_to_euro_given_exchange_rate(1, CURRENT_EXCHANGE_RATE_US_DOLLAR_TO_EURO), convert_us_dollar_amount_to_euro_given_exchange_rate(2, CURRENT_EXCHANGE_RATE_US_DOLLAR_TO_EURO)]

def convert_euro_given_exchange_rate_map(list_of_us_dollar_amounts: List[Number],
                                         exchange_rate_us_dollar_to_euro: Number
                                         ) -> List[Number]:
    '''
    takes:
     - list of US dollar amounts
     - exchange rate from US dollar to euro
    returns list of euro amounts
    '''
    # how/where to write a test for this function?
    def convert_us_dollar_amount_to_euro_given_exchange_rate_map_function(us_dollar_amount: Number) -> Number:
        '''
        converts us dollar amount to euro amount
        takes exchange rate from scope of function that encloses this one, so
        this function is unary and can be used as FUNCTION in map(FUNCTION, iterable)
        '''
        return convert_us_dollar_amount_to_euro_given_exchange_rate(us_dollar_amount, exchange_rate_us_dollar_to_euro)

    return list(map(convert_us_dollar_amount_to_euro_given_exchange_rate_map_function,
                    list_of_us_dollar_amounts))

def test_convert_euro_given_exchange_rate_map():
    assert convert_euro_given_exchange_rate_map([], CURRENT_EXCHANGE_RATE_US_DOLLAR_TO_EURO) == []
    assert convert_euro_given_exchange_rate_map([1], CURRENT_EXCHANGE_RATE_US_DOLLAR_TO_EURO) == [convert_us_dollar_amount_to_euro_given_exchange_rate(1, CURRENT_EXCHANGE_RATE_US_DOLLAR_TO_EURO)]
    assert convert_euro_given_exchange_rate_map([2], CURRENT_EXCHANGE_RATE_US_DOLLAR_TO_EURO) == [convert_us_dollar_amount_to_euro_given_exchange_rate(2, CURRENT_EXCHANGE_RATE_US_DOLLAR_TO_EURO)]
    assert convert_euro_given_exchange_rate_map([1, 2], CURRENT_EXCHANGE_RATE_US_DOLLAR_TO_EURO) == [convert_us_dollar_amount_to_euro_given_exchange_rate(1, CURRENT_EXCHANGE_RATE_US_DOLLAR_TO_EURO), convert_us_dollar_amount_to_euro_given_exchange_rate(2, CURRENT_EXCHANGE_RATE_US_DOLLAR_TO_EURO)]
