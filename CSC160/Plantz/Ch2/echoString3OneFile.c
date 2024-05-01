/* echoString3.c
 * Echoes a string entered by user.
 * 2017-09-29: Bob Plantz
 */

#include <unistd.h>
#define STRLEN 200     // limited to 5 for testing readStr
                     // change to 200 for use

int writeStr(char *stringAddr)
{
  int count = 0;

  while (*stringAddr != '\0')
  {
    write(STDOUT_FILENO, stringAddr, 1);
    count++;
    stringAddr++;
  }

  return count;
}

int readLn(char *stringAddr, int maxLength)
{
  int count = 0;
  maxLength--;          // allow space for NUL
  read(STDIN_FILENO, stringAddr, 1);
  while (*stringAddr != '\n')
  {
    if (count < maxLength)
    {
      count++;
      stringAddr++;
    }
    read(STDIN_FILENO, stringAddr, 1);
  }
  *stringAddr = '\0';   // terminate C string

  return count;
}

int main(void)
{
  char aString[STRLEN];
  writeStr("Enter a text string: ");
  readLn(aString, STRLEN);
  writeStr("You entered:\n");
  writeStr(aString);
  writeStr("\n");

  return 0;
}