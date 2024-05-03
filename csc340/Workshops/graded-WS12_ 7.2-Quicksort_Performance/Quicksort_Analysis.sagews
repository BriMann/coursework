︠0abd8dc9-50ab-417f-ad6c-2f6cf61ee7c3︠
%md

## 7.2 Performance of Quicksort

#### Your name: !!

Recall so far:
| insertion-sort                                                                                     | merge-sort                           | heap-sort     |
| :------------                                                                                      |:---------------                      | :---------------|
| sorts in place                                                                                     | does <u>not</u> sort in place        |  sorts in place  |
| a constant number of array elements (1--the key) are sorted outside the input array at any time    |   Uses L and R of non-constant size  | utilizes a max (min) heap  |
| $\Theta(n^2)$ worst case                                                                           |    $\Theta(n \lg n)$ worst case      | $\Theta(n \lg n)$ worst case |

Recall our QUICKSORT algorithm:
︡bb6f65d1-f85e-4940-bb2c-ad0bafaee4ef︡{"done":true,"md":"\n## 7.2 Performance of Quicksort\n\n#### Your name: !!\n\nRecall so far:\n| insertion-sort                                                                                     | merge-sort                           | heap-sort     |\n| :------------                                                                                      |:---------------                      | :---------------|\n| sorts in place                                                                                     | does <u>not</u> sort in place        |  sorts in place  |\n| a constant number of array elements (1--the key) are sorted outside the input array at any time    |   Uses L and R of non-constant size  | utilizes a max (min) heap  |\n| $\\Theta(n^2)$ worst case                                                                           |    $\\Theta(n \\lg n)$ worst case      | $\\Theta(n \\lg n)$ worst case |\n\nRecall our QUICKSORT algorithm:"}
︠b291651a-a097-45f9-9c28-b28074c5412e︠
####### Do not run :)######
#pseudocode                                     

QUICKSORT(A,p,r)
    if p < r:
        q = PARTITION(A,p,r)
        QUICKSORT(A,p,q-1)
        QUICKSORT(A,q+1,r)
    
####### Do not run :)######
︡1029c7bf-9075-4728-bc1d-303d0f4121e7︡
︠cd4a984e-9676-4cc8-9d2a-8fb162cfdff3so︠
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
︡5896fb67-19f6-484c-a86a-036b630298a6︡{"stderr":"Error in lines 1-9\n"}︡{"stderr":"Traceback (most recent call last):\n  File \"/cocalc/lib/python3.8/site-packages/smc_sagews/sage_server.py\", line 1231, in execute\n    compile(block + '\\n',\n  File \"<string>\", line 1\n    PARTITION(A,p,r)\n                   ^\nSyntaxError: multiple statements found while compiling a single statement\n"}︡{"done":true}
︠d3e4aba7-6f26-4ac5-b2e7-3d1907740f7c︠
%md

Recall:  The running time of PARTITION on a subarray of size $n$ is $\Theta(n)$. 

The running time of quicksort depends on the partitioning of the subarrays:
 - If the subarrays are balanced, then quicksort can run as fast as mergesort.
 - If they are unbalanced, then quicksort can run as slowly as insertion sort.
 
### Worst case

Occurs when the subarrays are completely unbalanced.
 -  Have $0$ elements in one subarray and $n-1$ elements in the other subarray.
 - Get the recurrence
  $$\begin{align*}
    T(n)&= T(n-1) + T(0) + \Theta(n) \\
    &=  T(n-1) + \Theta(n)\\
    &= \Theta(n^2)
    \end{align*}$$
    
since $T(0) = \Theta(1)$ and "intuitively" if we sum the costs incurred on each level we get an arithmetic series:

Considering the upper bound, $T(n) \leq T(n-1) + c_1 n$ for some $c_1$ and then 

$$\begin{align*}
    T(n)& \leq T(n-1) + c_1 n \\
    &\leq  [T(n-2) + c_2 (n-1)] + c_1 n\\
    &\leq  [T(n-3) + c_3 (n-2)] + c_2 (n-1) + c_1 n\\
    & \vdots\\
    &\leq c\sum_{j=0}^n j = O(n^2)\\
    \end{align*}$$
    
