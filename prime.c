/**
* Created by GaPhil on 2019-04-03.
*/

#include <stdbool.h>
#include <math.h>
#include "modexp.h"

// complexity: O(sqrt(n))
bool is_prime(int n) {
    if (n == 1)
        return false;
    if (n == 2)
        return true;
    if (n % 2 == 0)
        return false;
    for (int i = 3; i <= sqrt(n); i++)
        if (n % i == 0)
            return false;
    return true;
}


// fermat's theorem: if p is a prime and a is an integer
// such that a does not divide n then a^(p-1) = 1 mod p.
bool is_prime_fermat(int n) {
    int k = mod_exp2(2, n - 1, n);
    if (k != 1 % n)
        return false;
    return true;
}
