from exercise27_my_version_after_reading_sample_problem_in_section_above import profit_for_movie_theater_at_price_per_ticket

def max_profit_among_options_for_price_per_ticket(prices_to_check):
    max_profit_among_choices = None
    choice_that_gives_max_profit = None
    for price_per_ticket in prices_to_check:
        print(f'{price_per_ticket=}')
        profit_at_price_per_ticket = profit_for_movie_theater_at_price_per_ticket(price_per_ticket)
        print(profit_at_price_per_ticket)
        if ((max_profit_among_choices == None) or
            (profit_at_price_per_ticket > max_profit_among_choices)):
            max_profit_among_choices = profit_at_price_per_ticket
            choice_that_gives_max_profit = price_per_ticket
    return choice_that_gives_max_profit, max_profit_among_choices

price_per_ticket_prices_to_check = (x for x in range(1,6))
print(max_profit_among_options_for_price_per_ticket(price_per_ticket_prices_to_check))

price_per_ticket_prices_to_check_ten_cent_increments = (3 + (y / 100) for y in range(-50, 60, 10))
print(max_profit_among_options_for_price_per_ticket(price_per_ticket_prices_to_check_ten_cent_increments))

# Woflram Alpha gives x = 73/25 for
# "max (x * (120 + (15 * (10 * (5 - x))))) - (180 + (.04 * (120 + (15 * (10 * (5 - x)))))) from x = 0 to x = 6"
