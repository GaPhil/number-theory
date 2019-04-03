/**
* Created by GaPhil on 2019-04-02.
*/

#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <stdbool.h>

// returns an integer as a binary array
int *int_to_bin_array(unsigned int number, int *bits, int length) {
    unsigned int mask = 1U << (length - 1);
    for (int i = 0; i < length; i++) {
        bits[i] = (number & mask) ? 1 : 0;
        number <<= 1;
    }
    return bits;
}

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

// recursive euclidean algorithm
int gcd(int a, int b) {
    if (b == 0)
        return a;
    return gcd(b, a % b);
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

int main() {
    int a, e, n;
    printf("### Modular exponentiation ###\n");
    printf("Enter a base number: ");
    scanf("%d", &a);
    printf("Enter the exponent: ");
    scanf("%d", &e);
    printf("Enter the modulus: ");
    scanf("%d", &n);
    printf("Using method 1: %d ^ %d mod %d = %d\n", a, e, n, mod_exp1(a, e, n));
    printf("Using method 2: %d ^ %d mod %d = %d\n\n", a, e, n, mod_exp2(a, e, n));


    int b;
    printf("### Greatest common divisor ###\n");
    printf("Enter two numbers to find their greatest common divisor: ");
    scanf("%d %d", &a, &b);
    printf("GCD of %d and %d: %d\n\n", a, b, gcd(a, b));

    printf("### Primality test ###\n");
    printf("Enter a number to check if it's prime: ");
    scanf("%d", &n);
    int x = is_prime(n);
    printf(x ? "true\n" : "false\n");
    return 0;
}
