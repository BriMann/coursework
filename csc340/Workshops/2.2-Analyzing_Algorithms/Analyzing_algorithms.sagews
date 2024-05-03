︠486b04d3-754b-4172-becc-7cbeb68e5741i︠
%md

# 2.2 Analyzing algorithms

### Your name: Dr. Danielson

_**Analyzing**_ an algorithm means predicting the resources that the algorithm requires.

 - usually running time
 - we need a computational model
 
## Random-access machine (RAM) model

 - instructions are executed one after another-no concurrent operations
   - too tedious to define each instruction and the associated cost, instead
 - we consider how real computers are designed and we'll use <u>common instructions</u>
   - arithmetic: add, subtract, multiply, divide, remainder, ﬂoor, ceiling
   - data movement: load, store, copy
   - control: conditional and unconditional branch,subroutine call and return
 - each common instruction takes a constant amount of time
 - data types are integer and ﬂoating point (for storing real numbers)
   - we don't worry about precision (unlike in Numerical Analysis)
   - we assume a  limit on the size of each word of data
     - for example, when working with inputs of size $n$, assume integers are represented by $ c \lg n$ bits for some constant $c \geq 1$
     
## How do we analyze running times?

The time taken depends on the input size.
  - sorting 1000 numbers takes longer than sorting 3 numbers
  - a given sorting algorithm may even take differing time on 2 inputs of the same size
    - for example, insertion-sort takes less time to sort $n$ elements when already sorted versus in reverse order
    
### <u>Input Size</u>

Depends on the problem being considered.
 - usually number of items in the input, like the array size $n$ for sorting
 - or if multiplying two integers, the total number of bits in the two ints
 - or even with two numbers rather than one, like the number of vertices and edges in a graph

### <u>Running Time</u>
This is the number of primitive operations/steps executed on a particular input.

 - desire to deﬁne steps to be machine-independent 
 - assume each line of pseudocode requires constant time
 - one line may take different time, but line $i$ takes $c_i$ time
 - this assumes a line contains only primitive operations
   - Note: if a subroutine is called, the actual call is constant but the execution of the subroutine may not be

︡970a15be-afc9-4e3f-ab76-5545d294c55d︡{"done":true,"md":"\n# 2.2 Analyzing algorithms\n\n### Your name: Dr. Danielson\n\n_**Analyzing**_ an algorithm means predicting the resources that the algorithm requires.\n\n - usually running time\n - we need a computational model\n \n## Random-access machine (RAM) model\n\n - instructions are executed one after another-no concurrent operations\n   - too tedious to define each instruction and the associated cost, instead\n - we consider how real computers are designed and we'll use <u>common instructions</u>\n   - arithmetic: add, subtract, multiply, divide, remainder, ﬂoor, ceiling\n   - data movement: load, store, copy\n   - control: conditional and unconditional branch,subroutine call and return\n - each common instruction takes a constant amount of time\n - data types are integer and ﬂoating point (for storing real numbers)\n   - we don't worry about precision (unlike in Numerical Analysis)\n   - we assume a  limit on the size of each word of data\n     - for example, when working with inputs of size $n$, assume integers are represented by $ c \\lg n$ bits for some constant $c \\geq 1$\n     \n## How do we analyze running times?\n\nThe time taken depends on the input size.\n  - sorting 1000 numbers takes longer than sorting 3 numbers\n  - a given sorting algorithm may even take differing time on 2 inputs of the same size\n    - for example, insertion-sort takes less time to sort $n$ elements when already sorted versus in reverse order\n    \n### <u>Input Size</u>\n\nDepends on the problem being considered.\n - usually number of items in the input, like the array size $n$ for sorting\n - or if multiplying two integers, the total number of bits in the two ints\n - or even with two numbers rather than one, like the number of vertices and edges in a graph\n\n### <u>Running Time</u>\nThis is the number of primitive operations/steps executed on a particular input.\n\n - desire to deﬁne steps to be machine-independent \n - assume each line of pseudocode requires constant time\n - one line may take different time, but line $i$ takes $c_i$ time\n - this assumes a line contains only primitive operations\n   - Note: if a subroutine is called, the actual call is constant but the execution of the subroutine may not be"}
︠1f6b0b34-0b25-406f-92ea-69a25e7a43d3i︠
%md
## Analysis of Insertion-Sort

