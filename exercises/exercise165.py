# Exercise 165.
# Design the function subst-robot, 
# which consumes a list of toy descriptions (one-word strings) and 
# replaces all occurrences of "robot" with "r2d2"; 
# all other descriptions remain the same.

# Generalize subst-robot to substitute. 
# The latter consumes two strings, called new and old, and a list of strings. 
# It produces a new list of strings by substituting all occurrences of old with new. 
from typing import List

def test_subst_robot():
    assert subst_robot([]) == []
    assert subst_robot(["robot"]) == ["r2d2"]
    assert subst_robot(["robot", "bear"]) == ["r2d2", "bear"]
    assert subst_robot(["lego", "robot", "bear"]) == ["lego", "r2d2", "bear"]

def subst_robot(list_of_toy_descriptions: List[str]) -> List[str]:
    '''
    takes list of toy descriptions
    return list of toy descriptions where each occurrence of value "robot" in input list is
      replaced with an occurrence of value "r2d2"
    '''
    match list_of_toy_descriptions:
        case []:
            return []
        case [first_toy_description, *rest_toy_descriptions] if first_toy_description == 'robot':
            return ['r2d2'] + subst_robot(rest_toy_descriptions)
        case [first_toy_description, *rest_toy_descriptions]:
            return [first_toy_description] + subst_robot(rest_toy_descriptions)

def test_subst_robot_map():
    assert subst_robot_map([]) == []
    assert subst_robot_map(["robot"]) == ["r2d2"]
    assert subst_robot_map(["robot", "bear"]) == ["r2d2", "bear"]
    assert subst_robot_map(["lego", "robot", "bear"]) == ["lego", "r2d2", "bear"]

def subst_robot_map(list_of_toy_descriptions : List[str]) -> List[str]:
    '''
    I intend this has the same input-output behavior as subst_robot
    '''
    def subst_robot_with_r2d2(toy_description : str) -> str:
        match toy_description:
            case 'robot':
                return 'r2d2'
            case _:
                return toy_description

    return list(map(subst_robot_with_r2d2, list_of_toy_descriptions))

def test_subst_robot_iterate_with_side_effect():
    assert subst_robot_iterate_with_side_effect([]) == []
    assert subst_robot_iterate_with_side_effect(["robot"]) == ["r2d2"]
    assert subst_robot_iterate_with_side_effect(["robot", "bear"]) == ["r2d2", "bear"]
    assert subst_robot_iterate_with_side_effect(["lego", "robot", "bear"]) == ["lego", "r2d2", "bear"]
       
def subst_robot_iterate_with_side_effect(list_of_toy_descriptions: List[str]) -> List[str]:
    '''
    I intend this has the same input-output behavior as subst_robot
    '''
    list_of_toy_descriptions_after_replacing_robot_with_r2d2 : List[str] = list()
    append = list_of_toy_descriptions_after_replacing_robot_with_r2d2.append
    for toy_description in list_of_toy_descriptions:
        if toy_description == 'robot':
            append('r2d2')
        else:
            append(toy_description)
    return list_of_toy_descriptions_after_replacing_robot_with_r2d2

def test_substitute():
    assert substitute('r2d2', 'robot', []) == []
    assert substitute('r2d2', 'robot', ["robot"]) == ["r2d2"]
    assert substitute('r2d2', 'robot', ["robot", "bear"]) == ["r2d2", "bear"]
    assert substitute('r2d2', 'robot', ["lego", "robot", "bear"]) == ["lego", "r2d2", "bear"]    

    assert substitute('robot', 'r2d2', ["robot"]) == ["robot"]
    assert substitute('blue', 'red', ["robot", "bear"]) == ["robot", "bear"]
    assert substitute('blue', 'red', ["lego", "robot", "bear"]) == ["lego", "robot", "bear"]
    
def substitute(new : str, 
               old : str, 
               list_of_toy_descriptions : List[str]
               ) -> List[str]:
    '''

    Parameters:
      NEW : str, used to replace occurrences of OLD
      OLD : str, occurrences will be replaced by NEW
      LIST_OF_TOY_DESCRIPTIONS : List[str], occurrences of OLD will replaced by NEW

    Returns:
      List[str] -- elements from LIST_OF_TOY_DESCRIPTIONS with occurrences of OLD replaced by NEW
    '''
    match list_of_toy_descriptions:
        case []:
            return []
        case [first_toy_description, *rest_list_of_toy_descriptions] if first_toy_description == old:
            return [new] + substitute(new, old, rest_list_of_toy_descriptions)
        case [first_toy_description, *rest_list_of_toy_descriptions]:
            return [first_toy_description] + substitute(new, old, rest_list_of_toy_descriptions)

def test_substitute_map():
    assert substitute_map('r2d2', 'robot', []) == []
    assert substitute_map('r2d2', 'robot', ["robot"]) == ["r2d2"]
    assert substitute_map('r2d2', 'robot', ["robot", "bear"]) == ["r2d2", "bear"]
    assert substitute_map('r2d2', 'robot', ["lego", "robot", "bear"]) == ["lego", "r2d2", "bear"]    

    assert substitute_map('robot', 'r2d2', ["robot"]) == ["robot"]
    assert substitute_map('blue', 'red', ["robot", "bear"]) == ["robot", "bear"]
    assert substitute_map('blue', 'red', ["lego", "robot", "bear"]) == ["lego", "robot", "bear"]

def substitute_map(new: str,
                   old: str,
                   list_of_toy_descriptions : List[str]
                   ) -> List[str]:
    '''
    I intend this has same input-output as substitute.
    '''
    def replace_old_with_new(given_string : str) -> str:
        '''
        replace occurrence of OLD with NEW
        otherwise, return unchanged
        '''
        if given_string == old:
            return new
        else:
            return given_string

    return list(map(replace_old_with_new, list_of_toy_descriptions))
