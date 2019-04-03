/**
* Created by GaPhil on 2019-04-02.
*/

#include <stdio.h>
#include <math.h>
#include <stdbool.h>

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

int mod_exp(int a, int e, int n) {
    int d = 1;
    for (int i = 0; i < e; i++)
        d = (d * a) % n;
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
    printf("%d ^ %d mod %d = %d\n\n", a, e, n, mod_exp(a, e, n));


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

