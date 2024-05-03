︠55f12209-6c1c-49b4-b217-97be4182d77b︠
%md

# Chapter 7 Quicksort

#### Your name: !!

Though heapsort is a great algorithm, a well-implemented quicksort usually beats it in practice.

## Quicksort


 - Worst-case running time $ O\left(n^2\right)$--merge sort and heapsort $O\left(n\text{lg}n\right)$
 - Expected running time $ O\left(n\text{lg}n\right)$
 - Constants hidden in $ O\left(n\text{lg}n\right)$ are small
 - Sorts in place
 
## 7.1 Description of quicksort

Quicksort is based on the three-step process of divide-and-conquer.

  - To sort the subarray $ A[p..r]:$
    - **Divide:** Partition $ A[p..r]$ into two (possibly empty) subarrays $ A[p..q-1]$ and $ A[q+1..r]$ such that each element in the first subarray $ A[p..q-1]$ is $\leq A[q]$ and $A[q]\leq $ each element in the second subarray $ A[q+1..r].$
    - **Conquer:** Sort the two subarrays by recursive calls to QUICKSORT.
    -  **Combine:** No work is needed to combine the subarrays, because they are sorted in place!
  - Perform the divide step by a procedure PARTITION, which returns the index $q$ that marks the position separating the subarrays.


︡5082a955-c440-4b0e-9fa5-d749c397169a︡{"done":true,"md":"\n# Chapter 7 Quicksort\n\n#### Your name: !!\n\nThough heapsort is a great algorithm, a well-implemented quicksort usually beats it in practice.\n\n## Quicksort\n\n\n - Worst-case running time $ O\\left(n^2\\right)$--merge sort and heapsort $O\\left(n\\text{lg}n\\right)$\n - Expected running time $ O\\left(n\\text{lg}n\\right)$\n - Constants hidden in $ O\\left(n\\text{lg}n\\right)$ are small\n - Sorts in place\n \n## 7.1 Description of quicksort\n\nQuicksort is based on the three-step process of divide-and-conquer.\n\n  - To sort the subarray $ A[p..r]:$\n    - **Divide:** Partition $ A[p..r]$ into two (possibly empty) subarrays $ A[p..q-1]$ and $ A[q+1..r]$ such that each element in the first subarray $ A[p..q-1]$ is $\\leq A[q]$ and $A[q]\\leq $ each element in the second subarray $ A[q+1..r].$\n    - **Conquer:** Sort the two subarrays by recursive calls to QUICKSORT.\n    -  **Combine:** No work is needed to combine the subarrays, because they are sorted in place!\n  - Perform the divide step by a procedure PARTITION, which returns the index $q$ that marks the position separating the subarrays."}
︠5db4927e-cf2c-4335-900f-ac7446df7207︠
####### Do not run :)######
#pseudocode                                     

QUICKSORT(A,p,r)
    if p < r:
        q = PARTITION(A,p,r)
        QUICKSORT(A,p,q-1)
        QUICKSORT(A,q+1,r)
    
####### Do not run :)######
︡2f37d426-e01a-4b53-b908-dd884bba3dbf︡
︠e171d689-7bf6-4e40-9b26-203541c5c07fi︠
%md

Initial call is QUICKSORT$(A,1,n).$

### Partitioning

Partition subarray $A[p..r]$ by the following procedure:
︡5000972e-09f3-4c4f-b0db-f8c7faa9ec06︡{"done":true,"md":"\nInitial call is QUICKSORT$(A,1,n).$\n\n### Partitioning\n\nPartition subarray $A[p..r]$ by the following procedure:"}
︠aecc0ecc-c123-4254-887c-15c850bc79bao︠
####### Do not run :)######
#pseudocode                                     

PARTITION(A,p,r)
    x = A[r]
    i = p - 1
    for j = p to r - 1:
        if A[j] <= x:
            i = i + 1
            exchange A[i] with A[j]
    exchange A[i + 1] with A[r]
    return i + 1
    
####### Do not run :)######
︡8e999a1a-fb7c-47cd-844c-a43247c64254︡
︠d6ba97ce-957d-4b67-88cd-99309a3d921c︠
%md

 - PARTITION always selects the last element $A[r]$ in the subarray $ A[p..r]$ as the _pivot_—the element around which to partition.
 - As the procedure executes, the array is partitioned into four regions, some of which may be empty:
  
 - **Loop invariant:**
1. All entries in $A[p..i]$ are $\leq$ pivot.
2. All entries in $A[i+1..j-1]$ are $>$ pivot.
3. $A[r]=$ pivot.

It’s not needed as part of the loop invariant, but the fourth region is $A[j..r-1]$, whose entries have not yet been examined, and so we don’t know how they compare to the pivot.

Let's complete a run-through of Book Example Figure 7.1: $A =  \langle 2,8,7,1,3,5,6,4  \rangle$, PARTION(A,1,8):

https://lucid.app/lucidchart/invitations/accept/1e65ab3c-5401-45e6-a7df-1628e2251768

**At the boards:**

1. Using our example Figure 7.1 pg. 172 as a model, illustrate the operation of PARTITION on the array $ A= \langle 13, 19, 9, 5, 12, 8, 7, 4, 21, 2, 6, 11 \rangle. $

2. Give a brief explanation of why the running time of PARTITION on a subarray of size $n$ is $\Theta(n)$.

3. Use the loop invariant to prove correctness of PARTITION. Hint: The answer is in the book! Try to do each step withot the book first, then check and correct if necessary.

Record your answers on the Workshop11 handout.



︡28f016d9-7869-4fdc-b497-e75dec93a661︡{"done":true,"md":"\n - PARTITION always selects the last element $A[r]$ in the subarray $ A[p..r]$ as the _pivot_—the element around which to partition.\n - As the procedure executes, the array is partitioned into four regions, some of which may be empty:\n  \n - **Loop invariant:**\n1. All entries in $A[p..i]$ are $\\leq$ pivot.\n2. All entries in $A[i+1..j-1]$ are $>$ pivot.\n3. $A[r]=$ pivot.\n\nIt’s not needed as part of the loop invariant, but the fourth region is $A[j..r-1]$, whose entries have not yet been examined, and so we don’t know how they compare to the pivot.\n\nLet's complete a run-through of Book Example Figure 7.1: $A =  \\langle 2,8,7,1,3,5,6,4  \\rangle$, PARTION(A,1,8):\n\nhttps://lucid.app/lucidchart/invitations/accept/1e65ab3c-5401-45e6-a7df-1628e2251768\n\n**At the boards:**\n\n1. Using our example Figure 7.1 pg. 172 as a model, illustrate the operation of PARTITION on the array $ A= \\langle 13, 19, 9, 5, 12, 8, 7, 4, 21, 2, 6, 11 \\rangle. $\n\n2. Give a brief explanation of why the running time of PARTITION on a subarray of size $n$ is $\\Theta(n)$.\n\n3. Use the loop invariant to prove correctness of PARTITION. Hint: The answer is in the book! Try to do each step withot the book first, then check and correct if necessary.\n\nRecord your answers on the Workshop11 handout."}











