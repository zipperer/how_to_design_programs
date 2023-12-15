from enum import IntEnum

class PromiseLevel(IntEnum):
    IRRESISTIBLE = 1
    VERY_PROMISING = 2

    def more_promising_instance_method(self, other):
        return self < other

def more_promising(promsise_level_a, promise_level_b):
    return promsise_level_a < promise_level_b

print(PromiseLevel.IRRESISTIBLE < PromiseLevel.VERY_PROMISING)
print(more_promising(PromiseLevel.IRRESISTIBLE, PromiseLevel.VERY_PROMISING))
print(PromiseLevel.IRRESISTIBLE.more_promising_instance_method(PromiseLevel.VERY_PROMISING))
