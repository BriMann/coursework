︠9b25c866-ccf2-4317-831c-bbd521f9fdb6︠
%md

# 2.3 Designing algorithms

### Dr. Danielson

There are many ways to design algorithms.


 - <u>Incremental</u>
   - Insertion sort is incremental since having sorted $A[1..j-1]$, place $A[j]$ correctly so that $A[1..j]$ is sorted.
 - <u>Divide-and-conquer</u>
   - another common design we will consider next
   
**Divide** the problem into a number of subproblems that are smaller instances of the same problem.

**Conquer** the subproblems by solving them recursively.
  - Base case: If the subproblems are small enough, just solve them by brute force!

**Combine** the subproblem solutions to give a solution to the original problem.

## Merge sort

A sorting algorithm based on <u>divide-and-conquer</u>. Its worst-case running time $T_W(n)$ has a lower order of growth than insertion sort (which is _____ ?)

<u>Subproblems</u>: sorting arrays $A[p..r]$
  - Initially, $p=1$ and $r=n$, but these values change as we recurse
  
To sort $A[p..r]$:

**Divide** by splitting into two subarrays $A[p..q]$ and $A[q+1..r]$, where $q$ is the halfway point of $A[p..r]$

**Conquer** by recursively sorting the two subarrays $A[p..q]$ and $A[q+1..r]$

**Combine** by merging the two sorted subarrays $A[p..q]$ and $A[q+1..r]$ to produce a single sorted subarray $A[p..r]$
  - We'll need to define a procedure MERGE$(A,p,q,r)$
  
Note: The recursion bottoms out when the subarray has just 1 element, so that it’s trivially sorted.

<img src='images/02_03_merge_sort_pseudo.PNG' width=20% />

_Initial call:_ MERGE_SORT$(A, 1, n)$


Note: $\lfloor x \rfloor$ is the floor function-the greatest integer less than or equal to $x$.  So $q =  \lfloor (p+r)/2 \rfloor$ is the integer halfway point of $p$ and $r$.

︡9c1965d1-42c5-4361-ae37-63234e30e103︡{"done":true,"md":"\n# 2.3 Designing algorithms\n\n### Dr. Danielson\n\nThere are many ways to design algorithms.\n\n\n - <u>Incremental</u>\n   - Insertion sort is incremental since having sorted $A[1..j-1]$, place $A[j]$ correctly so that $A[1..j]$ is sorted.\n - <u>Divide-and-conquer</u>\n   - another common design we will consider next\n   \n**Divide** the problem into a number of subproblems that are smaller instances of the same problem.\n\n**Conquer** the subproblems by solving them recursively.\n  - Base case: If the subproblems are small enough, just solve them by brute force!\n\n**Combine** the subproblem solutions to give a solution to the original problem.\n\n## Merge sort\n\nA sorting algorithm based on <u>divide-and-conquer</u>. Its worst-case running time $T_W(n)$ has a lower order of growth than insertion sort (which is _____ ?)\n\n<u>Subproblems</u>: sorting arrays $A[p..r]$\n  - Initially, $p=1$ and $r=n$, but these values change as we recurse\n  \nTo sort $A[p..r]$:\n\n**Divide** by splitting into two subarrays $A[p..q]$ and $A[q+1..r]$, where $q$ is the halfway point of $A[p..r]$\n\n**Conquer** by recursively sorting the two subarrays $A[p..q]$ and $A[q+1..r]$\n\n**Combine** by merging the two sorted subarrays $A[p..q]$ and $A[q+1..r]$ to produce a single sorted subarray $A[p..r]$\n  - We'll need to define a procedure MERGE$(A,p,q,r)$\n  \nNote: The recursion bottoms out when the subarray has just 1 element, so that it’s trivially sorted.\n\n<img src='images/02_03_merge_sort_pseudo.PNG' width=20% />\n\n_Initial call:_ MERGE_SORT$(A, 1, n)$\n\n\nNote: $\\lfloor x \\rfloor$ is the floor function-the greatest integer less than or equal to $x$.  So $q =  \\lfloor (p+r)/2 \\rfloor$ is the integer halfway point of $p$ and $r$."}
︠5e7f6997-66bd-4ad0-b0f1-1d81001efc28i︠
%md

