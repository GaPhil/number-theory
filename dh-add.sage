# The Diffie-Hellman key exchange can be broken trivially in (Z/nZ; +)!
print("The Diffie-Hellman key exchange can be broken trivially in (Z/nZ; +)!")

n = 2^1024
print("n = 2^1024\n")

G = AdditiveAbelianGroup([n])

# find a generator 1 < g \in (Z/nZ; +)
for g in range(2, G.order()):
    if gcd(g, G.order()) == 1:
        print("The publicly known generator is:\ng =", g, "\n")
        break

x_a = ZZ.random_element(0, n - 1)
print("Alice chooses x_a from {0,...,n-1}:\nx_a =", x_a, "\n")

A = g * x_a % n
print("Alice sends A = R_n(g * x_a):\nA =", A, "\n")

x_b = ZZ.random_element(0, n - 1)
print("Bob chooses x_b from {0,...,n-1}:\nx_b =", x_b, "\n")

B = g * x_b % n
print("Bob sends B = R_n(g * x_b):\nB =", B, "\n")

print("The shared key k_AB = R_n(g * x_a * x_b):\nk_AB =", g * x_a * x_b % n, "\n")

a = inverse_mod(g, n)
print("g is a generator of (Z/nZ; +) ===> gcd(g, n) = 1")
print("Eve can use the extended euclidean algorithm to find an\na \\in Z : a * g \\cong 1 mod n:\na =", a, "\n")

print("Even can compute the key k using the eavesdropped message A and B.")
print("k_Eve = R_n(a * A * B)\nk_Eve =", a * A * B % n, "\n")

print("Claim:\tk_AB = R_n(a * A * B)\n")
print("Proof:\tk_AB = R_n(g * x_A * x_b)\n\t     = R_n(g * x_a * (a*g) * x_B)\n\t     = R_n(a * (g*x_a) * (g*x_b))\n\t     = R_n(a * A * B)\n")
print("k_AB == k_Eve:", g * x_a * x_b % n == a * A * B % n)