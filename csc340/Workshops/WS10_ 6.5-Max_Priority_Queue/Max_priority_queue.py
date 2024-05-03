sentinel = -10000

def parent(i):
    return i//2

def left(i):
    return 2*(i)

def right(i):
    return 2*(i) + 1

def max_heapify(A, i, n):
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
        temp = A[i]
        A[i] = A[largest]
        A[largest] = temp
        max_heapify(A, largest, n);

def build_max_heap(A,n):
    for i in range((n//2 + 1), 0, -1):
        max_heapify(A,i,n)

def print_heap(v):
    heap = []
    for i in v:
        if i >= 0:
            heap.append(i)
    print(heap)

def heap_maximum(A):
    return A[1]

def heap_extract_max(A,n):
    if n < 1:
        raise Exception("heap underflow")
        return none
    maxi = A[1]
    A[1] = A[n]
    n = n - 1
    max_heapify(A, 1, n)
    A.pop(-1)
    return maxi

def heap_increase_key(A,i,key):
    if key < A[i]:
        raise Exception("new key is smaller than current key")
        return none
    A[i] = key
    while i > 1 and A[parent(i)] < A[i]:
        k = A[i]
        A[i] = A[parent(i)]
        A[parent(i)] = k
        i = parent(i)
        
def max_heap_insert(A, key, n):
    n = n + 1
    A.append(sentinel)
    heap_increase_key(A,n,key)
    
def main():
    heap_A = [sentinel, 15, 13, 9, 5, 12, 8, 7, 4, 0, 6, 2, 1]
    heap_extract_max(heap_A,len(heap_A)-1)
    print_heap(heap_A)
    heap_B = [sentinel, 15, 13, 9, 5, 12, 8, 7, 4, 0, 6, 2, 1]
    heap_increase_key(heap_B, 9, 14)
    print_heap(heap_B)
    heap_C = [sentinel, 15, 13, 9, 5, 12, 8, 7, 4, 0, 6, 2, 1]
    max_heap_insert(heap_C, 10, len(heap_C)-1)
    print_heap(heap_C)
main()