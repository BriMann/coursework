# Note: Desired program code quality is modeled below
# Recall: In terminal window: python3 ./insertion_sort.py 
# CSC-340
# ***Brian Mann, 2/8/2022
# This program implements the INSERTION-SORT psuedocode, page 18


"""
* insertion_sort(A)
* takes integer vector A as a reference parameter
* A is the vector to sort
* A IS modified
"""
def insertion_sort(A):
    for j in range(1, len(A)):
        key = A[j]
        i = j - 1
        while i >= 0 and A[i] > key:
            A[i + 1] = A[i]
            i = i - 1
        A[i + 1] = key

"""
* main()
* Demonstrate insertion_sort(A)
"""
    
def main():
    old_vector = [5, 2, 4, 6, 1, 3, 4, 2, 22, 1]
    print("The vector to be sorted : ", old_vector)
    new_vector = insertion_sort(old_vector)
    print("The vector after being sorted : ", new_vector)
    print("Showing that that insertion sort sorted old_vector:", old_vector)
    
    
main()