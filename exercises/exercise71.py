HEIGHT = 200
MIDDLE = (HEIGHT / 2)
WIDTH = 400
CENTER = (WIDTH / 2)

from posn import Posn

class Game:

    def __init__(self,
                 left_player,
                 right_player,
                 ball):
        self.left_player = left_player
        self.right_player = right_player
        self.ball = ball

    def __eq__(self, other):
        breakpoint()
        return (isinstance(other, Game) and
                self.left_player == other.left_player and
                self.right_player == other.right_player and 
                self.ball == other.ball)

game0 = Game(MIDDLE,
             MIDDLE,
             Posn(CENTER,
                  CENTER))

game1 = Game(MIDDLE,
             MIDDLE,
             Posn(CENTER,
                  CENTER))

import pytest

def test_game():
    #breakpoint()
    assert game0.ball == Posn(CENTER, CENTER) # equals between instances of Posns works. equals between instances of Game does not until I add __eq__() method above.
                                              # dataclasses (in this case, Posn) get automatic __eq__() that is true when fields are true.
    assert isinstance(game0.ball, Posn) == True
    assert game0.left_player == MIDDLE
