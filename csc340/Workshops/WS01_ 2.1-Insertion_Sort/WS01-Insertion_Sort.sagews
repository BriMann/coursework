︠049a91c4-3d15-4a4d-9bc3-d510aa9fba15i︠
%md

# WS01: 2.1 Insertion Sort

### Dr. Danielson

Recall the sorting problem from last time:

**Example: Sorting Problem**

 - **Input:** A sequence of $n$ numbers $A = (a_1,a_2,\dots, a_n)$
 - **Output:** A permutation/reordering $(a_1', a_2',\cdots, a_n')$ of the input set $A$ with $a_1'\leq a_2'\leq \cdots \leq a_n'$
 

 - The sequences will be stored in vectors/arrays
 - We also refer to the numbers $a_1,a_2,\dots, a_n$ as **_keys_** (which may have satellite data not relevant to sorting)
 
#### Expressing Algorithms

 - sometimes English is the best way
 - mostly we'll use **_pseudocode_** -similar to C++/Java/python but designed for expressing algorithms to humans
     - ignore data abstraction, modularity, error handling
     - won't compile

### <u>Insertion Sort</u>
 - good for sorting small sets
 - works like sorting a hand of playing cards
 - Visualization: https://www.hackerearth.com/practice/algorithms/sorting/insertion-sort/visualize/
 
#### Psuedocode

 - (functionality notes) takes a parameter an array/vector $A[1..n]$ (authors use 1-based indexing)
 - vector $A$ is sorted <u>in place</u>-numbers rearranged within the vector
 - input array $A$ contains the sorted output sequence when INSERTION-SORT is finished

<img src='images/02_01_insertion_sort_pseudo.PNG' width=50% />


##### Example Figure 2.2
https://lucid.app/lucidchart/invitations/accept/c4745b7a-681d-4527-a1bd-2adf0e9440cc

Notes:

 - $j$ indexes the current key being inserted
 - elements to the left of $A[j]$ that are GREATER than $A[j]$ move one position to the right and $A[j]$ moves in to the evacuted position


︡fc119524-1102-4a01-b36d-9f9ab5c5d250︡{"done":true,"md":"\n# WS01: 2.1 Insertion Sort\n\n### Dr. Danielson\n\nRecall the sorting problem from last time:\n\n**Example: Sorting Problem**\n\n - **Input:** A sequence of $n$ numbers $A = (a_1,a_2,\\dots, a_n)$\n - **Output:** A permutation/reordering $(a_1', a_2',\\cdots, a_n')$ of the input set $A$ with $a_1'\\leq a_2'\\leq \\cdots \\leq a_n'$\n \n\n - The sequences will be stored in vectors/arrays\n - We also refer to the numbers $a_1,a_2,\\dots, a_n$ as **_keys_** (which may have satellite data not relevant to sorting)\n \n#### Expressing Algorithms\n\n - sometimes English is the best way\n - mostly we'll use **_pseudocode_** -similar to C++/Java/python but designed for expressing algorithms to humans\n     - ignore data abstraction, modularity, error handling\n     - won't compile\n\n### <u>Insertion Sort</u>\n - good for sorting small sets\n - works like sorting a hand of playing cards\n - Visualization: https://www.hackerearth.com/practice/algorithms/sorting/insertion-sort/visualize/\n \n#### Psuedocode\n\n - (functionality notes) takes a parameter an array/vector $A[1..n]$ (authors use 1-based indexing)\n - vector $A$ is sorted <u>in place</u>-numbers rearranged within the vector\n - input array $A$ contains the sorted output sequence when INSERTION-SORT is finished\n\n<img src='images/02_01_insertion_sort_pseudo.PNG' width=50% />\n\n\n##### Example Figure 2.2\nhttps://lucid.app/lucidchart/invitations/accept/c4745b7a-681d-4527-a1bd-2adf0e9440cc\n\nNotes:\n\n - $j$ indexes the current key being inserted\n - elements to the left of $A[j]$ that are GREATER than $A[j]$ move one position to the right and $A[j]$ moves in to the evacuted position"}
︠f31771c8-b881-4cff-8a23-26d203179e73o︠
%md

**At the boards in groups:**  Using Figure 2.2 as a model, illustrate the operation of INSERTION-SORT on the array

$$A = <31, 41, 59, 26, 41, 58>.$$



︡9488f78c-af2c-4c32-bee4-d2679f478541︡{"done":true,"md":"\n**At the boards in groups:**  Using Figure 2.2 as a model, illustrate the operation of INSERTION-SORT on the array\n\n$$A = <31, 41, 59, 26, 41, 58>.$$"}
︠a804999e-9bef-4989-896e-db8e6917d723i︠
%md
### Loop invariants and the correctness of insertion sort

It's hard in general to keep track of what happens in loops-we often use <u>loop invariants</u> to help understand why an algorithm gives the correct answer.

A **loop invariant** is a formal statement about the relationship between the variables which holds true before the loop is ever run (establishing the invariant) and is true again at the bottom of the loop (maintaining the invariant). 

_**Loop invariant for INSERTION-SORT:**_


> At the start of each iteration of the outer for loop (the loop indexed by $j$), the subarray $A[1..j-1]$ consists of the elements originally in $A[1..j-1]$, but in sorted order.

To use a loop invariant to prove correctness we must show 3 things:


1. **Initialization:** It is true prior to the ﬁrst iteration of the loop.
2. **Maintenance:** If it is true before an iteration of the loop, it remains true before the next iteration.
3. **Termination:** When the loop terminates, the invariant gives us a useful property that helps show that the algorithm is correct.

The first two steps are similar to mathematical induction: 

1. **Initialization:** Is like the base case (show true for the first case)
2. **Maintenance:** Like the inductive step


**Termination:** This differs from induction (where we would apply the inductive setp infinitely).  For loop invariants, we stop the "induction" when the loop terminates.

### <u>Correctness of Insertion Sort</u>

<img src='images/02_01_insertion_sort_pseudo.PNG' width=50% />

_**Loop invariant for INSERTION-SORT:**_

> At the start of each iteration of the outer for loop (the loop indexed by $j$), the subarray $A[1..j-1]$ consists of the elements originally in $A[1..j-1]$, but in sorted order.

1. **Initialization:** We start by showing the loop invariant holds before the first loop iteration when $j=2.$  The subarray $A[1..j-1] = A[1]$ which is trivialy sorted. This shows the loop invariant holds prior to the ﬁrst iteration of the loop. $\checkmark$
2. **Maintenance:** Technically we should state and prove a loop invariant for the inner while loop-try this as home! Informally, note that the body of the while loop works by moving $A[j-1], A[j-2]$, and so on by one position right until the correct position for the key $= A[j]$ is found.  At that point the key is placed in position. The subarray $A[1..j]$ consists of the elements originally in $A[1..j]$, but in sorted order. Incrementing $j$ for the next iteration of the **for** loop then preserves the loop invariant. $\checkmark$
3. **Termination:** The outer **for** loop ends when $j > A.length = n$. Because each loop iteration increments $j$ by 1, we must have $j=n+1$. Substituting $j=n+1$ in the wording of loop invariant, we have the subarray $A[1..n]$ consists of the elements originally in $A[1..n]$, but in sorted order. Thus the entire array is sorted. Hence, the algorithm is correct. $\checkmark$
︡a07d8ebb-b252-4c48-bef3-be5ca1126dbf︡{"done":true,"md":"### Loop invariants and the correctness of insertion sort\n\nIt's hard in general to keep track of what happens in loops-we often use <u>loop invariants</u> to help understand why an algorithm gives the correct answer.\n\nA **loop invariant** is a formal statement about the relationship between the variables which holds true before the loop is ever run (establishing the invariant) and is true again at the bottom of the loop (maintaining the invariant). \n\n_**Loop invariant for INSERTION-SORT:**_\n\n\n> At the start of each iteration of the outer for loop (the loop indexed by $j$), the subarray $A[1..j-1]$ consists of the elements originally in $A[1..j-1]$, but in sorted order.\n\nTo use a loop invariant to prove correctness we must show 3 things:\n\n\n1. **Initialization:** It is true prior to the ﬁrst iteration of the loop.\n2. **Maintenance:** If it is true before an iteration of the loop, it remains true before the next iteration.\n3. **Termination:** When the loop terminates, the invariant gives us a useful property that helps show that the algorithm is correct.\n\nThe first two steps are similar to mathematical induction: \n\n1. **Initialization:** Is like the base case (show true for the first case)\n2. **Maintenance:** Like the inductive step\n\n\n**Termination:** This differs from induction (where we would apply the inductive setp infinitely).  For loop invariants, we stop the \"induction\" when the loop terminates.\n\n### <u>Correctness of Insertion Sort</u>\n\n<img src='images/02_01_insertion_sort_pseudo.PNG' width=50% />\n\n_**Loop invariant for INSERTION-SORT:**_\n\n> At the start of each iteration of the outer for loop (the loop indexed by $j$), the subarray $A[1..j-1]$ consists of the elements originally in $A[1..j-1]$, but in sorted order.\n\n1. **Initialization:** We start by showing the loop invariant holds before the first loop iteration when $j=2.$  The subarray $A[1..j-1] = A[1]$ which is trivialy sorted. This shows the loop invariant holds prior to the ﬁrst iteration of the loop. $\\checkmark$\n2. **Maintenance:** Technically we should state and prove a loop invariant for the inner while loop-try this as home! Informally, note that the body of the while loop works by moving $A[j-1], A[j-2]$, and so on by one position right until the correct position for the key $= A[j]$ is found.  At that point the key is placed in position. The subarray $A[1..j]$ consists of the elements originally in $A[1..j]$, but in sorted order. Incrementing $j$ for the next iteration of the **for** loop then preserves the loop invariant. $\\checkmark$\n3. **Termination:** The outer **for** loop ends when $j > A.length = n$. Because each loop iteration increments $j$ by 1, we must have $j=n+1$. Substituting $j=n+1$ in the wording of loop invariant, we have the subarray $A[1..n]$ consists of the elements originally in $A[1..n]$, but in sorted order. Thus the entire array is sorted. Hence, the algorithm is correct. $\\checkmark$"}
︠72608de6-def9-4a81-b86c-958d96e5522ai︠
%md
#### Pseudocode conventions

 - Indentation indicates block structure. This saves space and writing time.
 - Looping constructs such as **while**, **for**, and the **if-else** conditional construct have interpretations similar to those in C++, Java, and Python. In this book, the loop counter retains its value after exiting the loop (declared outside the for loop).
  - "//" indicates the remainder of the line is a comment
  - Variables (such as $i$, $j$ ,and $key$) are local to the given procedure
  - Use objects with attributes: $x.attr$ as in $A.length$
  - Objects are treated as references (as in Java)
  - Parameters are passed by value-the procedure recieves its own copy of the parameter
    - arrays are passed by pointer/reference
  - Allow multiple values to be returned with a single return
  - bool paramaters $and$ and $or$ are short circuiting-if $x$ is false, "$x \text{ and } y$" is false when $x$ is evaluated, so we don't evaluate $y$

︡39faa54a-55e5-44f3-ac9d-9664b357e1ed︡{"done":true,"md":"#### Pseudocode conventions\n\n - Indentation indicates block structure. This saves space and writing time.\n - Looping constructs such as **while**, **for**, and the **if-else** conditional construct have interpretations similar to those in C++, Java, and Python. In this book, the loop counter retains its value after exiting the loop (declared outside the for loop).\n  - \"//\" indicates the remainder of the line is a comment\n  - Variables (such as $i$, $j$ ,and $key$) are local to the given procedure\n  - Use objects with attributes: $x.attr$ as in $A.length$\n  - Objects are treated as references (as in Java)\n  - Parameters are passed by value-the procedure recieves its own copy of the parameter\n    - arrays are passed by pointer/reference\n  - Allow multiple values to be returned with a single return\n  - bool paramaters $and$ and $or$ are short circuiting-if $x$ is false, \"$x \\text{ and } y$\" is false when $x$ is evaluated, so we don't evaluate $y$"}
︠1a398d4d-c313-4a64-9d38-c03c7403dfb3i︠
%md

**Complete Workshop01: 2.1-Insertion sort:** Write a program insertion_sort.cpp that implements and demonstrates the insertion sort pseudocode on page 18.

See ws01.pdf in CoCalc for specifications.
︡f363f800-f015-45ae-aeb0-a55c93c45def︡{"done":true,"md":"\n**Complete Workshop01: 2.1-Insertion sort:** Write a program insertion_sort.cpp that implements and demonstrates the insertion sort pseudocode on page 18.\n\nSee ws01.pdf in CoCalc for specifications."}










