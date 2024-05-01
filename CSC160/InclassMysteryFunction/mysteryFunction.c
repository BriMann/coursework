#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

/* Function mystery() returns an integer computed from the value of the parameter n.
 * If n is even, mystery(n) is n / 2. If odd, mystery(n) is 3n + 1.
 * Precondition: n is positive.
 * Postcondition: The mystery value as described above is the function return value.
 */

int mystery(int n)
{
  int result;
  if (n % 2 == 0)
  {
    result = n / 2;
  }
  else
  {
    result = 3 * n + 1;
  }

  return result;
}

/* In the main program, we choose a random starting value between 1 and 1000
 * and repeatedly apply the mystery() function above to generate a sequence
 * of values that is printed to the output. The process stops when the mystery
 * value is 1.
 */

int main(void)
{
  srand(time(NULL));
  
  /* ****** VARIABLE DECLARATIONS ****** */
  int starting_value = 1 + rand() % 1000; /* 1 to 1000 inclusive */
  int current_value = starting_value;
  int sequence_length = 1;
  
  printf("Sequence of mystery values: ");
  /* generate a sequence by repeatedly applying mystery() to starting_value */
  while (current_value != 1)
  {
    printf("%d ", current_value);
    current_value = mystery(current_value);
    sequence_length += 1;
  }
  printf("1 \n");

  return 0;
}