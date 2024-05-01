/* oneChar.c
 * Writes a single character on the screen.
 * 2017-09-29: Bob Plantz
 */

#include <unistd.h>

int main(void)
{
  char aLetter = 'A';
  write(STDOUT_FILENO, &aLetter, 1); // STDOUT_FILENO is
                                     // defined in unistd.h
  return 0;
}