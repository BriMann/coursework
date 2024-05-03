def parent(i):
    return i//2

def LEFT(i):
    return 2*(i)

def RIGHT(i):
    return 2*(i) + 1

def MAX_HEAPIFY(A, i, n):
    l = LEFT(i)
    r = RIGHT(i)
    if l<=n and A[l] > A[i]:
        largest = l
    else:
        largest = i
    if r<=n and A[r] > A[largest]:
        largest = r
    if largest != i:
        j = A[i]
        A[i] = A[largest]
        A[largest] = j
        MAX_HEAPIFY(A, largest, n)
        
def BUILD_MAX_HEAP(A,n):
    for i in range((n//2 + 1), 0, -1):
        MAX_HEAPIFY(A,i,n)

def print_heap(v):
    heap = []
    for i in v:
        if i >= 0:
            heap.append(i)
    print(heap)
    
        
def main():
    A = [-1000, 16, 4, 10, 14,7, 9, 3, 2, 8, 1]
    MAX_HEAPIFY(A, 2, 10)
    print_heap(A)
    B = [-1000, 4, 1, 3, 2, 16, 9, 10, 14, 8, 7]
    BUILD_MAX_HEAP(B, len(B)-1)
    print_heap(B)
        
main()
