︠ceae4da6-04a8-4755-aff3-f8b8356ab73fi︠
%md

# 6.3 Building a Heap

### Your name: !!

### 6.1-2 Heaps and max(min)-heaps

#### Heaps

Recall a heap is a nearly complete binary tree.
 - Height of a node = the number of edges on a longest simple path from the node down to a leaf.
 - Height of the heap = the height of the root = $\Theta(\lg n)$.
 
A heap can be stored as an array $A = [1..n]$. When using an array implementation, it is easiest to NOT use the element at index $0$.
 - Root of tree is $A[1]$
 - Parent of $A[i] = A[\lfloor i/2\rfloor]$
 - Left child of $A[i] = A[2i]$
 - Right child of $A[i] = A[2i+1]$
 - Computing is fast with binary representation implementation.
 
#### Heap property

- For <u>max-heaps</u> (largest element at the root): 
   - _<u>max-heap property</u>_: for all nodes $i$, excluding the root, $A[Parent(i)] \geq A[i]$
 - For <u>min-heaps</u> (smallest element at the root): 
   - _<u>min-heap property</u>_: for all nodes $i$, excluding the root, $A[Parent(i)] \leq A[i]$
   
#### Maintaining the heap order

MAX-HEAPIFY is important for manipulating max-heaps. It is used to maintain the max-heap property.

 - Before MAX-HEAPIFY, $A[i]$ may be smaller than its children
 - Assume LEFT(i) and RIGHT(i) are max-heaps, but $A[i]$ might be smaller than it's children.
 - After MAX-HEAPIFY, subtree rooted at $i$ is a max-heap.
 
## 6.3 Building a Heap

The following procedure, given an unordered array, will produce a max-heap:
︡fde8c0cc-0f5e-46dd-b054-d3dc3e448c5c︡{"done":true,"md":"\n# 6.3 Building a Heap\n\n### Your name: !!\n\n### 6.1-2 Heaps and max(min)-heaps\n\n#### Heaps\n\nRecall a heap is a nearly complete binary tree.\n - Height of a node = the number of edges on a longest simple path from the node down to a leaf.\n - Height of the heap = the height of the root = $\\Theta(\\lg n)$.\n \nA heap can be stored as an array $A = [1..n]$. When using an array implementation, it is easiest to NOT use the element at index $0$.\n - Root of tree is $A[1]$\n - Parent of $A[i] = A[\\lfloor i/2\\rfloor]$\n - Left child of $A[i] = A[2i]$\n - Right child of $A[i] = A[2i+1]$\n - Computing is fast with binary representation implementation.\n \n#### Heap property\n\n- For <u>max-heaps</u> (largest element at the root): \n   - _<u>max-heap property</u>_: for all nodes $i$, excluding the root, $A[Parent(i)] \\geq A[i]$\n - For <u>min-heaps</u> (smallest element at the root): \n   - _<u>min-heap property</u>_: for all nodes $i$, excluding the root, $A[Parent(i)] \\leq A[i]$\n   \n#### Maintaining the heap order\n\nMAX-HEAPIFY is important for manipulating max-heaps. It is used to maintain the max-heap property.\n\n - Before MAX-HEAPIFY, $A[i]$ may be smaller than its children\n - Assume LEFT(i) and RIGHT(i) are max-heaps, but $A[i]$ might be smaller than it's children.\n - After MAX-HEAPIFY, subtree rooted at $i$ is a max-heap.\n \n## 6.3 Building a Heap\n\nThe following procedure, given an unordered array, will produce a max-heap:"}
︠708dac68-20cb-4f64-9f79-029d8ed49760os︠

####### Do not run :)######
#pseudocode                                     

BUILD-MAX-HEAP(A,n)
for i = n/2 downto 1:
    MAX-HEAPIFY(A,i,n)
    
####### Do not run :)######
︡e9d2f43b-dcad-4561-ab61-a762b94419e6︡{"done":true}
︠41012abf-e8c8-4688-99a4-54d3ee37533ci︠
%md 

Example (finish in class): 

BUILD-MAX-HEAP(A,10) for $A=[4,1,3,2,16,9,10,14,8,7]$
 - initially $i = n/2 = 10/2 = 5$
 - MAX-HEAPIFY is applied to subtrees rooted at nodes (in order): $16, 2, 3, 1, 4$
 
 
## Correctness

_**Loop invariant for BUILD-MAX-HEAP:**_


> At start of every iteration of for loop, each node $i+1, i+2, ..., n$, is the root of a max-heap.


1. **Initialization:** Prior to the ﬁrst iteration of the loop, $i = \lfloor n/2 \rfloor$.  Each node $i+1, i+2, ..., n$ is a leaf (why?) and is thus the root of a trivial max-heap.
2. **Maintenance:** Children of node $i$ are indexed higher than $i$ , so loop invariant $\implies$ they are both roots of max-heaps. Correctly assuming that $i+1, i+2, ..., n$ are all roots of max-heaps, MAX-HEAPIFY makes node $i$ a max-heap root. Decrementing $i$ reestablishes the loop invariant at each iteration.
3. **Termination:** When $i = 0$, the loop terminates. By the loop invariant, each node $i+1, ..., n$, notably node $1$, is the root of a max-heap.

## Analysis

**_Simple bound:_** $O(n)$ calls to MAX-HEAPIFY, each of which takes $O(\lg n)$ time $\implies O(n\lg n).$ (Note: A good approach to analysis in general is to start by proving easy bound, then try to tighten it.)

