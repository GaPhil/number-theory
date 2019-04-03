/**
* Created by GaPhil on 2019-04-03.
*/

// recursive euclidean algorithm
int gcd(int a, int b) {
    if (b == 0)
        return a;
    return gcd(b, a % b);
}
