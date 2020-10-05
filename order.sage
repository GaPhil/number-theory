# MidnightSun CTF 2020 Final
# Order of the eternal pwny


# Steps to solve:
#    1. Observe that the order of the elliptic curve is NOT prime. This makes the discrete log problem tractable.
#    2. Recover the secret key using generator point and public key point.
#    3. Implement the ECDSA algorithm with the given curve parameters.
#    4. Observe that since the order of the curve is NOT prime, some elements do not have an inverse.
#    5. Run ECDSA a few times until it succeeds. It fails when the randomly generated elements do not have an inverse.


import hashlib

# Our curve is:
# y^2 = x^3 + ax + b  (mod p)
# with
a = 0
b = 7
p = 13407807929942597099574024998205846127479365820592393377723561443721764030073546976801874298166903427690031858186486050853753882811946569946433649006083467

# The order of the curve is:
N = 13407807929942597099574024998205846127479365820592393377723561443721764030073546976801874298166903427690031858186486050853753882811946569946433649006083468

# The generator point is:
x_gen = 4799285190862774334554257686930257844071537261014073760156058617737842462282386332050868291388345531499639223035535266781076961097511513190124595225938322
y_gen = 13108304141201994251267238176276698610347984424268792817370787229323646748396454545518712028101491416275123251855404084486544733487707694240866799238161207

# Your public key is:
x_pub = 12310075201967331294494708362564372516633875295338132809530728749822363481428626492641045765322013984359506511932410317718159162992206318112760069293039855
y_pub = 1460325415480595314635644758632997061079712099603991872162556572146053321246969213691747227111633271616079650735485099741276772042549176799101790393147291

# HERE COMES THE CODE

F = GF(p)  # finite field of size p
Ecurve = EllipticCurve(F, [a, b])  # elliptic Curve defined by y^2 = x^3 + 7
# over Finite Field of size p
P = Ecurve(x_gen, y_gen)  # generator point on curve
Q = Ecurve(x_pub, y_pub)  # public key point on curve

# The order is NOT prime!
is_prime(Ecurve.order())

# Here are the prime factors
prime_factors(N)

# Here is the Secret key
d = P.discrete_log(Q)


# ECDSA implementation
def ecdsa_sign(challenge):
    m = hashlib.sha512(str(challenge).encode('utf-8')).hexdigest()
    r = 0;
    s = 0;
    l_n = 512;
    while s == 0:
        k = 1
        while r == 0:
            k = randint(1, N - 1)  # this k might not have inverse
            PP = k * P  # since the order (N) is not prime
            (x_1, y_1) = PP.xy()
            r = Mod(x_1, N)
        z = Integer('0x' + m)
        inv_k = inverse_mod(k, N)
        s = inv_k * (z + r * d)
        s = Mod(s, N)
    return [r, s]


# Insert challenge string to sign below.
# Call function until it succeeds.
# Might fail with error: "inverse of Mod(xxx, yyy) does not exist".
ecdsa_sign("")

# Here the result:

# Please sign this challenge: Whi3KEgaczHqMKdi4ubQBKuBZl/WzrHcP6SxElVEv6s=
# (Don't decode it, just use its ASCII bytes as the signed data)

ecdsa_sign("Whi3KEgaczHqMKdi4ubQBKuBZl/WzrHcP6SxElVEv6s=")

# Signature r in base 10: 4799285190862774334554257686930257844071537261014073760156058617737842462282386332050868291388345531499639223035535266781076961097511513190124595225938322
# Signature s in base 10: 11876246714968603958188488429463463612529490225343376524344368779009310877894962381191051642521819332138975957699288478021108295740458681633261805698390386


# Welcome, devoted one! Always remember our secret greeting:
# midnight{o0ps_t0o_m4ny_pr1m3_facto25}
