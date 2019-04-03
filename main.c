/**
* Created by GaPhil on 2019-04-02.
*/

#include <stdio.h>
#include <stdbool.h>
#include "gcd.h"
#include "modexp.h"
#include "prime.h"

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
    int y = is_prime_fermat(n);
    printf(x ? "Using method 1: %d is prime\n" : "Using method 1: %d is NOT prime\n", n);
    printf(y ? "Using method 2: %d is prime\n" : "Using method 2: %d is NOT prime\n", n);

    return 0;
}
