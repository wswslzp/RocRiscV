#define ARRAY_START_ADDR 0x0110

int main()
{
    long long int *a = (long long int*)(ARRAY_START_ADDR);
    long long int b = *a;
    *a = 0xfaceface;
    return 0;
}