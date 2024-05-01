#include <stdio.h>
#include <limits.h>

int main(void)
{
    printf("Width of short: %d bytes\n", sizeof(short));
    printf("Width of int: %d bytes\n", sizeof(int));
    printf("Width of long: %d bytes\n", sizeof(long));
    printf("Width of long long: %d bytes\n\n", sizeof(long long));

    printf("Width of unsigned short: %d bytes\n", sizeof(unsigned short));
    printf("Width of unsigned int: %d bytes\n", sizeof(unsigned int));
    printf("Width of unsigned long: %d bytes\n", sizeof(unsigned long));
    printf("Width of unsigned long long: %d bytes\n\n", sizeof(unsigned long long));

    printf("Width of unsigned char: %d bytes\n", sizeof(unsigned char));
    printf("Width of signed char: %d bytes\n", sizeof(char));

    printf("The char type has size %x bits.\n", CHAR_BIT);
    printf("Just so you believe me, that's the same as %d byte.\n", sizeof(char));


}
