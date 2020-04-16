def jacobi(a, b):
    if a < 2:
        return a
    s = 1
    while a % 2 == 0:
        s = s * (-1) ** ((1 / 8) * (b ** 2 - 1))
        a = a / 2
    if a < b:
        tmp = a
        a = b
        b = tmp
        s = s * (-1) ** ((1 / 4) * (a - 1) * (b - 1))
    return s * jacobi(a % b, b)


def jacobi2(a, n):
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

assert jacobi2(1236, 20003) == 1
