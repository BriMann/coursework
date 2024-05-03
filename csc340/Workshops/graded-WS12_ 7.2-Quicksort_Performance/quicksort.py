#Brian Mann
#4/5/2022

# This program takes an array splits the array based on the element that is exhcanged with the final
# element in the array by the end of the for loop in partition, then it recursively searches through and exchanges these elements in quicksort. Sorting the elements within itself unitl it is fully sorted.

sentinel = -1000

def partition(A,p,r):
    x = A[r]
    i = p - 1
    for j in range(p, r):
        if A[j] <= x:
            i = i + 1
            k = A[i]
            A[i] = A[j]
            A[j] = k
    l = A[i+1]
    A[i+1] = A[r]
    A[r] = l
    return i + 1

def quicksort(A,p,r):
    if p < r:
        q = partition(A,p,r)
        quicksort(A,p,q-1)
        quicksort(A,q+1,r)
        
def print_one_based(v):
    array = []
    for i in v:
        if i >= 0:
            array.append(i)
    print(array)
    
def main():
    A = [sentinel, 13, 19, 9, 5, 12, 8, 7, 4, 21, 2, 6, 11]
    print_one_based(A)
    quicksort(A, 0 , len(A)-1)
    print_one_based(A)
    
    print("\n***** Test Code ****\n")
    
    B = [-1000, 51,69,70,88,35,89,42,59,93,51,43,80,83,48,6]
    print("One-based array B = ", end ='')
    print_one_based(B)
    
    quicksort(B,1,len(B)-1)
    print("\nAfter quicksort array B = ", end ='')
    print_one_based(B)
    
main()