and the same for the lower bound, thus we can believe $T(n) = \Theta(n^2)$.

 - Same running time as insertion sort.
 - In fact, when considering a sorted array as input, yields
   - quicksort worst-case running time $\Theta(n^2)$
   - insertion sort best-case running time $O(n)$ in this case
︡c1652bb9-163b-4b18-88b8-fc1add12334d︡{"done":true,"md":"\nRecall:  The running time of PARTITION on a subarray of size $n$ is $\\Theta(n)$. \n\nThe running time of quicksort depends on the partitioning of the subarrays:\n - If the subarrays are balanced, then quicksort can run as fast as mergesort.\n - If they are unbalanced, then quicksort can run as slowly as insertion sort.\n \n### Worst case\n\nOccurs when the subarrays are completely unbalanced.\n -  Have $0$ elements in one subarray and $n-1$ elements in the other subarray.\n - Get the recurrence\n  $$\\begin{align*}\n    T(n)&= T(n-1) + T(0) + \\Theta(n) \\\\\n    &=  T(n-1) + \\Theta(n)\\\\\n    &= \\Theta(n^2)\n    \\end{align*}$$\n    \nsince $T(0) = \\Theta(1)$ and \"intuitively\" if we sum the costs incurred on each level we get an arithmetic series:\n\nConsidering the upper bound, $T(n) \\leq T(n-1) + c_1 n$ for some $c_1$ and then \n\n$$\\begin{align*}\n    T(n)& \\leq T(n-1) + c_1 n \\\\\n    &\\leq  [T(n-2) + c_2 (n-1)] + c_1 n\\\\\n    &\\leq  [T(n-3) + c_3 (n-2)] + c_2 (n-1) + c_1 n\\\\\n    & \\vdots\\\\\n    &\\leq c\\sum_{j=0}^n j = O(n^2)\\\\\n    \\end{align*}$$\n    \nand the same for the lower bound, thus we can believe $T(n) = \\Theta(n^2)$.\n\n - Same running time as insertion sort.\n - In fact, when considering a sorted array as input, yields\n   - quicksort worst-case running time $\\Theta(n^2)$\n   - insertion sort best-case running time $O(n)$ in this case"}
︠47423c7c-3500-48fa-87e0-225f58ca4559i︠
%md

### Best case

 - Occurs when the subarrays are completely balanced every time.
 - Each subarray has $\leq n/2$ elements.
 - Get the recurrence
  $$\begin{align*}
    T(n)&= 2T(n/2)+ \Theta(n) \\
    &= \Theta(n\lg n) \text{   By case 2 of the Master theorem :)}
    \end{align*}$$
    
### Balanced partitioning

 - Quicksort’s average running time is much closer to the best case than to the worst case.
 - Imagine that PARTITION always produces a 9-to-1 split (which seems quite unbalanced).
 - Get the recurrence
  \begin{align*}
    T(n)&= T(9n/10)+ T(n/10)+\Theta(n) \\
    &= \Theta(n\lg n)
    \end{align*}
    
 - Intuition: look at the recursion tree Figure 7.4 page 176:
 
 <img src='images/07_02_Qsort_recursion_tree_Fig_7-4.PNG' width=30% />
 
 - It’s like the one for $T(n/3)+ T(2n/3)+O(n)$ in Section 4.4.
 - Except that here the constants are different; we get $\log_{10} n$ full levels and $\log_{10/9} n$ levels that are nonempty.
 - As long as it’s a constant, the base of the log doesn’t matter in asymptotic notation.
 - Any split of constant proportionality will yield a recursion tree of depth $\Theta(\lg n)$.
