# Sample Problem 
# Your team is designing a game program that keeps track of an object 
# that moves across the canvas at changing speed. 
# The chosen data representation requires two data definitions:
# (define-struct ufo [loc vel])
# ; A UFO is a structure: 
# ;   (make-ufo Posn Vel)
# ; interpretation (make-ufo p v) is at location
# ; p moving at velocity v
# It is your task to develop ufo-move-1. 
# The function computes the location of a given UFO after one clock tick passes.

from velocity import Velocity
from posn import Posn
from dataclasses import dataclass

@dataclass
class UFO:
    loc : Posn
    vel : Velocity

def ufo_move_1(ufo : UFO) -> UFO:
    '''computes location of ufo after one clock tick passes'''
    return UFO(loc=posn_plus(ufo.loc, 
                             ufo.vel), 
               vel=ufo.vel)

def posn_plus(p : Posn,
              v : Velocity
              ) -> Posn:
    '''"adds" v to p'''
    return Posn(x=(p.x + v.deltax),
                y=(p.y + v.deltay))

import pytest

v1 = Velocity(deltax=8, deltay=-3)
v2 = Velocity(deltax=-5, deltay=-3)
p1 = Posn(x=22, y=80)
p2 = Posn(x=30, y=77)
u1 = UFO(loc=p1, vel=v1)
u2 = UFO(loc=p1, vel=v2)
u3 = UFO(loc=p2, vel=v1)
u4 = UFO(loc=p2, vel=v2)

def test_ufo_move_1():
    assert ufo_move_1(u1) == u3
    assert ufo_move_1(u2) == UFO(loc=Posn(17, 77), vel=v2)

def test_posn_plus():
    assert posn_plus(p1, v1) == p2
    assert posn_plus(p1, v2) == Posn(17, 77)