<img src='images/02_01_insertion_sort_pseudo.PNG' width=30% />


 - assume that the $i$th line takes time $c_i$, which is a constant
 - note: when a **for** or **while** loop exits in the usual way (due to the test condition in the header), the test executes one more time than the body of the loop
   - line 1 executes for $j = 2 \text{ to } (n) + 1 $ times which is $n$ times, and lines 2-4 and 8 execute $n-1$ times
   - at line 5: let $t_j$ be the number of times the **while** loop test is executed for that value of $j$, then
     - for  $j = 2 \text{ to } n $ we have to add up the $t_j$ times for the outer loop test, and
     - for  $j = 2 \text{ to } n $ we have to add up the $t_j - 1$ times for the inner loop lines
     
<img src='images/02_02_insertion_sort_running_times.PNG' width=40% />

The running time of the algorithm is

$$\sum_{\text{all statements}} (\text{cost of statement})\cdot (\text{number of times statement is executed}) = T(n)$$

$$T(n) = c_1\cdot n + c_2\cdot (n-1) + c_4\cdot (n-1)  + c_5\cdot \sum_{j=2}^{n} t_j + c_6\cdot \sum_{j=2}^{n} (t_j - 1) + c_7\cdot \sum_{j=2}^{n} (t_j - 1) + c_8\cdot (n-1)$$

The running time depends on the values of $t_j$. These vary according to the input.

︡c7d1211a-1c8c-41f0-8718-b2994091a8a8︡{"done":true,"md":"## Analysis of Insertion-Sort\n\n<img src='images/02_01_insertion_sort_pseudo.PNG' width=30% />\n\n\n - assume that the $i$th line takes time $c_i$, which is a constant\n - note: when a **for** or **while** loop exits in the usual way (due to the test condition in the header), the test executes one more time than the body of the loop\n   - line 1 executes for $j = 2 \\text{ to } (n) + 1 $ times which is $n$ times, and lines 2-4 and 8 execute $n-1$ times\n   - at line 5: let $t_j$ be the number of times the **while** loop test is executed for that value of $j$, then\n     - for  $j = 2 \\text{ to } n $ we have to add up the $t_j$ times for the outer loop test, and\n     - for  $j = 2 \\text{ to } n $ we have to add up the $t_j - 1$ times for the inner loop lines\n     \n<img src='images/02_02_insertion_sort_running_times.PNG' width=40% />\n\nThe running time of the algorithm is\n\n$$\\sum_{\\text{all statements}} (\\text{cost of statement})\\cdot (\\text{number of times statement is executed}) = T(n)$$\n\n$$T(n) = c_1\\cdot n + c_2\\cdot (n-1) + c_4\\cdot (n-1)  + c_5\\cdot \\sum_{j=2}^{n} t_j + c_6\\cdot \\sum_{j=2}^{n} (t_j - 1) + c_7\\cdot \\sum_{j=2}^{n} (t_j - 1) + c_8\\cdot (n-1)$$\n\nThe running time depends on the values of $t_j$. These vary according to the input."}
︠12e3cedf-e946-44af-bc7a-a957e4ac84dci︠
%md

#### _Best case_

The array is already sorted.
  - Always $A[i] \leq key$ upon the first time the **while** loop test is run (when $i = j-1$)
  - All $t_j = 1$
  - Best running time is then
  $$T_B(n) = c_1 n + c_2 (n-1) + c_4 (n-1)  + c_5 (n-1) + c_6\cdot 0 + c_7\cdot 0 + c_8 (n-1) = (c_1 + c_2 + c_4 + c_5 + c_8) n - (c_2 + c_4 + c_5 + c_8) $$
  - Then $T_B(n) = an + b$ for constants $a,b \implies T_B(n)$ is a <u>linear</u> function of $n$

_**Demonstrate this in Runstone in class**_
  
<img src='images/02_02_insertion_sort_running_times.PNG' width=40% />

#### _Worst case_

