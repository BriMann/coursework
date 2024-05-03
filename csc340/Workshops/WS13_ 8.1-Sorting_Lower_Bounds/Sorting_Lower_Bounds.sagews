︠b6f137e2-0ee4-4a7f-ac08-1a909e56ca06︠
%md

## 8.1 Lower Bounds for Sorting

#### Your name: ??

In a comparison sort, we use only comparisons between elements to gain order information about an input sequence $< a_1, a_2, \dots, a_n >$. Without loss of generality, we perform tests like:
 - $a_i \leq a_j$

So far, all sorts we've considered (insertion sort, selection sort (on midterm), merge sort, quicksort, heapsort) are worst-case  $\Omega (n\lg n)$.

We can view comparison sorts abstractly in terms of decision trees.

### Decison tree

 - Abstraction of any comparison sort.
 - Represents comparisons made by
   -  a specific sorting algorithm
   -  on inputs of a given size.
 - Abstracts away everything else: control and data movement.
 - We’re counting _only_ comparisons.
 
 Recall the insertion sort algorithm:
 
︡35b29de4-4a50-4753-95b1-2679dde8b0c3︡{"done":true,"md":"\n## 8.1 Lower Bounds for Sorting\n\n#### Your name: ??\n\nIn a comparison sort, we use only comparisons between elements to gain order information about an input sequence $< a_1, a_2, \\dots, a_n >$. Without loss of generality, we perform tests like:\n - $a_i \\leq a_j$\n\nSo far, all sort we've considered (insertion sort, selection sort (on midterm), merge sort, quicksort, heapsort) are worst-case  $\\Omega (n\\lg n)$.\n\nWe can view comparison sorts abstractly in terms of decision trees.\n\n### Decison tree\n\n - Abstraction of any comparison sort.\n - Represents comparisons made by\n   -  a specific sorting algorithm\n   -  on inputs of a given size.\n - Abstracts away everything else: control and data movement.\n - We’re counting _only_ comparisons.\n \n Recall the insertion sort algorithm:"}
︠e38fd9ae-84e1-4098-bb0d-fc13e1e7b092s︠
####### Do not run :)######
#pseudocode                                     

INSERTION-SORT(A,n)
   for j = 2 to n:
        key = A[j]
        #Insert A[j] into the sorted sequence A[1..j-1]
        i = j - 1
        while i > 0 and A[i] > key:
            A[i+1] = A[i]
            i = i - 1
        A[i+1] = key
    
####### Do not run :)######
︡6b120529-92d5-4241-86ae-f325256ff8ec︡{"stderr":"Error in lines 1-8\n"}︡{"stderr":"Traceback (most recent call last):\n  File \"/cocalc/lib/python3.8/site-packages/smc_sagews/sage_server.py\", line 1231, in execute\n    compile(block + '\\n',\n  File \"<string>\", line 1\n    INSERTION-SORT(A,n)\n                      ^\nSyntaxError: multiple statements found while compiling a single statement\n"}︡{"done":true}
︠33abe70b-4ca0-4237-bf7e-2b5410496d94︠
%md

**At the boards:**
 
1. Illustrate the operation of INSERTION-SORT on the array $A= <6, 8, 5 >$. Hint: Figure 2.2 page 18.

https://lucid.app/lucidchart/9bb41085-da12-4090-a271-6ae106021168/edit?page=0_0&invitationId=inv_b98e33f7-7cbf-416d-94ac-2b1efde08bf6#
︡a7eae30f-27a5-4182-9284-f5c6c061a5be︡{"done":true,"md":"\n**At the boards:**\n \n1. Illustrate the operation of INSERTION-SORT on the array $A= <6, 8, 5 >$. Hint: Figure 2.2 page 18.\n\nhttps://lucid.app/lucidchart/9bb41085-da12-4090-a271-6ae106021168/edit?page=0_0&invitationId=inv_b98e33f7-7cbf-416d-94ac-2b1efde08bf6#"}
︠2beed8b2-91a2-4475-ac2f-69af7326d03b︠
%md
Consider the decision tree for insertion sort on 3 elements:

> https://www.lucidchart.com/invitations/accept/4f21cbaf-bce9-49e1-b293-ea9f0cc8020e
︡0aa0aaf1-99bc-4b19-a007-c7710310f13b︡{"done":true,"md":"Consider the decision tree for insertion sort on 3 elements:\n\n> https://www.lucidchart.com/invitations/accept/4f21cbaf-bce9-49e1-b293-ea9f0cc8020e"}
︠b12bf200-9f18-46a2-baa8-644c1dee6c3f︠
%md

**At the boards:**
 
2.  Write the decision tree for insertion sort on 3 elements.  Identify/highlight the path corresponding to the decisions made when insertion-sorting $A=< 6, 8, 5 >$.

