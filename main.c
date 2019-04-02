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
    for (int i = 3; i <= sqrt(n); i++) {
        if (n % i == 0) return false;
    }
    return true;
}

int gcd(int a, int b) {
    if (b == 0) return a;
    return gcd(b, a % b);
}

int main() {
    int a = 5;
    int b = 7;
    printf("Enter two numbers to find their greatest common divisor: ");
    scanf("%d %d", &a, &b);
    printf("GCD of %d and %d: %d\n", a, b, gcd(a, b));

    int n;
    printf("\nEnter a number to check if it's prime: ");
    scanf("%d", &n);
    int x = is_prime(n);
    printf(x ? "true\n" : "false\n");
    return 0;
}

