/**
* Created by GaPhil on 2020-01-24.
*/

#include <iostream>
#include <math.h>

using namespace std;

// find the generators of the multiplicative group modulo n
int main() {
    int n = 19;
    uint32_t tmp;
    for (int g = 1; g < n; ++g) {
        cout << "g=" << g << ": ";
        uint32_t val[19] = {0};
        for (int i = 1; i < n; ++i) {
            tmp = (uint32_t) pow(g, i) % n;
            if (find(begin(val), end(val), tmp) != end(val)) break;
            val[i] = tmp;
            cout << val[i] << ", ";
            if (i == n - 1)
                cout << "\t" << g << " is a GENERATOR";
        }
        cout << endl;
    }
    return 0;
}
