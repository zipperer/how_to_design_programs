from dataclasses import dataclass
from typing_common import Number
from python_list_utilities import cons

from typing import List

@dataclass
class Work:
    '''
    A Work is a structure:
      Work(employee=employee_name, rate=dollars_earned_per_hour, hours=number_hours_worked)
    interpretation:
      Work(employee=employee_name, rate=dollars_earned_per_hour, hours=number_hours_worked)
      represents a record of work for employee named employee_name who worked number_hours_worked
      hours and earned dollars_earned_per_hour dollars per hour.
    '''
    employee : str
    rate : Number
    hours : Number

def test_work():
    assert Work('George', 10, 5).employee == 'George'
    assert Work('George', 10, 5).rate == 10
    assert Work('George', 10, 5).hours == 5

# List_of_works is one of:
# - []
# - cons(Work, List_of_works), i.e. [Work] + List_of_works
# interpretation:
#   an instance of List_of_works represents the hours worked for a number of employees
# For example:
# - []
# - cons(Work('Robby', 11.95, 39),  []) -- i.e. [Work('Robby', 11.95, 39)] + []
# - cons(Work('Matthew', 12.95, 45), cons(Work('Robby', 11.95, 39), [])) -- i.e. [Work('Matthew', 12.95, 45)] + ([Work('Robby', 11.95, 39)] + [])

# [] is an instance of List_of_works because it satisfies clause 1.

# cons(Work('Robby', 11.95, 39),  []) is an instance of List_of_works because it satisfies clause 2
# with List_of_works := [] and 
#      Work := Work('Robby', 11.95, 39)

# cons(Work('Matthew', 12.95, 45), cons(Work('Robby', 11.95, 39), [])) is an instance of 
# List_of_works because it satisfies clause 2 
# with List_of_works := cons(Work('Robby', 11.95, 39), []) and
#      Work := Work('Matthew', 12.95, 45)

# Additional examples:
# cons(Work('Julia', 12.95, 40), [])
# cons(Work('Julia', 12.95, 40), cons(Work('Matthew', 12.95, 45), cons(Work('Robby', 11.95, 39), [])))

#def test_list_of_work():
#    assert isinstance(cons(Work('Robby', 11.95, 39),  []), List[Work])
#    assert type([]) == List[Work]

# header, signature, purpose statement
# def wages_star_v2(list_of_works : List[Work]) -> List[Number]:
#     '''
#     computes the weekly wages for the given records
#     '''
#     return []

# template -- given input is list
# def wages_star_v2(list_of_works : List[Work]) -> List[Number]:
#     '''
#     computes the weekly wages for the given records
#     '''
#     match list_of_works:
#         case []:
#             return ...
#         case [first_work, *rest_list_of_works]:
#             return ( ... first_work ...  # instance of Work
#                      ... wages_star_v2(rest_list_of_works) ... # weekly wages for the given records after first
#                      )

# template -- given input is list of works
# def wages_star_v2(list_of_works : List[Work]) -> List[Number]:
#     '''
#     computes the weekly wages for the given records
#     '''
#     match list_of_works:
#         case []:
#             return ...
#         case [first_work, *rest_list_of_works]:
#             return ( ... first_work ...  # instance of Work
#                      ... first_work.employee ...
#                      ... first_work.rate ...
#                      ... first_work.hours ...
#                      ... wages_star_v2(rest_list_of_works) ... # weekly wages for the given records after first
#                      )

# template -- given input is list of works and factoring out section that processes instance of Work
# def wages_star_v2(list_of_works : List[Work]) -> List[Number]:
#     '''
#     computes the weekly wages for the given records
#     '''
#     match list_of_works:
#         case []:
#             return ...
#         case [first_work, *rest_list_of_works]:
#             return ( ... process_work(first_work) ...
#                      ... wages_star_v2(rest_list_of_works) ... # weekly wages for the given records after first
#                      )

# def process_work(work_instance : Work): # -> ???
#     return (... first_work.employee ...
#             ... first_work.rate ...
#             ... first_work.hours ...)

def wages_star_v2(list_of_works : List[Work]) -> List[Number]:
    '''
    computes the weekly wages for the given records
    '''
    match list_of_works:
        case []:
            return []
        case [first_work, *rest_list_of_works]:
            return cons(wage_v2(first_work), wages_star_v2(rest_list_of_works))

def wage_v2(work_instance : Work) -> Number:
    '''
    computes wage for work instance
    '''
    return (work_instance.rate * work_instance.hours)

def test_wage_v2():
    assert wage_v2(Work('Robby', 11.95, 39)) == (11.95 * 39)
    assert wage_v2(Work('Matthew', 12.95, 45)) == (12.95 * 45)
    assert wage_v2(Work('Julia', 12.95, 40)) == (12.95 * 40)

