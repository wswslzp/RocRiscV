#include "vecadd.h"

int main()
{
    int a[5] = {0, 1, 2, 3, 4};
    int b[5] = {10, 11, 12, 13, 14};
    int c[5];
    vecadd(a, b, c, 5);
    return 0;
}