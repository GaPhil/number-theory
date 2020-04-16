from random import randrange

# assume n >= 3
def solovayStrassen(n, r):
    for i in range(1, r):
        a = random.randint(0, n)
        if jacobi(a, n) == 0 or jacobi(a, n) != ((a ** ((n - 1) / 2)) % n):
            return "composite"
    return "probably prime"


# assume that a >= 0 and b >= 3 is odd
def jacobi(a, n):
    assert (0 < a < n and n % 2 == 1)
    t = 1
    while a != 0:
        while a % 2 == 0:
            a /= 2
            r = n % 8
            if r == 3 or r == 5:
                t = -t
        a, n = n, a
        if a % 4 == n % 4 == 3:
            t = -t
        a %= n
    if n == 1:
        return t
    else:
        return 0

assert (3, 100) == "probably prime"
assert (8, 100) == "composite"
