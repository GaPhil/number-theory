import math

def gcd(m, n):
   while n != 0:
      t = n
      n = m % n
      m = t
   return m

def extendeuc(m, n):
   if m % n == 0:
      return [0, 1]
   else:
      [x, y] = extendeuc(n, m % n)
      return [y, x - y * math.floor(m/n)]


for x in range(1, 25):
   for y in range(1, 25):
      for m in range(1, 25):
         for n in range(1, 25):
            [x, y] = extendeuc(m, n)
            assert gcd(m, n) == x*m + y*n
