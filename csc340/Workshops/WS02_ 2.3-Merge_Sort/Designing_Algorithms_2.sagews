︠07823731-7e31-4249-9a8c-69e78129ac46︠
%md

# 2.3 Designing algorithms: Part 2

### Your name: Danielson

We will analyze the time complexity of MERGE_SORT next.  

First consider MERGE:
<img src='images/02_03_merge_pseudo.PNG' width=30% />|

The first two **for** loops take $\Theta(n_1 + n_2) = \Theta(n)$ time. The last **for** loop makes $n$ iterations for for a subarray of size $n$, each taking constant time, for $\Theta(n)$ time.  
  - Thus the total time to merge a subarray of size $n$: $\Theta(n)$




︡7645c143-7515-4a0d-a9ff-151fba2ae5ef︡{"done":true,"md":"\n# 2.3 Designing algorithms: Part 2\n\n### Your name: Danielson\n\nWe will analyze the time complexity of MERGE_SORT next.  \n\nFirst consider MERGE:\n<img src='images/02_03_merge_pseudo.PNG' width=30% />|\n\nThe first two **for** loops take $\\Theta(n_1 + n_2) = \\Theta(n)$ time. The last **for** loop makes $n$ iterations for for a subarray of size $n$, each taking constant time, for $\\Theta(n)$ time.  \n  - Thus the total time to merge a subarray of size $n$: $\\Theta(n)$"}
︠7809acc2-fd2c-4386-8356-25621db407eai︠
%md

#### Analyzing divide-and-conquer algorithms in general

We use a _recurrence equation_ (or a _recurrence_) to describe the running time of a divide-and-conquer algorithm.

Let $T(n) = $ running time on a problem of size $n$.

 - If the problem size is small enough (say, $n\leq c$), we have a base case. The brute-force solution takes constant time: $\Theta(1)$
 - Otherwise, suppose we divide into $a$ subproblems, each $1/b$ the size of the original. (In merge sort, $a = b = 2$)
 - Let $D(n)$ be the time to divide a size-$n$ problem
 - We have $a$ subproblems to solve, each of size $n/b \implies$  each subproblem takes $T(n/b)$ time $\implies$ we spend $aT(n/b)$ time solving subproblems.
 - Let $C(n)$ be the time to combine solutions
 - We get the general recurrence
 
 $$T(n) = \begin{cases} 
          \Theta(1) & \text{if } n\leq c \\
           aT(n/b) + D(n) + C(n) & \text{ otherwise}
       \end{cases} $$

︡cc428a8f-8e9e-423d-b1ca-2f59ef7246e0︡{"done":true,"md":"\n#### Analyzing divide-and-conquer algorithms in general\n\nWe use a _recurrence equation_ (or a _recurrence_) to describe the running time of a divide-and-conquer algorithm.\n\nLet $T(n) = $ running time on a problem of size $n$.\n\n - If the problem size is small enough (say, $n\\leq c$), we have a base case. The brute-force solution takes constant time: $\\Theta(1)$\n - Otherwise, suppose we divide into $a$ subproblems, each $1/b$ the size of the original. (In merge sort, $a = b = 2$)\n - Let $D(n)$ be the time to divide a size-$n$ problem\n - We have $a$ subproblems to solve, each of size $n/b \\implies$  each subproblem takes $T(n/b)$ time $\\implies$ we spend $aT(n/b)$ time solving subproblems.\n - Let $C(n)$ be the time to combine solutions\n - We get the general recurrence\n \n $$T(n) = \\begin{cases} \n          \\Theta(1) & \\text{if } n\\leq c \\\\\n           aT(n/b) + D(n) + C(n) & \\text{ otherwise}\n       \\end{cases} $$"}
︠2ed816f4-397f-4304-be2e-84aad5e330e2︠
%md

#### Analyzing merge-sort


Recall:
<img src='images/02_03_merge_sort_pseudo.PNG' width=20% />  

For simplicity, assume that $n$ is a power of $2 \implies$  each divide step yields two subproblems, both of size  $n/2$ exactly.

The base case occurs when $n = 1$.

When $n \geq 2$, time for merge-sort steps:


> **Divide:** Compute the middle of the subarray or the average $q$ of $p$ and $r \implies D(n) = \Theta(1)$

> **Conquer:** Recursively solve $2$ subproblems, each of size $n/2 \implies 2T(n/2)$

> **Combine:** MERGE on an $n$-element subarray takes $\Theta(n)$ time $\implies C(n) = \Theta(n)$

Since $D(n) = \Theta(1)$ and $C(n) = \Theta(n)$, summed they give a linear function in $n: \Theta(n)$. Thus the merge-sort recurrence is:

