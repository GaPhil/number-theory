from sage.all import *

Zx.<x> = ZZ[]

### Basic examples ###

f = Zx([3, 1, 4])
f
# output: 4*x^2 + x + 3
f * x
# output: 4*x^3 + x^2 + 3*x

g = Zx([2, 7, 1])
g
# output: x^2 + 7*x + 2
f * g
# output: 4*x^4 + 29*x^3 + 18*x^2 + 23*x + 6

### Convolution ###

def convolution(f, g):
    return (f * g) % (x ^ n - 1)

n = 3
f * g
# output: 4*x^4 + 29*x^3 + 18*x^2 + 23*x + 6
convolution(f,g)
# output: 18*x^2 + 27*x + 35

f
# output: 4*x^2 + x + 3
convolution(f,x)
# output: x^2 + 3*x + 4
convolution(f,x^2)
# output: 3*x^2 + 4*x + 1

### Modular reduction ###

def balancedmod(f, q):
    g = list(((f[i] + q // 2) % q) - q // 2 for i in range(n))
    return Zx(g)

u = Zx([3, 1, 4, 1, 5, 9])
u
# output: 9*x^5 + 5*x^4 + x^3 + 4*x^2 + x + 3
n = 7
balancedmod(u, 10)
# output: -x^5 - 5*x^4 + x^3 + 4*x^2 + x + 3
balancedmod(u, 3)
# output: -x^4 + x^3 + x^2 + x

u = 314 - 159 * x
u % 200
# output: -159*x + 114
(u - 400) % 200
# output: -159*x - 86
(u - 600) % 200
# output: -159*x + 114
balancedmod(u, 200)
# output: 41*x - 86

### Random polynomials ###

def randomdpoly():
    assert d <= n
    result = n * [0]
    for j in range(d):
        while True:
            r = randrange(n)
            if not result[r]: break
        result[r] = 1 - 2 * randrange(2)
    return Zx(result)

n = 7
d = 5
f = randomdpoly()
f
# output: x^6 + x^5 - x^3 + x^2 - 1
f = randomdpoly()
f
# output: -x^4 + x^3 + x^2 - x + 1

### Division modulo primes ###

def invertmodprime(f, p):
    T = Zx.change_ring(Integers(p)).quotient(x ^ n - 1)
    return Zx(lift(1 / T(f)))

n = 7
f
# output: -x^4 + x^3 + x^2 - x + 1
f3 = invertmodprime(f,3)
f3
# output: x^6 + 2*x^4 + x
convolution(f,f3)
# output: 3*x^6 - 3*x^5 + 3*x^4 + 1

### Division modulo powers of 2 ###

def invertmodpowerof2(f, q):
    assert q.is_power_of(2)
    g = invertmodprime(f, 2)
    while True:
        r = balancedmod(convolution(g, f), q)
        if r == 1: return g
        g = balancedmod(convolution(g, 2 - r), q)

n = 7
q = 256
f
# output: -x^4 + x^3 + x^2 - x + 1
fq = invertmodpowerof2(f, q)
convolution(f, fq)
# output: -256*x^6 + 256*x^4 - 256*x^2 + 257

### NTRU key generation ###

def keypair():
    while True:
        try:
            f = randomdpoly()
            f3 = invertmodprime(f, 3)
            fq = invertmodpowerof2(f, q)
            break
        except:
            pass
    g = randomdpoly()
    pk = balancedmod(3 * convolution(fq, g), q)
    sk = f, f3
    return pk, sk

n = 7
d = 5
q = 256
pk, sk = keypair()
pk

f,f3 = sk
f
# output: -x^6 + x^5 - x^4 + x^2 + 1
convolution(f,pk)
# output: 256*x^6 + 3*x^5 - 3*x^3 - 3*x^2 + 253*x - 253
# balancedmod(_,q)
# output: 3*x^5 - 3*x^3 - 3*x^2 - 3*x + 3

### Messages for encryption ###

def randommessage():
    result = list(randrange(3) - 1 for j in range(n))
    return Zx(result)

n = 7
randommessage()
# output: -x^6 - x^5 + x^4
randommessage()
# output: x^6 + x^5 - x^4 - 1
randommessage()
# output: -x^4 - x^3 - x + 1
randommessage()
# output: -x^6 + x^4 - x^2 + 1

### Encryption ###

def encrypt(message, pk):
    r = randomdpoly()
    return balancedmod(convolution(pk, r) + message, q)

n = 7
d = 5
q = 256
h, sk = keypair()
h
# output: -82*x^6 + 118*x^5 - 94*x^4 + 108*x^3 + 70*x^2 - 122*x + 5
m = randommessage()
m
# output: -x^6 - x^4 + x^2 + 1
c = encrypt(m,h)
c
# output: -66*x^6 + 37*x^5 + 115*x^4 - 15*x^3 - 6*x^2 - 89*x + 27

### Decryption ###

def decrypt(ct, sk):
    f, f3 = sk
    a = balancedmod(convolution(ct, f), q)
    return balancedmod(convolution(a, f3), 3)

d = 495
n = 743
q = 2048
for tests in range(10):
    pk, sk = keypair()
    m = randommessage()
    c = encrypt(m, pk)
    print(m == decrypt(c, sk))

n = 7
d = 5
q = 256
h, sk = keypair()
h
# output: -82*x^6 + 118*x^5 - 94*x^4 + 108*x^3 + 70*x^2 - 122*x + 5
m = randommessage()
m
# output: x^6 + x^5 - x^4 - x^3 + x - 1
r = randomdpoly()
r
# output: -x^6 + x^5 + x^4 + x^3 - x^2
f = sk[0]
f
# output: -x^6 - x^5 - x^4 - x^3 - x
g3 = balancedmod(convolution(f, h), q)
g3
# output: -3*x^6 - 3*x^3 + 3*x^2 - 3*x - 3
c = balancedmod(convolution(h, r) + m, q)
c
# output: -93*x^6 - 105*x^5 - 110*x^4 - 95*x^3 - 106*x^2 - 111*x - 95
a = balancedmod(convolution(f, c), q)
a
# output: 3*x^5 - 13*x^4 - 3*x^3 + 2*x^2 - x + 3
convolution(g3, r) + convolution(f, m)
# output: 3*x^5 - 13*x^4 - 3*x^3 + 2*x^2 - x + 3
balancedmod(a, 3)
# output: -x^4 - x^2 - x
balancedmod(convolution(f, m), 3)
# output: -x^4 - x^2 - x

### An attack example with very small NTRU parameters ###

h
# output: -82*x^6 + 118*x^5 - 94*x^4 + 108*x^3 + 70*x^2 - 122*x + 5
Integers(q)(1 / 3)
# output: 171
h3 = (171 * h) % q

h3
# output: 58*x^6 + 210*x^5 + 54*x^4 + 36*x^3 + 194*x^2 + 130*x + 87
convolution(h3, x)
# output: 210*x^6 + 54*x^5 + 36*x^4 + 194*x^3 + 130*x^2 + 87*x + 58
convolution(h3, x ^ 2)
# output: 54*x^6 + 36*x^5 + 194*x^4 + 130*x^3 + 87*x^2 + 58*x + 210
convolution(h3, x ^ 3)
# output: 36*x^6 + 194*x^5 + 130*x^4 + 87*x^3 + 58*x^2 + 210*x + 54
convolution(h3, x ^ 4)
# output: 194*x^6 + 130*x^5 + 87*x^4 + 58*x^3 + 210*x^2 + 54*x + 36
convolution(h3, x ^ 5)
# output: 130*x^6 + 87*x^5 + 58*x^4 + 210*x^3 + 54*x^2 + 36*x + 194
convolution(h3, x ^ 6)
# output: 87*x^6 + 58*x^5 + 210*x^4 + 54*x^3 + 36*x^2 + 194*x + 130

M = matrix(2 * n)
for i in range(n):
    M[i, i] = q
for i in range(n, 2 * n):
    M[i, i] = 1
for i in range(n):
    for j in range(n):
        M[i + n, j] = convolution(h3, x ^ i)[j]

M
# output: [256   0   0   0   0   0   0   0   0   0   0   0   0   0]
# output: [  0 256   0   0   0   0   0   0   0   0   0   0   0   0]
# output: [  0   0 256   0   0   0   0   0   0   0   0   0   0   0]
# output: [  0   0   0 256   0   0   0   0   0   0   0   0   0   0]
# output: [  0   0   0   0 256   0   0   0   0   0   0   0   0   0]
# output: [  0   0   0   0   0 256   0   0   0   0   0   0   0   0]
# output: [  0   0   0   0   0   0 256   0   0   0   0   0   0   0]
# output: [ 87 130 194  36  54 210  58   1   0   0   0   0   0   0]
# output: [ 58  87 130 194  36  54 210   0   1   0   0   0   0   0]
# output: [210  58  87 130 194  36  54   0   0   1   0   0   0   0]
# output: [ 54 210  58  87 130 194  36   0   0   0   1   0   0   0]
# output: [ 36  54 210  58  87 130 194   0   0   0   0   1   0   0]
# output: [194  36  54 210  58  87 130   0   0   0   0   0   1   0]
# output: [130 194  36  54 210  58  87   0   0   0   0   0   0   1]

M.LLL()
# output: [ -1  -1   1  -1   1   0   0  -1   1  -1  -1   1   0   0]
# output: [  0  -1  -1   1  -1   1   0   0  -1   1  -1  -1   1   0]
# output: [  1  -1   1  -1   0   0   1  -1   1   1  -1   0   0   1]
# output: [ -1   1  -1   0   0   1   1   1   1  -1   0   0   1  -1]
# output: [  1  -1   0   0   1   1  -1   1  -1   0   0   1  -1   1]
# output: [  1   1   1   1   1   1   1   1   1   1   1   1   1   1]
# output: [  0   0   1   1  -1   1  -1   0   0   1  -1   1   1  -1]
# output: [ 39 -28  19  12  11 -48  -4  47   6 -31 -20 -19  36 -18]
# output: [ -5 -34 -14  -3   9 -39 -43  47  54  22   1 -17  19   1]
# output: [  4 -39  28 -19 -12 -11  48  18 -47  -6  31  20  19 -36]
# output: [  9 -40 -43  -5 -32 -13  -1 -17  20   1  47  54  23   3]
# output: [ -1   9 -40 -43  -5 -32 -13   3 -17  20   1  47  54  23]
# output: [ 14   3  -9  40  43   4  32 -22  -3  17 -18  -1 -48 -54]
# output: [ 28 -19 -12 -11  48   4 -39  -6  31  20  19 -36  18 -47]

M.LLL()[0][n:]
# output: (-1, 1, -1, -1, 1, 0, 0)
# Zx(list(_))
# output: x^4 - x^3 - x^2 + x - 1
f
# output: -x^4 + x^3 + x^2 - x + 1

### Automating the attack ###

def attack(publickey):
    recip3 = lift(1 / Integers(q)(3))
    pkover3 = balancedmod(recip3 * publickey, q)
    M = matrix(2 * n)
    for i in range(n):
        M[i, i] = q
    for i in range(n):
        M[i + n, i + n] = 1
        c = convolution(x ^ i, pkover3)
        for j in range(n):
            M[i + n, j] = c[j]
    M = M.LLL()
    for j in range(2 * n):
        try:
            f = Zx(list(M[j][n:]))
            f3 = invertmodprime(f, 3)
            return f, f3
        except:
            pass
    return f, f


n = 120
q = 2 ^ 32
d = 81

pk, sk = keypair()
donald = attack(pk)
print(donald[0])

try:
    m = randommessage()
    c = encrypt(m, pk)
    assert decrypt(c, donald) == m
    print('attack successfully decrypts')
except:
    print('attack was unsuccessful')

