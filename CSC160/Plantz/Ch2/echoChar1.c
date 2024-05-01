/* echoChar1.c
 * Echoes a character entered by the user.
 * 2017-09-29: Bob Plantz
 */

#include <unistd.h>
#include <string.h>

int main(void)
{
  char aLetter;

  char prompt[] = "Enter one character: ";

  write(STDOUT_FILENO, prompt, sizeof(prompt) - 1);         // prompt user
  read(STDIN_FILENO, &aLetter, 1);                   // one character
  write(STDOUT_FILENO, "You entered: ", 13);         // message
  write(STDOUT_FILENO, &aLetter, 1);                 // echo character
  fflush(STDIN_FILENO);

  return 0;
}