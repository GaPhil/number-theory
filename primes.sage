# Generates n-bit prime and fails with negligible probability
def gen_prime(n):
    # bound follows from prime number theorem and that for all x>=1, (1-1/x)^x<=e^-1
    for _ in range(3 * n ^ 2):
        # outputs integer of exactly n bits, not at most n bits.
        pp = Words(alphabet='01', length=n - 1).random_element()
        p = str(1) + str(pp)
        if is_prime(int(p, 2)):
            return int(p, 2)
    # all 3n^2 bit strings were not prime
    raise Exception("prime generation failed")


# Generates n-bit strong prime p=2q+1, with q also prime
def gen_strong_prime(n):
    while true:
        # gen_prime() fails with negligible probability
        q = gen_prime(n - 1)
        p = 2 * q + 1
        if is_prime(p):
            return p


# Generates n-bit composite Carmichael number
def gen_carmichael_num(n):
    # arbitrary bound
    for _ in range(n ^ 4):
        # outputs integer of exactly n bits, not at most n bits.
        NN = Words(alphabet='01', length=n - 1).random_element()
        N = Integer(int(str(1) + str(NN), 2))
        # must be odd and composite
        if N % 2 == 1 and not is_prime(N):
            ZN_mult = N.coprime_integers(N)
            # must satisfy Fermat's little theorem for all a with gca(a,n)=1
            if all(a ^ (N - 1) % N == 1 for a in ZN_mult):
                return N
    raise Exception("failed to generate carmichael number")
