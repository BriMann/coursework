#include <stdio.h>
#include <string.h>

int main(void)
{
  char *stringPtr = "Hello world!\n";
  int stringLen = strlen(stringPtr);
  int linesPrinted = 0;
  for (int i = 0; i < stringLen; ++i)
  {
    char *cursor = stringPtr + i;
    printf("%p %c %#04x\n", cursor, *cursor, (int)(*cursor));
    ++linesPrinted;
  }
  printf("\nNumber of lines printed: %d\n", linesPrinted);
  printf("Length of string: %d\n", stringLen);
  return 0;
}
