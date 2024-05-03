// The rod cutting problem.
// Written in class on March 29-31, 2017.
// Recall: In terminal window: c++ filename.cpp, ./a.out

#include <iostream>
#include <iomanip>
#include <vector>

using namespace std;

///////////////////
// Rod Cut Class //
///////////////////

class RodCut
{
private:
  static const int FLAG = -999;
  vector<int> price, memoization, breadcrumbs;
  int function_call_counter;

public:
  RodCut(int p[], int n) : price(n+1), memoization(n+1), breadcrumbs(n+1)
  {
    price[0] = 0;
    memoization[0] = 0;

    for (int i = 0; i < n; i++)
    {
      price[i+1] = p[i];
      memoization[i+1] = FLAG;
    }
  }

  int get_function_call_counter() const
  {
    return function_call_counter;
  }
   
  void reset()
  {
    function_call_counter = 0;

    for (int i = 0; i < memoization.size() - 1; i++)
    {
      memoization[i+1] = FLAG;
    }
    
  }

  void display_breadcrumbs()
  {
    cout << "breadcrumbs:" << endl;

    for (int i = 0; i < breadcrumbs.size(); i++)
    {
      cout << i << ": " << breadcrumbs[i] << endl;
    }
  }

  int naive_recursion(int length)
  {
    function_call_counter++;

    if (length == 0) return 0;

    int maximum = 0;

    for (int i = 1; i <= length; i++)
      maximum = max(maximum, price[i] + naive_recursion(length - i));

    return maximum;
  }

  int recursion_with_memoization(int length)
  {
    function_call_counter++;

    if (memoization[length] != FLAG) return memoization[length];

    int maximum = 0;

    for (int i = 1; i <= length; i++)
      maximum = max(maximum, price[i] + recursion_with_memoization(length - i));

    memoization[length] = maximum;
    return maximum;
  }

  int bottom_up(int length)
  {
    vector<int> maximum_values(length+1);

    maximum_values[0] = 0;

    for (int j = 1; j <= length; j++)
    {
      int maximum = 0;
      for (int i = 1; i <= j; i++)
      {
        int revenue = price[i] + maximum_values[j - i];
        if (revenue > maximum)
        {
          maximum = revenue;
          breadcrumbs[j] = i;
        }
      }
      maximum_values[j] = maximum;
    }
    return maximum_values[length];
  }

  void follow_breadcrumbs(int length)
  {
    while (length > 0)
    {
      cout << ' ' << breadcrumbs[length];
      length -= breadcrumbs[length];
    }
    cout << endl;
  }
};

//////////////////
// Main Program //
//////////////////

int main()
{
  const int LENGTH = 10;
  int p[LENGTH] = {1, 5, 8, 9, 10, 17, 17, 20, 24, 30};

  RodCut rod_cut(p, LENGTH);

  cout << endl << "Using the naive recursive method:" << endl << endl;

  for (int i = 0; i <= LENGTH; i++)
  {
    rod_cut.reset();
    cout << setw(2) << i << ": " << setw(2) << rod_cut.naive_recursion(i);
    cout << " function_call_counter = " << rod_cut.get_function_call_counter()
         << endl;
  }

  cout << endl << "Using recursion with memoization:" << endl << endl;

  for (int i = 0; i <= LENGTH; i++)
  {
    rod_cut.reset();
    cout << setw(2) << i << ": " << setw(2) 
         << rod_cut.recursion_with_memoization(i);
    cout << " function_call_counter = " << rod_cut.get_function_call_counter()
         << endl;
  }

  cout << endl << "Using the bottom up method:" << endl << endl;

  for (int i = 0; i <= LENGTH; i++)
  {
    cout << "Length " << setw(2) << i << ": " << setw(2) 
         << "maximum revenue is " << setw(2) << rod_cut.bottom_up(i) 
         <<  " using piece sizes:";
    rod_cut.follow_breadcrumbs(i);
  }

//  rod_cut.display_breadcrumbs();

  return 0;
}