Complete the Examples for $n=8$ (**Figure 2.4**) and $n=11$: https://lucid.app/lucidchart/invitations/accept/7c77c93d-374e-4cd7-a749-a8a000167dbf

### Merging

What remains is the MERGE procedure.

**MERGE algorithm**

 - **Input:** Array $A$ and indices $p, q, r$ such that
   - $p\leq q < r$
   - Subarray $A[p..q]$ is sorted and subarray $A[q+1..r]$ is sorted and by restrictions on $p, q, r$ neither subarray is empty
 - **Output:**  The two subarrays are merged into a single sorted subarray in $A[p..r]$
 
We will implement MERGE so it takes $\Theta(n)$ time, where $n = r - p + 1 = $ the number of elements being merged.

**Note**: Now $n$ is the <u>size of the subproblem</u>, NOT the size of the original problem.

_Idea behind linear-time merging_

Think of two piles of cards.
 - Each pile is sorted and placed face-up on a table with the smallest cards on top.
 - We will merge these into a single sorted pile, face-down on the table.
 - A basic step:
     - Choose the smaller of the two top cards.
     - Remove it from its pile, thereby exposing a new top card.
     - Place the chosen card face-down onto the output pile.
 - Repeatedly perform basic steps until one input pile is empty.
 - Once one input pile empties, just take the remaining input pile and place it face-down onto the output pile.
 - Each basic step should take constant time, since we compare the two top cards, assign the smaller.
 - There are $\leq n$ basic steps, since each basic step removes one card from the input piles, and we started with $n$ cards in the input piles.
 - Therefore, this procedure should take $\Theta(n)$ time.
 
We don’t actually need to check whether a pile is empty before each basic step:

 - Put on the bottom of each input pile a special <u>sentinel</u> card.
 - It contains a special value that we use to simplify the code.
 - Pseudocode uses $\infty$, since that’s guaranteed to "lose" to any other value.
 - The only way that $\infty$ cannot lose is when both piles have $\infty$ on top.
 - But when that happens, all nonsentinel cards have already been placed into the output pile.
 - We know in advance that there are exactly $ r - p + 1$ nonsentinel cards $\implies$ stop once we have performed $ r - p + 1$ basic steps. Never a need to check for sentinels, since they’ll always lose.
 - Rather actually counting basic steps, just fill up the output vector from index $p$ up through and including index $r$.

<img src='images/02_03_merge_pseudo.PNG' width=30% />

In detail, the MERGE procedure works as follows:

 - Line 1 computes the length $n_1$ of the subarray $A[p..q]$ 
 - Line 2 computes the length $n_2$ of the subarray  $A[q+1..r]$
 - Line 3 creates arrays $L$ and $R$ ("left" and "right") of lengths $n_1 + 1$ and $n_2 + 1$
   - the extra position in each array will hold the sentinel
 - The **for** loop of lines 4-5 copies the subarry $A[p..q]$  into $L[1..n_1]$ 
 - The **for** loop of lines 6-7 copies the subarry $A[q+1..r]$  into $R[1..n_2]$ 
 - Lines 8-9 put the sentinels at the ends of the arrays $L$ and $R.$
 - Lines 10-17 perform the $ r - p + 1$ basic steps by maintaining the MERGE Loop Invariant


MERGE Loop Invariant


> At the start of each iteration of the **for** loop of lines 12–17, the subarray $A[p..k-1]$ contains the $k- p$ smallest elements of $L[1..n_1 +1]$ and $R[1..n_2 + 1..q]$, insorted order. Moreover, $L[i]$ and $R[j]$ are the smallest elements of their arrays that have not been copied back into $A.$


Try an Example: https://lucid.app/lucidchart/invitations/accept/f43ae390-f6b6-402b-97c9-8ac1225c57e2

