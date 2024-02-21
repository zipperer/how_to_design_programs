# In reality, a paycheck also contains an employee number. 
# Develop a data representation for employee information and 
#  change the data definition for work records so that it uses 
#  employee information and not just a string for the employee’s name. 

# Also change your data representation of paychecks so that it contains 
# an employee’s name and number, too. 

# Finally, design wage*.v4, a function that maps 
#   lists of revised work records to lists of revised paychecks.

from dataclasses import dataclass
from typing_common import Number
from typing import List
from python_list_utilities import cons

@dataclass
class EmployeeInformation:
    '''
    An EmployeeInformation is a structure that stores information for an employee.

    interpretation:
      EmployeeInformation(id=1, name='George') represents an employee named George with id 1.

    For example:
      EmployeeInformation(id=1, name='Robby')
      EmployeeInformation(id=2, name='Matthew')
      EmployeeInformation(id=3, name='Julia')
    '''
    id : int
    name: str

#Work('Robby', 11.95, 39)
#Work('Matthew', 12.95, 45)
#Work('Julia', 12.95, 40)

@dataclass
class WorkRecord:
    '''
    A WorkRecord is a structure that stores information about an employee's work.

    interpretation:
      WorkRecord(employee_information=EmployeeInformation(id=1, name='Robby'), rate=11.95, hours=39)
      represents an employee named Robby with id 1 who worked 39 hours with a rate of pay of
      11.95 dollars per hour.

    For example:
     - WorkRecord(employee_information=EmployeeInformation(id=2, name='Matthew'), rate=12.95, hours=45)
     - WorkRecord(employee_information=EmployeeInformation(id=3, name='Julia'), rate=12.95, hours=40)
    '''
    employee_information : EmployeeInformation
    rate: Number
    hours: Number

@dataclass
class Paycheck:
    '''
    A Paycheck is a structure that stores information about an employee's paycheck.

    interpretation:
      Paycheck(employee_information=EmployeeInformation(id=1, name='Robby'), amount=(11.95 * 39))
      represents a paycheck for employee named Robby with id 1 for amount (11.95 * 39) dollars.

    For example:
     - Paycheck(employee_information=EmployeeInformation(id=2, name='Matthew'), amount=(12.95 * 45))
     - Paycheck(employee_information=EmployeeInformation(id=3, name='Julia'), amount=(12.95 * 40))
    '''
    employee_information : EmployeeInformation
    amount: Number

def wage_v4(work_record : WorkRecord) -> Number:
    return (work_record.rate * work_record.hours)

def work_record_to_paycheck(work_record : WorkRecord) -> Paycheck:
    return Paycheck(work_record.employee_information,
                    wage_v4(work_record))

def wage_star_v4(list_of_work_records : List[WorkRecord]) -> List[Paycheck]:
    '''
    Parameters:
     - list of instances of WorkRecord

    Returns:
     - list of instances of Paycheck
     -- each instance of Paycheck computed from a given instance of WorkRecord
    '''
    match list_of_work_records:
        case []:
            return []
        case [first_work_record, *rest_list_of_work_records]:
            return cons(work_record_to_paycheck(first_work_record),
                        wage_star_v4(rest_list_of_work_records))

def test_wage_star_v4():
    assert wage_star_v4([]) == []
    assert wage_star_v4([WorkRecord(EmployeeInformation(1, 'Robby'), 11.95, 39)]) == [Paycheck(EmployeeInformation(1, 'Robby'), (11.95 * 39))]
    assert wage_star_v4([WorkRecord(EmployeeInformation(1, 'Robby'), 11.95, 39), WorkRecord(EmployeeInformation(2, 'Matthew'), 12.95, 45)]) == [Paycheck(EmployeeInformation(1, 'Robby'), (11.95 * 39)), Paycheck(EmployeeInformation(2, 'Matthew'), (12.95 * 45))]
    assert wage_star_v4([WorkRecord(EmployeeInformation(3, 'Julia'), 12.95, 40), WorkRecord(EmployeeInformation(1, 'Robby'), 11.95, 39), WorkRecord(EmployeeInformation(2, 'Matthew'), 12.95, 45)]) == [Paycheck(EmployeeInformation(3, 'Julia'), (12.95 * 40)), Paycheck(EmployeeInformation(1, 'Robby'), (11.95 * 39)), Paycheck(EmployeeInformation(2, 'Matthew'), (12.95 * 45))]

def wage_star_v4_map(list_of_work_records : List[WorkRecord]) -> List[Paycheck]:
    '''
    Parameters:
     - list of instances of WorkRecord

    Returns:
     - list of instances of Paycheck
     -- each instance of Paycheck computed from a given instance of WorkRecord
    '''
    return list(map(work_record_to_paycheck, list_of_work_records))

def test_wage_star_v4_map():
    assert wage_star_v4_map([]) == []
    assert wage_star_v4_map([WorkRecord(EmployeeInformation(1, 'Robby'), 11.95, 39)]) == [Paycheck(EmployeeInformation(1, 'Robby'), (11.95 * 39))]
    assert wage_star_v4_map([WorkRecord(EmployeeInformation(1, 'Robby'), 11.95, 39), WorkRecord(EmployeeInformation(2, 'Matthew'), 12.95, 45)]) == [Paycheck(EmployeeInformation(1, 'Robby'), (11.95 * 39)), Paycheck(EmployeeInformation(2, 'Matthew'), (12.95 * 45))]
    assert wage_star_v4_map([WorkRecord(EmployeeInformation(3, 'Julia'), 12.95, 40), WorkRecord(EmployeeInformation(1, 'Robby'), 11.95, 39), WorkRecord(EmployeeInformation(2, 'Matthew'), 12.95, 45)]) == [Paycheck(EmployeeInformation(3, 'Julia'), (12.95 * 40)), Paycheck(EmployeeInformation(1, 'Robby'), (11.95 * 39)), Paycheck(EmployeeInformation(2, 'Matthew'), (12.95 * 45))]