3. How many leaves are on the general insertion-sort decision tree when sorting $A=[1..n]$?  Explain briefly.
︡a5600143-0a5f-4c28-85ba-9d1804b9ee6a︡{"done":true,"md":"\n**At the boards:**\n \n2.  Write the decision tree for insertion sort on 3 elements.  Identify/highlight the path corresponding to the decisions made when insertion-sorting $A=< 6, 8, 5 >$.\n\n3. How many leaves are on the general insertion-sort decision tree when sorting $A=[1..n]$?  Explain briefly."}
︠5eb8b5ba-899e-4273-bfca-b29f9ef1bbfdi︠
%md

For any comparison sort,
 - We get one tree for each $n$.
 - View the tree as if the algorithm splits in two at each node, based on the information it has determined up to that point.
 - The tree models all possible execution traces.
 
**_Lemma:_** Any binary tree of height $h$ has $\leq 2^h$ leaves. In other words:
 - $l = \#$ of leaves
 - then $l\leq 2^h$


(We’ll prove this lemma later.) Why is this useful?

**_Theorem:_** Any decision tree that sorts $n$ elements has height  $\Omega (n\lg n)$.
**_Proof_:**
 - the number of leaves $l\geq n!$ by Board Work Question 3.
 - $n!\leq l\leq  2^h$ by lemma, so $2^h\geq n!$
 - taking logs: $h \geq \lg(n!)$
 - Using Stirling's Approximation (WS04 Section 3.2): $n! > (n/e)^n $ so
 
$$\begin{align*}
h &\geq \lg(n/e)^n\\
    &= n\lg (n/e)\\
    &= n\lg n - n \lg e\\
    &= \Omega (n\lg n) \blacksquare \text{ theorem}
\end{align*}$$

Now prove the lemma:

**_Proof_:** By induction on $h.$

**Basis:**  $h=0$: Here the tree is just one node, which is a leaf (and the root). So $2^h = 1$ and $l=1\leq 2^h$.

**Inductive step:** Assume true for height $=h-1$: $l\leq 2^{h-1}$.  Extend the tree of height $h-1$ by making as many new leaves as possible. Each leaf becomes the parent to two new
leaves. So

$$\begin{align*}
    \text{# of leaves for height } h &= 2\cdot (\text{# of leaves for height }h-1)\\
        &\leq 2\cdot 2^{h-1} \text{(ind. hypothesis)}\\
        &= 2^h \blacksquare \text{ lemma}
\end{align*}$$

**_Corollary:_**  Heapsort and merge sort are asymptotically optimal comparison sorts.

**_Proof_:** The  $O (n\lg n)$ upper bounds on the running times for heapsort and merge sort match the  $\Omega (n\lg n)$ worst-case lower bounds from the Theorem.

︡8883c5e8-cda5-4496-b3e0-d5b8efb72b49︡{"done":true,"md":"\nFor any comparison sort,\n - We get one tree for each $n$.\n - View the tree as if the algorithm splits in two at each node, based on the information it has determined up to that point.\n - The tree models all possible execution traces.\n \n**_Lemma:_** Any binary tree of height $h$ has $\\leq 2^h$ leaves. In other words:\n - $l = \\#$ of leaves\n - then $l\\leq 2^h$\n\n\n(We’ll prove this lemma later.) Why is this useful?\n\n**_Theorem:_** Any decision tree that sorts $n$ elements has height  $\\Omega (n\\lg n)$.\n**_Proof_:**\n - the number of leaves $l\\geq n!$ by Board Work Question 3.\n - $n!\\leq l\\leq  2^h$ by lemma, so $2^h\\geq n!$\n - taking logs: $h \\geq \\lg(n!)$\n - Using Stirling's Approximation (WS04 Section 3.2): $n! > (n/e)^n $ so\n \n$$\\begin{align*}\nh &\\geq \\lg(n/e)^n\\\\\n    &= n\\lg (n/e)\\\\\n    &= n\\lg n - n \\lg e\\\\\n    &= \\Omega (n\\lg n) \\blacksquare \\text{ theorem}\n\\end{align*}$$\n\nNow prove the lemma:\n\n**_Proof_:** By induction on $h.$\n\n**Basis:**  $h=0$: Here the tree is just one node, which is a leaf (and the root). So $2^h = 1$ and $l=1\\leq 2^h$.\n\n**Inductive step:** Assume true for height $=h-1$: $l\\leq 2^{h-1}$.  Extend the tree of height $h-1$ by making as many new leaves as possible. Each leaf becomes the parent to two new\nleaves. So\n\n$$\\begin{align*}\n    \\text{# of leaves for height } h &= 2\\cdot (\\text{# of leaves for height }h-1)\\\\\n        &\\leq 2\\cdot 2^{h-1} \\text{(ind. hypothesis)}\\\\\n        &= 2^h \\blacksquare \\text{ lemma}\n\\end{align*}$$\n\n**_Corollary:_**  Heapsort and merge sort are asymptotically optimal comparison sorts.\n\n**_Proof_:** The  $O (n\\lg n)$ upper bounds on the running times for heapsort and merge sort match the  $\\Omega (n\\lg n)$ worst-case lower bounds from the Theorem."}
︠eb0619c6-c03d-44d9-8fab-2ecc0d074ec6︠

︡e261147d-3a96-437e-a334-9b92c52beb34︡{"done":true}︡