︡a310214a-cbb8-43ad-8f39-33227527a958︡{"done":true,"md":"\nComplete the Examples for $n=8$ (**Figure 2.4**) and $n=11$: https://lucid.app/lucidchart/invitations/accept/7c77c93d-374e-4cd7-a749-a8a000167dbf\n\n### Merging\n\nWhat remains is the MERGE procedure.\n\n**MERGE algorithm**\n\n - **Input:** Array $A$ and indices $p, q, r$ such that\n   - $p\\leq q < r$\n   - Subarray $A[p..q]$ is sorted and subarray $A[q+1..r]$ is sorted and by restrictions on $p, q, r$ neither subarray is empty\n - **Output:**  The two subarrays are merged into a single sorted subarray in $A[p..r]$\n \nWe will implement MERGE so it takes $\\Theta(n)$ time, where $n = r - p + 1 = $ the number of elements being merged.\n\n**Note**: Now $n$ is the <u>size of the subproblem</u>, NOT the size of the original problem.\n\n_Idea behind linear-time merging_\n\nThink of two piles of cards.\n - Each pile is sorted and placed face-up on a table with the smallest cards on top.\n - We will merge these into a single sorted pile, face-down on the table.\n - A basic step:\n     - Choose the smaller of the two top cards.\n     - Remove it from its pile, thereby exposing a new top card.\n     - Place the chosen card face-down onto the output pile.\n - Repeatedly perform basic steps until one input pile is empty.\n - Once one input pile empties, just take the remaining input pile and place it face-down onto the output pile.\n - Each basic step should take constant time, since we compare the two top cards, assign the smaller.\n - There are $\\leq n$ basic steps, since each basic step removes one card from the input piles, and we started with $n$ cards in the input piles.\n - Therefore, this procedure should take $\\Theta(n)$ time.\n \nWe don’t actually need to check whether a pile is empty before each basic step:\n\n - Put on the bottom of each input pile a special <u>sentinel</u> card.\n - It contains a special value that we use to simplify the code.\n - Pseudocode uses $\\infty$, since that’s guaranteed to \"lose\" to any other value.\n - The only way that $\\infty$ cannot lose is when both piles have $\\infty$ on top.\n - But when that happens, all nonsentinel cards have already been placed into the output pile.\n - We know in advance that there are exactly $ r - p + 1$ nonsentinel cards $\\implies$ stop once we have performed $ r - p + 1$ basic steps. Never a need to check for sentinels, since they’ll always lose.\n - Rather actually counting basic steps, just fill up the output vector from index $p$ up through and including index $r$.\n\n<img src='images/02_03_merge_pseudo.PNG' width=30% />\n\nIn detail, the MERGE procedure works as follows:\n\n - Line 1 computes the length $n_1$ of the subarray $A[p..q]$ \n - Line 2 computes the length $n_2$ of the subarray  $A[q+1..r]$\n - Line 3 creates arrays $L$ and $R$ (\"left\" and \"right\") of lengths $n_1 + 1$ and $n_2 + 1$\n   - the extra position in each array will hold the sentinel\n - The **for** loop of lines 4-5 copies the subarry $A[p..q]$  into $L[1..n_1]$ \n - The **for** loop of lines 6-7 copies the subarry $A[q+1..r]$  into $R[1..n_2]$ \n - Lines 8-9 put the sentinels at the ends of the arrays $L$ and $R.$\n - Lines 10-17 perform the $ r - p + 1$ basic steps by maintaining the MERGE Loop Invariant\n\n\nMERGE Loop Invariant\n\n\n> At the start of each iteration of the **for** loop of lines 12–17, the subarray $A[p..k-1]$ contains the $k- p$ smallest elements of $L[1..n_1 +1]$ and $R[1..n_2 + 1..q]$, insorted order. Moreover, $L[i]$ and $R[j]$ are the smallest elements of their arrays that have not been copied back into $A.$\n\n\nTry an Example: https://lucid.app/lucidchart/invitations/accept/f43ae390-f6b6-402b-97c9-8ac1225c57e2"}
︠3e14f6b1-ccf2-422b-af5c-8f7668c7dd72︠
%md


**At the boards in groups:**  Using Figure 2.4 as a model, illustrate the operation of MERGE-SORT on the array

$$A = <3, 41, 52, 26, 38, 57, 9, 49>.$$
︡3d3c5459-9835-48e6-91f2-08ba185e10ba︡{"done":true,"md":"\n\n**At the boards in groups:**  Using Figure 2.4 as a model, illustrate the operation of MERGE-SORT on the array\n\n$$A = <3, 41, 52, 26, 38, 57, 9, 49>.$$"}









