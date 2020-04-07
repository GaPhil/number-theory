# returns x^e mod N
def squareAndMultiply(x, e, N):
   z = 1
   i = setBitNumber(e)
   while i >= 0:
      z = z * z % N
      if e >> i & 1 == 1:
         z = z * x % N
      i = i - 1
   return z

def setBitNumber(n):
   if (n == 0):
      return 0
   msb = 0
   while (n > 0):
      n = int(n / 2)
      msb += 1
   return (1 << msb)

assert squareAndMultiply(1, 1, 1) == 0
assert squareAndMultiply(1, 4, 1) == 0
assert squareAndMultiply(2, 3, 3) == 2
assert squareAndMultiply(5, 3, 7) == 6
