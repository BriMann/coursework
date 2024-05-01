#include <stdio.h>

int main(void)
{
  const char prompt[] = "Enter your name: ";
  const char* greeting = "Hello, %s!\n";
  char name[80];
  printf(prompt);
  scanf("%s79", name);
  printf(greeting, name);
  return 0;
}