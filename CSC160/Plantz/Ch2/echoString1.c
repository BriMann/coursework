/* echoString1.c
 * Echoes a string entered by user.
 * 2017-09-29: Bob Plantz
 */

#include <unistd.h>
#include <string.h>

int main(void)
{
  char aString[200];
  char *stringPtr = aString;

  write(STDOUT_FILENO, "Enter a text string: ",
        strlen("Enter a text string: "));  // prompt user

  read(STDIN_FILENO, stringPtr, 1);    // get first character
  while (*stringPtr != '\n')           // look for end of line
  {
    stringPtr++;                       // move to next location
    read(STDIN_FILENO, stringPtr, 1);  // get next character
  }

  // now echo for user
  write(STDOUT_FILENO, "You entered:\n",
        strlen("You entered:\n"));
  stringPtr = aString;
  do
  {
    write(STDOUT_FILENO, stringPtr, 1);
    stringPtr++;
  } while (*stringPtr != '\n');
  write(STDOUT_FILENO, stringPtr, 1);

  return 0;
}