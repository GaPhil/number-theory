# eulclidean gcd algorithm
def euc(m, n):
   while n != 0:
      t = n
      n = m % n
      m = t
   return m

# binary gcd algorithm
def stein(m, n):
   if m == 0 or n == 0:
      return 0
   s = 0
   while m % 2 == 0 and n % 2 == 0:
      m = m / 2
      n = n / 2
      s = s + 1
   while n % 2 == 0:
      n = n / 2
   while m != 0:
      while m % 2 == 0:
         m = m / 2
      if m < n:
         tmp = m
         m = n
         n = tmp
      m = m - n
      m = m / 2
   return (2 ** s) * n

for i in range(2, 100):
   for j in range(2, 100):
      assert stein(i, j) == euc(i, j)
      #print stein(i + 2, j + 2)
