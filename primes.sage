# Generates n-bit prime and fails with negligible probability
def gen_prime(n):
    # bound follows from prime number theorem and that for all x>=1, (1-1/x)^x<=e^-1
    for _ in range(3 * n ^ 2):
        # outputs integer of exactly n bits, not at most n bits.
        pp = Words(alphabet='01', length=n - 1).random_element()
        p = str(1) + str(pp)
        if is_prime(int(p, 2)):
            return int(p, 2)
    raise Exception("prime generation failed")