**_Tighter bound:_** 
 - Observe the time to run MAX-HEAPIFY is linear in the height of the node it’s run on, and most nodes have small heights.  
 - Exercise 6.3-3 $\implies \leq \lceil n/2^{h+1} \rceil$ nodes of height $h$.
 - Exercise 6.1-2 $\implies$ the height of the heap is $\lfloor \lg n \rfloor$.
 - Time required by MAX-HEAPIFY when called on a node of height $h$ is $O(h)$, so the total cost of BUILD-MAX-HEAP is
 $$\sum\limits_{h=0}^{\lfloor \lg n \rfloor} \lceil \frac{n}{2^{h+1}} \rceil O(h)= O\left(n \sum\limits_{h=0}^{\lfloor \lg n \rfloor } \frac{h}{2^{h}}\right) $$
 - Formula (A.8) pg 1148:  $\sum\limits_{k=0}^{\infty} kx^k = \dfrac{x}{(1-x)^2}$ for $-1 < x < 1$.
 - Evaluate the summation for MAX-HEAPIFY time using (A.8) with $x = 1/2 \implies \sum\limits_{h=0}^{\infty} \frac{h}{2^{h}} = \dfrac{1/2}{(1-1/2)^2} = 2$.
 - Thus, the running time of BUILD-MAX-HEAP is $O(n)$ !!
︡b404f10d-1daf-4a46-bd13-433e867b7065︡{"done":true,"md":"\nExample (finish in class): \n\nBUILD-MAX-HEAP(A,10) for $A=[4,1,3,2,16,9,10,14,8,7]$\n - initially $i = n/2 = 10/2 = 5$\n - MAX-HEAPIFY is applied to subtrees rooted at nodes (in order): $16, 2, 3, 1, 4$\n \n \n## Correctness\n\n_**Loop invariant for BUILD-MAX-HEAP:**_\n\n\n> At start of every iteration of for loop, each node $i+1, i+2, ..., n$, is the root of a max-heap.\n\n\n1. **Initialization:** Prior to the ﬁrst iteration of the loop, $i = \\lfloor n/2 \\rfloor$.  Each node $i+1, i+2, ..., n$ is a leaf (why?) and is thus the root of a trivial max-heap.\n2. **Maintenance:** Children of node $i$ are indexed higher than $i$ , so loop invariant $\\implies$ they are both roots of max-heaps. Correctly assuming that $i+1, i+2, ..., n$ are all roots of max-heaps, MAX-HEAPIFY makes node $i$ a max-heap root. Decrementing $i$ reestablishes the loop invariant at each iteration.\n3. **Termination:** When $i = 0$, the loop terminates. By the loop invariant, each node $i+1, ..., n$, notably node $1$, is the root of a max-heap.\n\n## Analysis\n\n**_Simple bound:_** $O(n)$ calls to MAX-HEAPIFY, each of which takes $O(\\lg n)$ time $\\implies O(n\\lg n).$ (Note: A good approach to analysis in general is to start by proving easy bound, then try to tighten it.)\n\n**_Tighter bound:_** \n - Observe the time to run MAX-HEAPIFY is linear in the height of the node it’s run on, and most nodes have small heights.  \n - Exercise 6.3-3 $\\implies \\leq \\lceil n/2^{h+1} \\rceil$ nodes of height $h$.\n - Exercise 6.1-2 $\\implies$ the height of the heap is $\\lfloor \\lg n \\rfloor$.\n - Time required by MAX-HEAPIFY when called on a node of height $h$ is $O(h)$, so the total cost of BUILD-MAX-HEAP is\n $$\\sum\\limits_{h=0}^{\\lfloor \\lg n \\rfloor} \\lceil \\frac{n}{2^{h+1}} \\rceil O(h)= O\\left(n \\sum\\limits_{h=0}^{\\lfloor \\lg n \\rfloor } \\frac{h}{2^{h}}\\right) $$\n - Formula (A.8) pg 1148:  $\\sum\\limits_{k=0}^{\\infty} kx^k = \\dfrac{x}{(1-x)^2}$ for $-1 < x < 1$.\n - Evaluate the summation for MAX-HEAPIFY time using (A.8) with $x = 1/2 \\implies \\sum\\limits_{h=0}^{\\infty} \\frac{h}{2^{h}} = \\dfrac{1/2}{(1-1/2)^2} = 2$.\n - Thus, the running time of BUILD-MAX-HEAP is $O(n)$ !!"}
︠6968ebbe-de46-4f76-b6f5-ceb72a5c01ca︠
%md

 **At the boards:** Using Figure 6.3 as a model, illustrate the operation of  BUILD-MAX-HEAP on the array  $A = (5, 3, 17, 10, 84, 19, 6, 22, 9)$.  Write your complete solution in lucidchart and share your link in your opening comments in max_heap.cpp.  Include your name(s) in the lucidchart document.
 
When you are done, in CoCalc Workshop WS09: 6.3-Max_Heap, write a program max_heap.cpp that ultimately implements and
demonstrates the BUILD-MAX-HEAP(A,n) pseudocode on page 157.

See ws09_max_heap.pdf in CoCalc for specifications.
︡50166590-4ada-47ef-bd6b-0775d8928fc5︡{"done":true,"md":"\n **At the boards:** Using Figure 6.3 as a model, illustrate the operation of  BUILD-MAX-HEAP on the array  $A = (5, 3, 17, 10, 84, 19, 6, 22, 9)$.  Write your complete solution in lucidchart and share your link in your opening comments in max_heap.cpp.  Include your name(s) in the lucidchart document.\n \nWhen you are done, in CoCalc Workshop WS09: 6.3-Max_Heap, write a program max_heap.cpp that ultimately implements and\ndemonstrates the BUILD-MAX-HEAP(A,n) pseudocode on page 157.\n\nSee ws09_max_heap.pdf in CoCalc for specifications."}
 