$$T(n) = \begin{cases} 
          \Theta(1) & \text{if } n = 1 \\
           2T(n/2) + \Theta(n) & \text{if } n > 1
       \end{cases} $$
       
       
##### _Solving the merge-sort recurrence_

In Chapter 4, we will see the "Master Theorem" which will show us the merge-sort recurrence has the solution $T(n) = \Theta(n \lg n)$ so for large $n$
 - merge-sort is faster than insertion sort which had $T_W(n) = \Theta(n^2)$ --trading a factor of $n$ for a factor of $\lg n$ is good!
 
Let's undertsand the running time of merge-sort without the master theorem:
 - Let $c=$  running time for the base case and also time per array element for the divide and conquer steps [not necessarily equal, but approximate]
 - Then $$T(n) = \begin{cases} 
          c & \text{if } n = 1 \\
           2T(n/2) + c n & \text{if } n > 1
       \end{cases} $$
 - Draw a **_recursion tree_**, which shows successive expansions of the recurrence.
 
 https://lucid.app/lucidchart/invitations/accept/8867d5bf-35f1-4087-a45f-fe9923a5ad48

Let's try this at the board.  Then I'll share my Lucidchart figure.

How many levels are in the tree?  That is, what is the height of the tree?

| insertion-sort                                                                                     | merge-sort  | 
| :------------                                                                                      |:---------------| 
| sorts in place                                                                                     | does <u>not</u> sort in place        |
| a constant number of array elements (1--the key) are sorted outside the input array at any time    |   Uses L and R of non-constant size  | 
| $\Theta(n^2)$ worst case                                                                           |    $\Theta(n \lg n)$ worst case  |     

︡6ef493c3-be5a-4934-8ceb-b0834f166c0e︡{"done":true,"md":"\n#### Analyzing merge-sort\n\n\nRecall:\n<img src='images/02_03_merge_sort_pseudo.PNG' width=20% />  \n\nFor simplicity, assume that $n$ is a power of $2 \\implies$  each divide step yields two subproblems, both of size  $n/2$ exactly.\n\nThe base case occurs when $n = 1$.\n\nWhen $n \\geq 2$, time for merge-sort steps:\n\n\n> **Divide:** Compute the middle of the subarray or the average $q$ of $p$ and $r \\implies D(n) = \\Theta(1)$\n\n> **Conquer:** Recursively solve $2$ subproblems, each of size $n/2 \\implies 2T(n/2)$\n\n> **Combine:** MERGE on an $n$-element subarray takes $\\Theta(n)$ time $\\implies C(n) = \\Theta(n)$\n\nSince $D(n) = \\Theta(1)$ and $C(n) = \\Theta(n)$, summed they give a linear function in $n: \\Theta(n)$. Thus the merge-sort recurrence is:\n\n$$T(n) = \\begin{cases} \n          \\Theta(1) & \\text{if } n = 1 \\\\\n           2T(n/2) + \\Theta(n) & \\text{if } n > 1\n       \\end{cases} $$\n       \n       \n##### _Solving the merge-sort recurrence_\n\nIn Chapter 4, we will see the \"Master Theorem\" which will show us the merge-sort recurrence has the solution $T(n) = \\Theta(n \\lg n)$ so for large $n$\n - merge-sort is faster than insertion sort which had $T_W(n) = \\Theta(n^2)$ --trading a factor of $n$ for a factor of $\\lg n$ is good!\n \nLet's undertsand the running time of merge-sort without the master theorem:\n - Let $c=$  running time for the base case and also time per array element for the divide and conquer steps [not necessarily equal, but approximate]\n - Then $$T(n) = \\begin{cases} \n          c & \\text{if } n = 1 \\\\\n           2T(n/2) + c n & \\text{if } n > 1\n       \\end{cases} $$\n - Draw a **_recursion tree_**, which shows successive expansions of the recurrence.\n \n https://lucid.app/lucidchart/invitations/accept/8867d5bf-35f1-4087-a45f-fe9923a5ad48\n\nLet's try this at the board.  Then I'll share my Lucidchart figure.\n\nHow many levels are in the tree?  That is, what is the height of the tree?\n\n| insertion-sort                                                                                     | merge-sort  | \n| :------------                                                                                      |:---------------| \n| sorts in place                                                                                     | does <u>not</u> sort in place        |\n| a constant number of array elements (1--the key) are sorted outside the input array at any time    |   Uses L and R of non-constant size  | \n| $\\Theta(n^2)$ worst case                                                                           |    $\\Theta(n \\lg n)$ worst case  |"}









