#ifndef __PRINT_H__
#define __PRINT_H__

#define PRINT_AREA_START 0x00000110
#define PRINT_FLAG_ADDR 0x00000111

//TODO: invent a new print string method.
#define _print_one_char(c, bias) \
__asm__ volatile( \
    "sb %[thechar], %[iaddr](%[bi]);" \
    ::[iaddr]"i"(PRINT_AREA_START), [thechar]"r"(c), [bi]"r"(bias))

void printOneChar(char c, int bias);
void printChars(char *s, int bias);

#endif