def test_wages_star_v2():
    assert wages_star_v2([]) == []
    assert wages_star_v2(cons(Work('Robby', 11.95, 39),  [])) == cons(11.95 * 39, [])
    assert wages_star_v2(cons(Work('Matthew', 12.95, 45), cons(Work('Robby', 11.95, 39), []))) == cons(12.95 * 45, cons(11.95 * 39, []))
    assert wages_star_v2(cons(Work('Julia', 12.95, 40), [])) == cons(12.95 * 40, [])
    assert wages_star_v2(cons(Work('Julia', 12.95, 40), cons(Work('Matthew', 12.95, 45), cons(Work('Robby', 11.95, 39), [])))) == cons(12.95 * 40, cons(12.95 * 45, cons(11.95 * 39, [])))

    # alternative format
    assert wages_star_v2([]) == []
    assert wages_star_v2([Work('Robby', 11.95, 39)]) == [11.95 * 39]
    assert wages_star_v2([Work('Matthew', 12.95, 45), Work('Robby', 11.95, 39)]) == [12.95 * 45, 11.95 * 39]
    assert wages_star_v2([Work('Julia', 12.95, 40)]) == [12.95 * 40]
    assert wages_star_v2([Work('Julia', 12.95, 40), Work('Matthew', 12.95, 45), Work('Robby', 11.95, 39)]) == [12.95 * 40, 12.95 * 45, 11.95 * 39]



# Exercise 166. 
# The wage*.v2 function consumes a list of work records and produces a list of numbers. 
# Of course, functions may also produce lists of structures.

# Develop a data representation for paychecks. 
# Assume that a paycheck contains two distinctive pieces of information: 
# the employee’s name and an amount. 
# Then design the function wage*.v3. 
# It consumes a list of work records and computes a list of paychecks from it, one per record.    

@dataclass
class Paycheck:
    name : str
    amount : Number

# e.g. 
# Paycheck('Robby', 11.95 * 39)
# Paycheck('Matthew', 12.95 * 45)
# Paycheck('Julia', 12.95 * 40)

def wage_star_v3(list_of_work_records : List[Work]) -> List[Paycheck]:
    '''
    Parameters:
     - list_of_work_records is a list of instances of Work

    Returns:
     - list of instances of Paycheck.
     -- this function computes each instance from a given instance of Work
    '''
    match list_of_work_records:
        case []:
            return []
        case [first_work_record, *rest_work_records]:
            return cons(work_record_to_paycheck(first_work_record),
                        wage_star_v3(rest_work_records))

def wage_v3(work : Work) -> Number:
    return (work.rate * work.hours)

def work_record_to_paycheck(work : Work) -> Paycheck:
    return Paycheck(work.employee,
                    wage_v3(work))
                
#Work('Robby', 11.95, 39)
#Work('Matthew', 12.95, 45)
#Work('Julia', 12.95, 40)
def test_wage_star_v3():
    assert wage_star_v3([]) == []
    assert wage_star_v3([Work('Robby', 11.95, 39)]) == [Paycheck('Robby', 11.95 * 39)]
    assert wage_star_v3([Work('Robby', 11.95, 39), Work('Matthew', 12.95, 45)]) == [Paycheck('Robby', 11.95 * 39), Paycheck('Matthew', 12.95 * 45)]
    assert wage_star_v3([Work('Julia', 12.95, 40), Work('Robby', 11.95, 39), Work('Matthew', 12.95, 45)]) == [Paycheck('Julia', 12.95 * 40), Paycheck('Robby', 11.95 * 39), Paycheck('Matthew', 12.95 * 45)]

def wage_star_v3_map(list_of_work_records : List[Work]) -> List[Paycheck]:
    '''
    Parameters:
     - list_of_work_records is a list of instances of Work

    Returns:
     - list of instances of Paycheck.
     -- this function computes each instance from a given instance of Work
    '''
    return list(map(work_record_to_paycheck, list_of_work_records))

def test_wage_star_v3_map():
    assert wage_star_v3_map([]) == []
    assert wage_star_v3_map([Work('Robby', 11.95, 39)]) == [Paycheck('Robby', 11.95 * 39)]
    assert wage_star_v3_map([Work('Robby', 11.95, 39), Work('Matthew', 12.95, 45)]) == [Paycheck('Robby', 11.95 * 39), Paycheck('Matthew', 12.95 * 45)]
    assert wage_star_v3_map([Work('Julia', 12.95, 40), Work('Robby', 11.95, 39), Work('Matthew', 12.95, 45)]) == [Paycheck('Julia', 12.95 * 40), Paycheck('Robby', 11.95 * 39), Paycheck('Matthew', 12.95 * 45)]  