The array is in reverse sorted order.
  - Always find  $A[i] > key$ in the **while** loop test
  - Have to compare $key$ with all elements to the left of the $j$th position $\implies$ compare with all elements of $A[1..j-1]$ or with $j-1$ elements
  - Since the **while** loop exits because $i$ reaches 0, there is one additional test after the $j-1$ tests  $\implies t_j = j$
  - $\sum_{j=2}^n t_j = \sum_{j=2}^n j$ and $\sum_{j=2}^n (t_j - 1) = \sum_{j=2}^n (j - 1)$
  - Recall $\sum_{j=1}^n j$ is an arithmetic series:
    - $\sum_{j=1}^n j = 1 + 2 + 3 + \cdots + n = S$
    - and $S = n + (n-1) + (n-2) + \cdots + 1$
    - so $2S = (n+1)n$ and thus $S = \dfrac{n(n+1)}{2}$
  - Then $\sum_{j=2}^n j = (\sum_{j=1}^n j) - 1 = \dfrac{n(n+1)}{2} - 1$
  - And $\sum_{j=2}^n (j - 1) = 1 + 2 + \cdots + n - 1 = \sum_{j=1}^{n-1} j = \dfrac{(n-1)(n)}{2}$
  - Worst running time is then
  $$T_W(n) = c_1 n + c_2 (n-1) + c_4 (n-1)  + c_5 \left( \dfrac{n(n+1)}{2} -1\right) + c_6\cdot \dfrac{(n-1)(n)}{2} + c_7\cdot \dfrac{(n-1)(n)}{2} + c_8 (n-1)$$
  $$ T_W(n) = c_1 n + c_2 (n-1) + c_4 (n-1)  + c_5 \left( \dfrac{n^2 + n}{2} -1\right) + c_6\cdot \dfrac{n^2 - n}{2} + c_7\cdot \dfrac{n^2 -n}{2} + c_8 (n-1)$$
  $$ T_W(n) = \left( \dfrac{c_5}{2} + \dfrac{c_6}{2} + \dfrac{c_7}{2}\right)n^2 + \left( c_1 + c_2 + c_4 + \dfrac{c_5}{2} - \dfrac{c_6}{2} - \dfrac{c_7}{2} + c_8 \right)n -(c_2 + c_4 + c_5 + c_8) $$
  - Then $T_W(n) = an^2 + bn + c$ for constants $a,b, c \implies T_W(n)$ is a <u>quadratic</u> function of $n$

_**Demonstrate this in Runstone in class**_  
︡eb9a7167-44f5-4ba2-ae50-1d78c8601b9f︡{"done":true,"md":"\n#### _Best case_\n\nThe array is already sorted.\n  - Always $A[i] \\leq key$ upon the first time the **while** loop test is run (when $i = j-1$)\n  - All $t_j = 1$\n  - Best running time is then\n  $$T_B(n) = c_1 n + c_2 (n-1) + c_4 (n-1)  + c_5 (n-1) + c_6\\cdot 0 + c_7\\cdot 0 + c_8 (n-1) = (c_1 + c_2 + c_4 + c_5 + c_8) n - (c_2 + c_4 + c_5 + c_8) $$\n  - Then $T_B(n) = an + b$ for constants $a,b \\implies T_B(n)$ is a <u>linear</u> function of $n$\n\n_**Demonstrate this in Runstone in class**_\n  \n<img src='images/02_02_insertion_sort_running_times.PNG' width=40% />\n\n#### _Worst case_\n\nThe array is in reverse sorted order.\n  - Always find  $A[i] > key$ in the **while** loop test\n  - Have to compare $key$ with all elements to the left of the $j$th position $\\implies$ compare with all elements of $A[1..j-1]$ or with $j-1$ elements\n  - Since the **while** loop exits because $i$ reaches 0, there is one additional test after the $j-1$ tests  $\\implies t_j = j$\n  - $\\sum_{j=2}^n t_j = \\sum_{j=2}^n j$ and $\\sum_{j=2}^n (t_j - 1) = \\sum_{j=2}^n (j - 1)$\n  - Recall $\\sum_{j=1}^n j$ is an arithmetic series:\n    - $\\sum_{j=1}^n j = 1 + 2 + 3 + \\cdots + n = S$\n    - and $S = n + (n-1) + (n-2) + \\cdots + 1$\n    - so $2S = (n+1)n$ and thus $S = \\dfrac{n(n+1)}{2}$\n  - Then $\\sum_{j=2}^n j = (\\sum_{j=1}^n j) - 1 = \\dfrac{n(n+1)}{2} - 1$\n  - And $\\sum_{j=2}^n (j - 1) = 1 + 2 + \\cdots + n - 1 = \\sum_{j=1}^{n-1} j = \\dfrac{(n-1)(n)}{2}$\n  - Worst running time is then\n  $$T_W(n) = c_1 n + c_2 (n-1) + c_4 (n-1)  + c_5 \\left( \\dfrac{n(n+1)}{2} -1\\right) + c_6\\cdot \\dfrac{(n-1)(n)}{2} + c_7\\cdot \\dfrac{(n-1)(n)}{2} + c_8 (n-1)$$\n  $$ T_W(n) = c_1 n + c_2 (n-1) + c_4 (n-1)  + c_5 \\left( \\dfrac{n^2 + n}{2} -1\\right) + c_6\\cdot \\dfrac{n^2 - n}{2} + c_7\\cdot \\dfrac{n^2 -n}{2} + c_8 (n-1)$$\n  $$ T_W(n) = \\left( \\dfrac{c_5}{2} + \\dfrac{c_6}{2} + \\dfrac{c_7}{2}\\right)n^2 + \\left( c_1 + c_2 + c_4 + \\dfrac{c_5}{2} - \\dfrac{c_6}{2} - \\dfrac{c_7}{2} + c_8 \\right)n -(c_2 + c_4 + c_5 + c_8) $$\n  - Then $T_W(n) = an^2 + bn + c$ for constants $a,b, c \\implies T_W(n)$ is a <u>quadratic</u> function of $n$\n\n_**Demonstrate this in Runstone in class**_"}
︠aba5dbbc-27ad-4a72-a068-7bb51aa5a9edi︠
%md
#### Worst-case and average-case analysis
We usually focus on worst-case running time: the longest running time for any input of size $n$.
 - gives upper bound on time for any input
 - worst-case often occurs for some algorithms 
   - for example, when searching, and the item is not present
 - Why not analyze the average case? Because it’s often about as bad as the worst case.
   - for example, if we randomly choose $n$ numbers to sort for insertion sort, on average the $key = A[j]$ is less than half of the elements in $A[1..j-1]$ and it's greater than the other half $\implies$ on average, the **while** loop has to look halfway through the sorted subarray $A[1..j-1]$ to find the correct spot for the $key$ $\implies t_j \approx j/2$...Although the average-case running time is approximately half of the worst-case running time, it’s still a quadratic function of $n$.
   
