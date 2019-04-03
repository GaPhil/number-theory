/**
* Created by GaPhil on 2019-04-03.
*/

#include <stdlib.h>
#include <math.h>

// returns an integer as a binary array
int *int_to_bin_array(unsigned int number, int *bits, int length) {
    unsigned int mask = 1U << (length - 1);
    for (int i = 0; i < length; i++) {
        bits[i] = (number & mask) ? 1 : 0;
        number <<= 1;
    }
    return bits;
}

// naive modular exponentiation
// complexity: O(e) multiplications
int mod_exp1(int a, int e, int n) {
    int d = 1;
    for (int i = 0; i < e; i++)
        d = (d * a) % n;
    return d;
}

// efficient modular exponentiation
int mod_exp2(int a, int e, int n) {
    int d = 1;
    int *e_digits = malloc(((int) log2(e) + 1) * sizeof(int *));
    int k = log2(e) + 1;
    e_digits = int_to_bin_array(e, e_digits, k);
    for (int i = 0; i < k; i++) {
        d = d * d % n;
        if (e_digits[i] == 1)
            d = d * a % n;
    }
    return d;
}
