def profit_for_movie_theater_at_price_per_ticket_no_factoring(price_per_ticket):
    ''' see exercise29.rkt -- this is analog of profit-no-factoring'''
    return (((120 + 
              ((15 / 0.1) * 
               (5.0 - price_per_ticket))) *
             price_per_ticket) -
            (180 +
             (0.04 *
              (120 +
               ((15 / 0.1) *
                (5.0 - price))))))

if __name__ == '__main__':

    from exercise27_my_version_after_reading_sample_problem_in_section_above import profit_for_movie_theater_at_price_per_ticket

    import exercise28

    functions_to_compute_profit = [profit_for_movie_theater_at_price_per_ticket,
                                   profit_for_movie_theater_at_price_per_ticket_no_factoring]
    exercise28.view_results_of_functions_to_compute_profit(functions_to_compute_profit)
    
