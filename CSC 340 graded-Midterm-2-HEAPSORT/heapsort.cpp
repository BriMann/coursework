// CSC-340 Midterm (2) CoCalc Portion
// EDIT ME: your name here
// This program ...EDIT ME with a description of the program
// Only add code to implement heapsort as indicated below.  ****DO NOT delete or modify existing code.****

#include <iostream>
#include <vector>

using namespace std;

/*
* print_vector(v)
*  takes integer vector v as a const reference parameter
*  Prints the contents of vector v.
*  v is not modified
*/
void print_vector(const vector<int>& vec) {
  cout << "{";
  int len = vec.size();
  if (len > 0) {
    for (int i = 0; i < len - 1; i++)
      cout << vec[i] << ","; // Comma after elements
    cout << vec[len - 1]; // No comma after last element
  }
  cout << "}\n";
}

/*
* print_heap(v)
*  takes integer vector v as a const reference parameter
*  Prints the contents of vector v AFTER the initial unused position
*  v is not modified
*/
void print_heap(const vector<int>& vec) {
  cout << "<";
  int len = vec.size();
  if (len > 0) {
    for (int i = 1; i < len-1; i++)
      cout << vec[i] << ","; // Comma after elements
    cout << vec[len-1]; // No comma after last element
  }
  cout << ">\n";
}


/* parent(i)
*  return the index of the parent of node i
*/
int parent( int i)
{
  return i/2;
}

/* left(i)
*  return the index of the left child of node i
*/
int left(int i)
{
  return 2*i;
}

/* (i)right
*  return the index of the right child of node i
*/
int right(int i)
{
  return 2*i + 1;
}

/*
* max_heapify(A, i, n)
* Takes a heap/vector A[1..n] of size n and an index i into the array
*  MAX-HEAPIFY assumes that the binary trees rooted at LEFT[i] RIGHT[i] are max-heaps, 
*  but that A[i] might be smaller than its children, thus violating the max-heap property. 
*  MAX-HEAPIFY lets the value at A[i] “ﬂoat down” in the max-heap so that the subtree 
*   rooted at index i obeys the max-heap property
* A is modified
*/
void max_heapify(vector<int>& A, int i, int n)
{
  int l = left(i);
  int r = right(i);
  int largest; // the index of the largest of A[i] and LEFT[i] and RIGHT[i]
  if (l <= n && A[l] > A[i])
    largest = l;
  else
    largest = i;
  if (r <= n && A[r] > A[largest])
    largest = r;
  if (largest != i)
  {
    int temp = A[i];
    A[i] = A[largest];
    A[largest] = temp;
    max_heapify(A, largest, n);
  }
}

/*
* build_max_heap(A, n)
* Takes an unordered vector A[1..n] of size n and produces a max-heap
* A is modified
*/
void build_max_heap(vector<int>& A, int n)
{
  for (int i = n/2; i >= 1; i--)
  {
    max_heapify(A, i, n);
  }
}

/*
*  heapsort(A,n)
*  Takes an unordered vector A[1..n] and returns A in sorted order
* A is modified
*/

/*****************Add the missing code for the heapsort psuedocode BELOW






/*****************Add the missing code for the heapsort psuedocode ABOVE

/*
* main()
*   Demonstrate max_heapify(A, 1, 10), build-max-heap(A,n), and heapsort(A,n)
*/


int main()
{
  int sentinel = -1000
  vector<int> A{sentinel, 16, 4, 10, 14, 7, 9, 3, 2, 8, 1}; //declare a vector that holds those values
  
  cout << "Run max-heapify on vector: A = ";
  print_vector(A);
  cout << "Heap A = ";
  print_heap(A);
  cout << endl;
  
  max_heapify(A, 2, 10);
    
  cout << "After max-heapify on: A = ";
  print_vector(A);
  cout << "Heap A = ";
  print_heap(A);
  cout << endl;
  
  vector<int> B{sentinel, 5, 13, 2, 25, 7, 17, 20, 8, 4}; //declare a vector that holds those value
  cout << "Consider array: B = ";
  print_vector(B);
  cout << "Heap B = ";
  print_heap(B);
  cout << endl;
   
  heapsort(B,B.size()-1);
  
  cout << "After heapsort: B = ";
  print_vector(B);
  cout << "Heap B = ";
  print_heap(B);
  cout << endl;

  return 0;
}