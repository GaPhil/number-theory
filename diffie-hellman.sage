g = 2
p = ""
A = ""
B = ""

@cached_function
def trial_div(x, b):
    d = x.trial_division(start=b)
    i = x.valuation(d)
    return d, i


def trial_factor(n, threshold):
    m = Integer(n)
    d = 1
    factors = []
    while len(factors) < threshold:
        d, i = trial_div(m, d + 1)
        m = m // d ^ i
        factors.append(d ** i)
    print("The first", threshold, "factors of p-1 are: ", factors)
    return factors

# Find first 15 factors of p - 1
factor_list = trial_factor(p - 1, 15)

# Determine the value k such that A^{(p-1)/r}^k = g^{(p-1)/r} mod p
# Basically a discrete log problem over a subgroup of order r -> takes ~20 min
residue_list = []
for f in factor_list:
    # if f == 3682787: break
    ff = g.powermod((p - 1) / f, p)
    Af = A.powermod((p - 1) / f, p)
    for k in range(f):
        if Af.powermod(k, p) == ff:
            residue = inverse_mod(k, f)
            print("a =", residue, "mod", f)
            residue_list.append(residue)
            break
factor_list = factor_list[1:-(len(factor_list) - len(residue_list) - 1)]

# Resize factor list, when using pre-computed residue_list - uncomment to save time!
# residue_list = [20, 10, 2, 206, 22661, 355632, 295679, 1354571, 1334854, 4874497, 2432971, 2744217, 7270078, 10156472]
# factor_list = factor_list[1:]

if len(factor_list) != len(residue_list):
    print("FAILED: factor_list != residue_list!")
    print(factor_list, len(factor_list))
    print(residue_list, len(residue_list))
else:
    # Compute Alice's public key 'a' using the CRT
    a = CRT_list(residue_list, factor_list)
    print("Using the CRT:\na =", a)

    if g.powermod(a, p) == A:
        print("FOUND IT!")
        print("Alice a =", a)
        print("Shared key z =", B.powermod(a, p))
    else:
        print("FAILED: CRT.")

