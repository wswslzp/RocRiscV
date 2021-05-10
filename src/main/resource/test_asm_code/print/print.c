#include "print.h"

void printOneChar(char c, int bias)
{
    __asm__ volatile(
        "sb %[thechar], %[iaddr](%[bi]);"
        ::[iaddr]"i"(PRINT_AREA_START), [thechar]"r"(c), [bi]"r"(bias)
    );
}

void printChars(char *s, int bias)
{
    __asm__ volatile(
        "addi t1, zero, 1;\
        sb t1, %[flag](zero);"
        ::[flag]"i"(PRINT_FLAG_ADDR):"t1"
    );
    for(int i = 0; s[i] != '\0'; i++)
    {
        _print_one_char(s[i], bias);
    }
}