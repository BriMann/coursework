#Brian Mann
#CSC-340

import math

def Merge(A, p, q, r):
    sentinel = 10000000
    n1 =(q - p + 1)
    n2 = (r - q )
    L = []
    R = []
    for i in range(n1):
        L.append(A[(p+i)])
    for j in range(n2):
        R.append(A[q+j+1])
    L.append(sentinel)
    R.append(sentinel)
    print(L)
    print(R)
    print(p, q, r)
    i = 0
    j = 0
    for k in range(p, r+1):
        if L[i] <= R[j]:
            A[k] = (L[i])
            print(A[k])
            i = i + 1
        else:
            A[k] = (R[j])
            print(A[k])
            j = j + 1


def Merge_Sort(A, p, r):
    if p < r:
        q = math.floor((p + r)/2)
        Merge_Sort(A, p, q)
        Merge_Sort(A, q+1, r)
        Merge(A, p, q, r)
        
def main():
    old_vector = [54, 69, 70, 88, 35, 89, 42, 59, 93, 51, 43, 80, 83, 48, 6] #LAD: testing [5,2,4,6,1,3,4,2,22,1]
    print("The vector to be sorted : ", old_vector)
    Merge_Sort(old_vector, 0, len(old_vector)-1)
    print("The vector after being sorted : ", old_vector)
main()