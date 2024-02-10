from typing import List

WAGE_DOLLARS_PER_HOUR = 14

def wage (h : int) -> int:
    '''computes the wage for h hours of work'''
    return WAGE_DOLLARS_PER_HOUR * h

MAX_NUMBER_HOURS_WORKED_PER_WEEK = 100

# wage_star b/c racket version uses wage*
def wage_star (number_of_hours_each_employee_worked : List[int]) -> List[int]:
    '''
    take list of hours worked by each employee
    return list of dollar amounts due to each employee given number of hours worked
    '''
    match number_of_hours_each_employee_worked:
        case []:
            return []
        case [number_of_hours_given_employee_worked, *number_of_hours_rest_of_employees_worked] if (number_of_hours_given_employee_worked <= MAX_NUMBER_HOURS_WORKED_PER_WEEK):
                return (
                    [wage(number_of_hours_given_employee_worked)] +
                    wage_star(number_of_hours_rest_of_employees_worked)
                )
        # exercise 162
        case [number_of_hours_given_employee_worked, *number_of_hours_rest_of_employees_worked]:
            raise ValueError(f'number of hours employee worked ({number_of_hours_given_employee_worked}) exceeds max value permitted ({MAX_NUMBER_HOURS_WORKED_PER_WEEK})')

import pytest

def test_wage_star():
    assert wage_star([]) == []
    assert wage_star([1, 2, 3]) == [wage(1), wage(2), wage(3)]
    assert wage_star([4, 3, 5]) == [wage(4), wage(3), wage(5)]
    assert wage_star([28]) == [wage(28)]
    assert wage_star([4, 2]) == [wage(4), wage(2)]
    # exercise 162
    with pytest.raises(ValueError):
        assert wage_star([101]) == 'placeholder'
    with pytest.raises(ValueError):
        assert wage_star([4, 2, 120, 1]) == 'placeholder'
