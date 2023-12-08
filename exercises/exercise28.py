from exercise27_my_version_after_reading_sample_problem_in_section_above import profit_for_movie_theater_at_price_per_ticket

def max_profit_among_options_for_price_per_ticket(prices_to_check, function_to_use_to_compute_profit):
    max_profit_among_choices = None
    choice_that_gives_max_profit = None
    for price_per_ticket in prices_to_check:
        print(f'{price_per_ticket=}')
        profit_at_price_per_ticket = function_to_use_to_compute_profit(price_per_ticket)
        print(profit_at_price_per_ticket)
        if ((max_profit_among_choices == None) or
            (profit_at_price_per_ticket > max_profit_among_choices)):
            max_profit_among_choices = profit_at_price_per_ticket
            choice_that_gives_max_profit = price_per_ticket
    return choice_that_gives_max_profit, max_profit_among_choices

def compare_profit_among_options_for_price_per_ticket_given_function_to_compute_profit(function_to_compute_profit):
    
    price_per_ticket_prices_to_check = (x for x in range(1,6))
    print(max_profit_among_options_for_price_per_ticket(price_per_ticket_prices_to_check, function_to_compute_profit))

    price_per_ticket_prices_to_check_ten_cent_increments = (3 + (y / 100) for y in range(-50, 60, 10))
    print(max_profit_among_options_for_price_per_ticket(price_per_ticket_prices_to_check_ten_cent_increments, function_to_compute_profit))

def view_results_of_functions_to_compute_profit(functions_to_compute_profit):
    for function_to_compute_profit in functions_to_compute_profit:
        compare_profit_among_options_for_price_per_ticket_given_function_to_compute_profit(function_to_compute_profit)

if __name__ == '__main__':
    functions_to_compute_profit = [profit_for_movie_theater_at_price_per_ticket]
    view_results_of_functions_to_compute_profit(functions_to_compute_profit)
    

# Woflram Alpha gives x = 73/25 for
# "max (x * (120 + (15 * (10 * (5 - x))))) - (180 + (.04 * (120 + (15 * (10 * (5 - x)))))) from x = 0 to x = 6"


# ran this file with
# $ docker run --rm -v "${PWD}":/exercises/ python3-with-pytest python3 /exercises/exercise28.py

# Dockerfile below

# copied from https://hub.docker.com/_/python                                            
#from python:3

#WORKDIR /usr/src/app

#COPY requirements.txt ./
#RUN pip install --no-cache-dir -r requirements.txt

#COPY . .

##CMD [ "python", "./your-daemon-or-script.py" ]  
