/**
* Created by GaPhil on 2019-04-02.
*/

#include <stdio.h>
#include <math.h>
#include <stdbool.h>

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

int main() {
    int n;
    printf("Enter a number to check if it's prime: ");
    scanf("%d", &n);
    int x = is_prime(n);
    printf(x ? "true\n" : "false\n");
    return 0;
}