#### Order of growth
This is another abstraction to ease analysis and allows us to focus on the important features.

Idea: Look only at the leading term of the formula for running time.

 - Drop lower-order terms.
 - Ignore the constant coefficient in the leading term.

_Example:_ For insertion sort, we already abstracted away the actual statement costs $c_i$ to conclude that the worst-case running time is  $T_W(n) = an^2 + bn + c$.

Drop lower-order terms $\implies an^2$

Ignore the constant coefficient  $\implies n^2$

We say $T_W(n)$ grows like $n^2$ or $T_W(n) = \Theta(n^2)$ ("theta of $n$-squared"). 

$\Theta(n^2) $ captures the notion that the _order of growth is_ $n^2$.

We usually consider one algorithm to be more efficient than another if its worst-case running time has a smaller order of growth.

︡85e08257-db2c-41e3-930b-8b94f15110d9︡{"done":true,"md":"#### Worst-case and average-case analysis\nWe usually focus on worst-case running time: the longest running time for any input of size $n$.\n - gives upper bound on time for any input\n - worst-case often occurs for some algorithms \n   - for example, when searching, and the item is not present\n - Why not analyze the average case? Because it’s often about as bad as the worst case.\n   - for example, if we randomly choose $n$ numbers to sort for insertion sort, on average the $key = A[j]$ is less than half of the elements in $A[1..j-1]$ and it's greater than the other half $\\implies$ on average, the **while** loop has to look halfway through the sorted subarray $A[1..j-1]$ to find the correct spot for the $key$ $\\implies t_j \\approx j/2$...Although the average-case running time is approximately half of the worst-case running time, it’s still a quadratic function of $n$.\n   \n#### Order of growth\nThis is another abstraction to ease analysis and allows us to focus on the important features.\n\nIdea: Look only at the leading term of the formula for running time.\n\n - Drop lower-order terms.\n - Ignore the constant coefficient in the leading term.\n\n_Example:_ For insertion sort, we already abstracted away the actual statement costs $c_i$ to conclude that the worst-case running time is  $T_W(n) = an^2 + bn + c$.\n\nDrop lower-order terms $\\implies an^2$\n\nIgnore the constant coefficient  $\\implies n^2$\n\nWe say $T_W(n)$ grows like $n^2$ or $T_W(n) = \\Theta(n^2)$ (\"theta of $n$-squared\"). \n\n$\\Theta(n^2) $ captures the notion that the _order of growth is_ $n^2$.\n\nWe usually consider one algorithm to be more efficient than another if its worst-case running time has a smaller order of growth."}
︠25b537dc-9491-4fc4-8872-5bccbe343fec︠
%md
### CSC-340 HW \#2:

 - Exercise 2.1-3, pg. 22: Write the linear search pseudocode and prove correct.
 - Exercise 2.2-3 , pg 29: Running time of linear search.
︡655e7d8a-050b-4e89-b59b-b0d2fc9e3556︡{"done":true,"md":"### CSC-340 HW \\#2:\n\n - Exercise 2.1-3, pg. 22: Write the linear search pseudocode and prove correct.\n - Exercise 2.2-3 , pg 29: Running time of linear search."}