︡69c49a53-c4c0-40b6-8f33-ea6f0798405e︡{"done":true,"md":"\n### Best case\n\n - Occurs when the subarrays are completely balanced every time.\n - Each subarray has $\\leq n/2$ elements.\n - Get the recurrence\n  $$\\begin{align*}\n    T(n)&= 2T(n/2)+ \\Theta(n) \\\\\n    &= \\Theta(n\\lg n) \\text{   By case 2 of the Master theorem :)}\n    \\end{align*}$$\n    \n### Balanced partitioning\n\n - Quicksort’s average running time is much closer to the best case than to the worst case.\n - Imagine that PARTITION always produces a 9-to-1 split (which seems quite unbalanced).\n - Get the recurrence\n  \\begin{align*}\n    T(n)&= T(9n/10)+ T(n/10)+\\Theta(n) \\\\\n    &= \\Theta(n\\lg n)\n    \\end{align*}\n    \n - Intuition: look at the recursion tree page 176:\n \n <img src='images/07_02_Qsort_recursion_tree_Fig_7-4.PNG' width=30% />\n \n - It’s like the one for $T(n/3)+ T(2n/3)+O(n)$ in Section 4.4.\n - Except that here the constants are different; we get $\\log_{10} n$ full levels and $\\log_{10/9} n$ levels that are nonempty.\n - As long as it’s a constant, the base of the log doesn’t matter in asymptotic notation.\n - Any split of constant proportionality will yield a recursion tree of depth $\\Theta(\\lg n)$."}
︠b00fd62d-bb30-4c5c-95f7-b9945a4ac395i︠
%md

### Intuition for the average case

 - Splits in the recursion tree will not always be constant.
 - There will usually be a mix of good and bad splits throughout the recursion tree.
 - To see that this doesn’t affect the asymptotic running time of quicksort, assume that levels alternate between best-case and worst-case splits. See Figure 7.5 page 177:

 <img src='images/07_02_Qsort_recursion_tree_Fig_7-5.PNG' width=40% />
 
 - The extra level in the left-hand figure only adds to the constant hidden in the $\Theta$-notation.
 - There are still the same number of subarrays to sort, and only twice as much work was done to get to that point.
 - Both figures result in $\Theta(n\lg n)$ time, though the constant for the figure on the left is higher than that of the figure on the right.
︡88c77cac-25be-4e2e-9b19-d67b275c3b24︡{"done":true,"md":"\n### Intuition for the average case\n\n - Splits in the recursion tree will not always be constant.\n - There will usually be a mix of good and bad splits throughout the recursion tree.\n - To see that this doesn’t affect the asymptotic running time of quicksort, assume that levels alternate between best-case and worst-case splits. See Figure 7.5 page 177:\n\n <img src='images/07_02_Qsort_recursion_tree_Fig_7-5.PNG' width=40% />\n \n - The extra level in the left-hand figure only adds to the constant hidden in the $\\Theta$-notation.\n - There are still the same number of subarrays to sort, and only twice as much work was done to get to that point.\n - Both figures result in $\\Theta(n\\lg n)$ time, though the constant for the figure on the left is higher than that of the figure on the right."}
︠86dc6ea6-75ea-41eb-9263-eb5eaa9d838f︠
%md

**At the boards:**

1. What is the running time of QUICKSORT when all of the elements in array A have the same value?  Explain briefly.

2. What is the running time of QUICKSORT when the elements in array A are distinct elements sorted in decreasing order?  Explain briefly.

When you have answered the above questions, submit them in Canvas and begin the program quicksort.cpp OR quicksort.py that ultimately implements and demonstrates QUICKSORT.

See ws12_quicksort_analysis.pdf in CoCalc for specifications.
︡13523f39-e8d8-460b-a4e0-5b7539dd961c︡{"done":true,"md":"\n**At the boards:**\n\n1. What is the running time of QUICKSORT when all of the elements in array A have the same value?  Explain briefly.\n\n2. What is the running time of QUICKSORT when the elements in array A are distinct elements sorted in decreasing order?  Explain briefly.\n\nWhen you have answered the above questions, submit them in canvs and begin the program quicksort.cpp OR quicksort.py that ultimately implements and demonstrates QUICKSORT.\n\nSee ws12_quicksort_analysis.pdf in CoCalc for specifications."}









