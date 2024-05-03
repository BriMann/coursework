''' CSC-340 Midterm (2) CoCalc Portion
// EDIT ME: your name here
// This program ...EDIT ME with a description of the program
// Only add code to implement heapsort as indicated below.  ****DO NOT delete or modify existing code.****
'''
sentinel = -1000

def print_heap(v):
    '''takes integer list v, Prints the contents of vector v AFTER the initial unused position and v is not modified'''
    length = len(v)
    if length > 0:
        heap = v[1:]
        print(heap)
        
def parent(i):
    '''return the index of the parent of node i'''
    return i//2

def left(i):
    '''return the index of the left child of node i'''
    return 2*i

def right(i):
    '''return the index of the right child of node i'''
    return 2*i + 1

def max_heapify(A,i,n):
    '''Takes a heap/vector(list) A[1..n] of size n and an index i into the array
    MAX-HEAPIFY assumes that the binary trees rooted at LEFT[i] RIGHT[i] are max-heaps, 
    but that A[i] might be smaller than its children, thus violating the max-heap property.
    MAX-HEAPIFY lets the value at A[i] “ﬂoat down” in the max-heap so that the subtree 
    rooted at index i obeys the max-heap property
    A is modified'''
    l = left(i)
    r = right(i)
    largest = sentinel
    if (l <= n and A[l] > A[i]):
        largest = l
    else:
        largest = i
    if (r <= n and A[r] > A[largest]):
        largest = r
    if (largest != i):
        #swap A[i] and largest child
        temp = A[i]
        A[i] = A[largest]
        A[largest] = temp
        max_heapify(A, largest, n);
    
def build_max_heap(A,n):
    '''Takes an unordered vector(list) A[1..n] of size n and produces a max-hea
    A is modified'''
    for i in range(n//2, 0, -1):
        max_heapify(A,i,n)
    
    
''''
*  heapsort(A,n)
*  Takes an unordered vector A[1..n] and returns A in sorted order
* A is modified
'''

#*****************Add the missing code for the heapsort psuedocode BELOW
def heapsort(A,n):
    build_max_heap(A,n)
    for i in range(n, 1, -1):
        j = A[i]
        A[i] = A[1]
        A[1] = j
        max_heapify(A,1,i-1)





#*****************Add the missing code for the heapsort psuedocode ABOVE
        
def main():
    '''Demonstrate max_heapify(A, 2, 10) and build-max-heap(A,n), and heapsort(A,n)'''
    A = [sentinel,16, 4, 10, 14, 7, 9, 3, 2, 8, 1]
    print("Run max-heapify on vector: A =", A)
    print("Heap A = ", end = "")
    print_heap(A)
    
    max_heapify(A, 2, 10)
    
    print("\nAfter max-heapify: A =", A)
    print("Heap A = ", end = "")
    print_heap(A)
    
    B = [sentinel, 5, 13, 2, 25, 7, 17, 20, 8, 4]
    print("\nConsider array: B =", B)
    print("Heap B = ", end = "")
    print_heap(B)
    
    heapsort(B, len(B)-1)
    
    print("\nAfter heapsort: B =", B)
    print("Heap B = ", end = "")
    print_heap(B)
    
main()