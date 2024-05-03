︠4006775a-bbd1-46f4-938d-084933374b63i︠
%md

# 4.2 Strassen’s algorithm for matrix multiplication

### Your name: !!

**Thumbs up if you recall how to multiply 2 square matrices.**

Recall how to multiply (square) $3\times 3$ matrices:

$A = (a_{ij}), B = (b_{ij}), i = \text{ row }, j = \text{ column }$

$$ A \times B 
= \begin{bmatrix}
      a_{11} & a_{12} & a_{13}\\
      a_{21} & a_{22} & a_{23}\\
      a_{31} & a_{32} & a_{33}\\
  \end{bmatrix} 
\cdot
  \begin{bmatrix}
      b_{11} & b_{12} & b_{13}\\
      b_{21} & b_{22} & b_{23}\\
      b_{31} & b_{32} & b_{33}\\
  \end{bmatrix} 
  =
  \begin{bmatrix}
      c_{11} & c_{12} & c_{13}\\
      c_{21} & c_{22} & c_{23}\\
      c_{31} & c_{32} & c_{33}\\
  \end{bmatrix} = C
$$    

where 

$c_{11} = a_{11}\cdot b_{11} +  a_{12} \cdot b_{21} +  a_{13} \cdot b_{31} = \sum\limits_{k=1}^3 a_{1k} b_{k1}$

$c_{12} = a_{11}\cdot b_{12} +  a_{12} \cdot b_{22} +  a_{13} \cdot b_{32} = \sum\limits_{k=1}^3 a_{1k} b_{k2}$

$\vdots $

$c_{ij} = a_{i1}\cdot b_{1j} +  a_{i2} \cdot b_{2j} +  a_{i3} \cdot b_{3j} = \sum\limits_{k=1}^3 a_{ik} b_{kj}$

 - **Input:** Two  $n\times n$ (square) matrices $A = (a_{ij}), B = (b_{ij})$
 - **Output:** $n\times n$ matrix $C = (c_{ij})$ where $C = A\cdot B $:
  - $c_{ij} = \sum\limits_{k=1}^n a_{ik} b_{kj}$  for $i,j = 1, 2, \dots. n$
   
Need to compute $n^2$ entries of $C$. Each entry is the sum of $n$ values.

### "Obvious" method

<img src='images/04_02_matrix_multiply_pseudo.PNG' width=20% />

**_Analysis:_** Three nested loops, each iterates $n$ times, and innermost loop body takes constant time $\implies \Theta(n^3)$.

**Thumbs up of you think $\Theta(n^3)$ is the best we can do.**

**_Is $\Theta(n^3)$ the best we can do? Can we multiply in $o(n^3)$ time?_**

Seems like any algorithm to multiply matrices must take $\Omega(n^3)$:
 - Must compute $n^2$ entries
 - Each entry is sum of $n$ terms
 
$\vdots$
︡82c3a3fc-64f4-4d86-a748-894c042ed948︡{"done":true,"md":"\n# 4.2 Strassen’s algorithm for matrix multiplication\n\n### Your name: !!\n\n**Thumbs up if you recall how to multiply 2 square matrices.**\n\nRecall how to multiply (square) $3\\times 3$ matrices:\n\n$A = (a_{ij}), B = (b_{ij}), i = \\text{ row }, j = \\text{ column }$\n\n$$ A \\times B \n= \\begin{bmatrix}\n      a_{11} & a_{12} & a_{13}\\\\\n      a_{21} & a_{22} & a_{23}\\\\\n      a_{31} & a_{32} & a_{33}\\\\\n  \\end{bmatrix} \n\\cdot\n  \\begin{bmatrix}\n      b_{11} & b_{12} & b_{13}\\\\\n      b_{21} & b_{22} & b_{23}\\\\\n      b_{31} & b_{32} & b_{33}\\\\\n  \\end{bmatrix} \n  =\n  \\begin{bmatrix}\n      c_{11} & c_{12} & c_{13}\\\\\n      c_{21} & c_{22} & c_{23}\\\\\n      c_{31} & c_{32} & c_{33}\\\\\n  \\end{bmatrix} = C\n$$    \n\nwhere \n\n$c_{11} = a_{11}\\cdot b_{11} +  a_{12} \\cdot b_{21} +  a_{13} \\cdot b_{31} = \\sum\\limits_{k=1}^3 a_{1k} b_{k1}$\n\n$c_{12} = a_{11}\\cdot b_{12} +  a_{12} \\cdot b_{22} +  a_{13} \\cdot b_{32} = \\sum\\limits_{k=1}^3 a_{1k} b_{k2}$\n\n$\\vdots $\n\n$c_{ij} = a_{i1}\\cdot b_{1j} +  a_{i2} \\cdot b_{2j} +  a_{i3} \\cdot b_{3j} = \\sum\\limits_{k=1}^3 a_{ik} b_{kj}$\n\n - **Input:** Two  $n\\times n$ (square) matrices $A = (a_{ij}), B = (b_{ij})$\n - **Output:** $n\\times n$ matrix $C = (c_{ij})$ where $C = A\\cdot B $:\n  - $c_{ij} = \\sum\\limits_{k=1}^n a_{ik} b_{kj}$  for $i,j = 1, 2, \\dots. n$\n   \nNeed to compute $n^2$ entries of $C$. Each entry is the sum of $n$ values.\n\n### \"Obvious\" method\n\n<img src='images/04_02_matrix_multiply_pseudo.PNG' width=20% />\n\n**_Analysis:_** Three nested loops, each iterates $n$ times, and innermost loop body takes constant time $\\implies \\Theta(n^3)$.\n\n**Thumbs up of you think $\\Theta(n^3)$ is the best we can do.**\n\n**_Is $\\Theta(n^3)$ the best we can do? Can we multiply in $o(n^3)$ time?_**\n\nSeems like any algorithm to multiply matrices must take $\\Omega(n^3)$:\n - Must compute $n^2$ entries\n - Each entry is sum of $n$ terms\n \n$\\vdots$"}
︠f7c7cdd1-33ff-45f1-9164-fde1375ab370︠
%md

<u>But</u> with Strassen's method, we can multiply matrices in  $o(n^3)$ time!
 - Runs in $\Theta(n^{\lg 7})$ time and $\lg 7 < \lg 8 = 3$
  - $ \lg 7 \approx 2.80735492206$
 - So Strassen's method runs in $O(n^{2.81})$ time.
 - Thumbs up if you think we can do better than Strassen.
 
First, let's investigate a **_Simple divide-and-conquer method:_**

 - Assume $n$ is a power of $2$: $n = 2^k$ (like other divide-and-conquer algorithms)
 
Partition each of $A,B, C$ into four $n/2 \times n/2$ matrices:

$$ A 
= \begin{pmatrix}
      A_{11} & A_{12}\\
      A_{21} & A_{22}\\
  \end{pmatrix} 
,\,\, B =
  \begin{pmatrix}
      B_{11} & B_{12}\\
      B_{21} & B_{22}\\
  \end{pmatrix}
,\,\, C =
  \begin{pmatrix}
      C_{11} & C_{12}\\
      C_{21} & C_{22}\\
  \end{pmatrix}
$$    

Rewrite $C = A\cdot B$ as 
$$
\begin{pmatrix}
      C_{11} & C_{12}\\
      C_{21} & C_{22}\\
  \end{pmatrix}
= \begin{pmatrix}
      A_{11} & A_{12}\\
      A_{21} & A_{22}\\
  \end{pmatrix} 
\cdot 
  \begin{pmatrix}
      B_{11} & B_{12}\\
      B_{21} & B_{22}\\
  \end{pmatrix}
$$

yielding four equations:
 - $C_{11} = A_{11} B_{11} + A_{12} B_{21}$
 - $C_{12} = A_{11} B_{12} + A_{12} B_{22}$
 - $C_{21} = A_{21} B_{11} + A_{22} B_{21}$
 - $C_{22} = A_{21} B_{12} + A_{22} B_{22}$
 
Each of these equations multiplies two $n/2 \times n/2$ matrices (yielding two $n/2 \times n/2$ matrices) and then adds their $n/2 \times n/2$ products.

Use these equations to get a divide-and-conquer algorithm:

<img src='images/04_02_recursive_matrix_multiply_pseudo.PNG' width=40% />

︡d6839c0a-d4ea-4fd1-ad7f-8ce612932092︡{"done":true,"md":"\n<u>But</u> with Strassen's method, we can multiply matrices in  $o(n^3)$ time!\n - Runs in $\\Theta(n^{\\lg 7})$ time and $\\lg 7 < \\lg 8 = 3$\n  - $ \\lg 7 \\approx 2.80735492206$\n - So Strassen's method runs in $O(n^{2.81})$ time.\n - Thumbs up if you think we can do better than Strassen.\n \nFirst, let's investigate a **_Simple divide-and-conquer method:_**\n\n - Assume $n$ is a power of $2$: $n = 2^k$ (like other divide-and-conquer algorithms)\n \nPartition each of $A,B, C$ into four $n/2 \\times n/2$ matrices:\n\n$$ A \n= \\begin{pmatrix}\n      A_{11} & A_{12}\\\\\n      A_{21} & A_{22}\\\\\n  \\end{pmatrix} \n,\\,\\, B =\n  \\begin{pmatrix}\n      B_{11} & B_{12}\\\\\n      B_{21} & B_{22}\\\\\n  \\end{pmatrix}\n,\\,\\, C =\n  \\begin{pmatrix}\n      C_{11} & C_{12}\\\\\n      C_{21} & C_{22}\\\\\n  \\end{pmatrix}\n$$    \n\nRewrite $C = A\\cdot B$ as \n$$\n\\begin{pmatrix}\n      C_{11} & C_{12}\\\\\n      C_{21} & C_{22}\\\\\n  \\end{pmatrix}\n= \\begin{pmatrix}\n      A_{11} & A_{12}\\\\\n      A_{21} & A_{22}\\\\\n  \\end{pmatrix} \n\\cdot \n  \\begin{pmatrix}\n      B_{11} & B_{12}\\\\\n      B_{21} & B_{22}\\\\\n  \\end{pmatrix}\n$$\n\nyielding four equations:\n - $C_{11} = A_{11} B_{11} + A_{12} B_{21}$\n - $C_{12} = A_{11} B_{12} + A_{12} B_{22}$\n - $C_{21} = A_{21} B_{11} + A_{22} B_{21}$\n - $C_{22} = A_{21} B_{12} + A_{22} B_{22}$\n \nEach of these equations multiplies two $n/2 \\times n/2$ matrices (yielding two $n/2 \\times n/2$ matrices) and then adds their $n/2 \\times n/2$ products.\n\nUse these equations to get a divide-and-conquer algorithm:\n\n<img src='images/04_02_recursive_matrix_multiply_pseudo.PNG' width=40% />"}
︠749558dc-4365-4430-8d30-165a17332f3f︠
%md

How do we partition matrices? If we were to create $12 = 4 \times 3$ (4 parts for each of 3  $A,B,C$) new  $n/2 \times n/2$ matrices and copy entries we would spend $\Theta(n^2)$ time copying!
 - Instead use index calculations: identify a submatrix by a range of row and column indices of the original matrix
     - Text: "We end up representing a submatrix a little differently from how we represent the original matrix, which is the subtlety we are glossing over"
 - Then line 5 above takes only $\Theta(1)$ time!
 
**_Analysis_** of Simple divide-and-conquer method:

Let $T(n)$ be the time to multiply two $n \times n$ matrices

**_Base case:_** $n=1$:  Perform one scalar multiplication $\implies T(n) = \Theta(1)$.

**_Recursive case:_** $n > 1$:
 - Dividing takes $\Theta(1)$ using the index calculations (else $\Theta(n^2)$)
 - Conquering makes 8 recursive calls, each multiplying $n/2 \times n/2$ matrices $\implies  8T(n/2)$.
 - Combining takes $\Theta(n^2)$ time to add $n/2 \times n/2$ matrices 4 times (doesn't matter if we use index calculations or copy)
 
 The recurrence is:

 $$T(n) = \begin{cases} 
          \Theta(1) & \text{if } n = 1 \\
           8T(n/2) + \Theta(n^2) & \text{if } n > 1
       \end{cases} $$
       
Solving:

\begin{equation} 
\begin{split}
  T(n)   & = 8T(n/2) + \Theta(n^2)                     & \,[T(n/2) = 8T(n/4) + \Theta(n^2)]\\
         & = 8[ 8T(n/4) + \Theta(n^2)]+ \Theta(n^2)    & \text{ [ simplify/rewrite ]}\\
         & = 2^{3\cdot 2}T(n/2^2) + \Theta(n^2)        & \text{ [ recognize the pattern ]}\\
         & = 2^{3\cdot 3}T(n/2^3) + \Theta(n^2)        &\\
         & \vdots     &     &\\
         & = 2^{3\cdot k}T(n/2^k) + \Theta(n^2)        & n = 2^k, \lg n = k\\
         & = 2^{3\cdot \lg n}T(1) + \Theta(n^2)        & n/2^k = 1 , 2^{3\cdot \lg n} = 2^{\lg n^3} = n^3\\
         & = n^3\Theta(1) + \Theta(n^2)                & = \Theta(n^3)
\end{split}
\end{equation}

Sadly, this is asymptotically no better than the first "obvious" method.

### Strassen's method

"Volker Strassen first published this algorithm in 1969 and proved that the $n^3$ general matrix multiplication algorithm wasn't optimal. " (https://en.wikipedia.org/wiki/Strassen_algorithm)

Our authors: "Strassen’s method is not at all obvious. (This might be the biggest understatement in this book.) "

**<u>Idea:</u>** Make the recursion tree less bushy. Perform only 7 recursive multiplications of $n/2 \times n/2$ matrices rather than 8.
 - This will cost several additions of $n/2 \times n/2$ matrices, but just a <u>constant</u> number more which can be absorbed into the $\Theta(n^2)$ time from before.
︡3c384b4d-2206-4a8f-97b9-99d6bb973892︡{"done":true,"md":"\nHow do we partition matrices? If we were to create $12 = 4 \\times 3$ (4 parts for each of 3  $A,B,C$) new  $n/2 \\times n/2$ matrices and copy entries we would spend $\\Theta(n^2)$ time copying!\n - Instead use index calculations: identify a submatrix by a range of row and column indices of the original matrix\n     - Text: \"We end up representing a submatrix a little differently from how we represent the original matrix, which is the subtlety we are glossing over\"\n - Then line 5 above takes only $\\Theta(1)$ time!\n \n**_Analysis_** of Simple divide-and-conquer method:\n\nLet $T(n)$ be the time to multiply two $n \\times n$ matrices\n\n**_Base case:_** $n=1$:  Perform one scalar multiplication $\\implies T(n) = \\Theta(1)$.\n\n**_Recursive case:_** $n > 1$:\n - Dividing takes $\\Theta(1)$ using the index calculations (else $\\Theta(n^2)$)\n - Conquering makes 8 recursive calls, each multiplying $n/2 \\times n/2$ matrices $\\implies  8T(n/2)$.\n - Combining takes $\\Theta(n^2)$ time to add $n/2 \\times n/2$ matrices 4 times (doesn't matter if we use index calculations or copy)\n \n The recurrence is:\n\n $$T(n) = \\begin{cases} \n          \\Theta(1) & \\text{if } n = 1 \\\\\n           8T(n/2) + \\Theta(n^2) & \\text{if } n > 1\n       \\end{cases} $$\n       \nSolving:\n\n\\begin{equation} \n\\begin{split}\n  T(n)   & = 8T(n/2) + \\Theta(n^2)                     & \\,[T(n/2) = 8T(n/4) + \\Theta(n^2)]\\\\\n         & = 8[ 8T(n/4) + \\Theta(n^2)]+ \\Theta(n^2)    & \\text{ [ simplify/rewrite ]}\\\\\n         & = 2^{3\\cdot 2}T(n/2^2) + \\Theta(n^2)        & \\text{ [ recognize the pattern ]}\\\\\n         & = 2^{3\\cdot 3}T(n/2^3) + \\Theta(n^2)        &\\\\\n         & \\vdots     &     &\\\\\n         & = 2^{3\\cdot k}T(n/2^k) + \\Theta(n^2)        & n = 2^k, \\lg n = k\\\\\n         & = 2^{3\\cdot \\lg n}T(1) + \\Theta(n^2)        & n/2^k = 1 , 2^{3\\cdot \\lg n} = 2^{\\lg n^3} = n^3\\\\\n         & = n^3\\Theta(1) + \\Theta(n^2)                & = \\Theta(n^3)\n\\end{split}\n\\end{equation}\n\nSadly, this is asymptotically no better than the first \"obvious\" method.\n\n### Strassen's method\n\n\"Volker Strassen first published this algorithm in 1969 and proved that the $n^3$ general matrix multiplication algorithm wasn't optimal. \" (https://en.wikipedia.org/wiki/Strassen_algorithm)\n\nOur authors: \"Strassen’s method is not at all obvious. (This might be the biggest understatement in this book.) \"\n\n**<u>Idea:</u>** Make the recursion tree less bushy. Perform only 7 recursive multiplications of $n/2 \\times n/2$ matrices rather than 8.\n - This will cost several additions of $n/2 \\times n/2$ matrices, but just a <u>constant</u> number more which can be absorbed into the $\\Theta(n^2)$ time from before."}
︠40be533e-4357-4822-8b55-aea8a17c25ab︠
%md

The algorithm: (4 steps) 

1. Partition each of $A,B,C$ into four $n/2 \times n/2$  matrices (like before)
    - Time:  $\Theta(1)$ if indexing
2. Create 10 $n/2 \times n/2$ matrices $S_1, S_2, \dots, S_{10}$.  Each is a sum or difference of 2 matrices created in the first step.
     - Time:  $\Theta(n^2)$ to create all 10 matrices
3. Recursively compute 7 matrix products $P_1, P_2, \dots, P_7$, each $n/2 \times n/2$
4. Compute $n/2 \times n/2$ submatrices of $C$ by adding and subtracting various combinations of the $P_i$
    - Time:  $\Theta(n^2)$
    
**_Analysis_** of Strassen's method:

 The recurrence is:

 $$T(n) = \begin{cases} 
          \Theta(1) & \text{if } n = 1 \\
           7T(n/2) + \Theta(n^2) & \text{if } n > 1
       \end{cases} $$
       
Solving:

\begin{equation} 
\begin{split}
  T(n)   & = 7T(n/2) + \Theta(n^2)                     & \,[T(n/2) = 7T(n/4) + \Theta(n^2)]\\
         & = 7[ 7T(n/4) + \Theta(n^2)]+ \Theta(n^2)    & \text{ [ simplify/rewrite ]}\\
         & = 7^{2}T(n/2^2) + \Theta(n^2)        & \text{ [ recognize the pattern ]}\\
         & = 7^{3}T(n/2^3) + \Theta(n^2)        &\\
         & \vdots     &     &\\
         & = 7^{ k}T(n/2^k) + \Theta(n^2)        & n = 2^k, \lg n = k\\
         & = 7^{\lg n}T(1) + \Theta(n^2)        & WS04: a^{log_b c} = c^{log_b a}\\
         & = n^{\lg 7}\Theta(1) + \Theta(n^2)                & = \Theta(n^{\lg 7})
\end{split}
\end{equation}
︡f3ade062-caad-4946-b9ff-a10daec40d95︡{"done":true,"md":"\nThe algorithm: (4 steps) \n\n1. Partition each of $A,B,C$ into four $n/2 \\times n/2$  matrices (like before)\n    - Time:  $\\Theta(1)$ if indexing\n2. Create 10 $n/2 \\times n/2$ matrices $S_1, S_2, \\dots, S_{10}$.  Each is a sum or difference of 2 matrices created in the first step.\n     - Time:  $\\Theta(n^2)$ to create all 10 matrices\n3. Recursively compute 7 matrix products $P_1, P_2, \\dots, P_7$, each $n/2 \\times n/2$\n4. Compute $n/2 \\times n/2$ submatrices of $C$ by adding and subtracting various combinations of the $P_i$\n    - Time:  $\\Theta(n^2)$\n    \n**_Analysis_** of Strassen's method:\n\n The recurrence is:\n\n $$T(n) = \\begin{cases} \n          \\Theta(1) & \\text{if } n = 1 \\\\\n           7T(n/2) + \\Theta(n^2) & \\text{if } n > 1\n       \\end{cases} $$\n       \nSolving:\n\n\\begin{equation} \n\\begin{split}\n  T(n)   & = 7T(n/2) + \\Theta(n^2)                     & \\,[T(n/2) = 7T(n/4) + \\Theta(n^2)]\\\\\n         & = 7[ 7T(n/4) + \\Theta(n^2)]+ \\Theta(n^2)    & \\text{ [ simplify/rewrite ]}\\\\\n         & = 7^{2}T(n/2^2) + \\Theta(n^2)        & \\text{ [ recognize the pattern ]}\\\\\n         & = 7^{3}T(n/2^3) + \\Theta(n^2)        &\\\\\n         & \\vdots     &     &\\\\\n         & = 7^{ k}T(n/2^k) + \\Theta(n^2)        & n = 2^k, \\lg n = k\\\\\n         & = 7^{\\lg n}T(1) + \\Theta(n^2)        & WS04: a^{log_b c} = c^{log_b a}\\\\\n         & = n^{\\lg 7}\\Theta(1) + \\Theta(n^2)                & = \\Theta(n^{\\lg 7})\n\\end{split}\n\\end{equation}"}
︠0ca4a56f-8218-45c9-ba71-2bc88afffd08︠
%md

**_Details_**

1. $ A 
= \begin{pmatrix}
      A_{11} & A_{12}\\
      A_{21} & A_{22}\\
  \end{pmatrix} 
,\,\, B =
  \begin{pmatrix}
      B_{11} & B_{12}\\
      B_{21} & B_{22}\\
  \end{pmatrix}
,\,\, C =
  \begin{pmatrix}
      C_{11} & C_{12}\\
      C_{21} & C_{22}\\
  \end{pmatrix}
$    
2. Create the 10 matrices:
    - $S_1 = B_{12} - B_{22}$
    - $S_2 = A_{11} + A_{12}$
    - $S_3 = A_{21} + A_{22}$
    - $S_4 = B_{21} - B_{11}$
    - $S_5 = A_{11} + A_{22}$
    - $S_6 = B_{11} + B_{22}$
    - $S_7 = A_{12} - A_{22}$
    - $S_8 = B_{21} + B_{22}$
    - $S_9 = A_{11} - A_{21}$
    - $S_{10} = B_{11} + B_{12}$
    - Note: Add or subtract $n/2 \times n/2$ matrices 10 times $\implies \Theta(n^2)$
3. Create the 7 matrices:
    - $P_1 = A_{11}\cdot S_1 = A_{11}\cdot B_{12} - A_{11}\cdot B_{22}$
    - $P_2 = S_2 \cdot B_{22} = A_{11}\cdot B_{22} + A_{12}\cdot B_{22}$
    - $P_3 = S_3 \cdot B_{11} = A_{21}\cdot B_{11} + A_{22}\cdot B_{11}$
    - $P_4 = A_{22}\cdot S_4 = A_{22}\cdot B_{21} -A_{22}\cdot B_{11}$
    - $P_5 = S_5 \cdot S_6 = A_{11} \cdot B_{11} + A_{11} \cdot B_{22} + A_{22} \cdot B_{11} + A_{22} \cdot B_{22} $
    - $P_6 = S_7 \cdot S_8 = A_{12} \cdot B_{21} + A_{12} \cdot B_{22} - A_{22} \cdot B_{21} - A_{22} \cdot B_{22} $
    - $P_7 = S_9 \cdot S_{10} = A_{11} \cdot B_{11} + A_{11} \cdot B_{12} - A_{21} \cdot B_{11} - A_{21} \cdot B_{12} $
    - Note: The only multiplications needed are in the middle column; right-hand column just shows the products in terms of the original submatrices of $A$ and $B$.
    - Recursively multiply $n/2 \times n/2$ matrices  7 times
4. Add and subtract the $P_i$ to construct submatrices of $C$:
    - $C_{11} = P_5 + P_4 - P_2 + P_6$
    - $C_{12} = P_1 + P_2$
    - $C_{21} = P_3 + P_4$
    - $C_{22} = P_5 + P_1 - P_3 - P_7$
    
**At the boards: Expand the computations on the RHS in step 4. to convince yourself this method works.**

**Solution:**

︡fc1933c2-e0e0-44e7-8e30-7b02a3704e94︡{"done":true,"md":"\n**_Details_**\n\n1. $ A \n= \\begin{pmatrix}\n      A_{11} & A_{12}\\\\\n      A_{21} & A_{22}\\\\\n  \\end{pmatrix} \n,\\,\\, B =\n  \\begin{pmatrix}\n      B_{11} & B_{12}\\\\\n      B_{21} & B_{22}\\\\\n  \\end{pmatrix}\n,\\,\\, C =\n  \\begin{pmatrix}\n      C_{11} & C_{12}\\\\\n      C_{21} & C_{22}\\\\\n  \\end{pmatrix}\n$    \n2. Create the 10 matrices:\n    - $S_1 = B_{12} - B_{22}$\n    - $S_2 = A_{11} + A_{12}$\n    - $S_3 = A_{21} + A_{22}$\n    - $S_4 = B_{21} - B_{11}$\n    - $S_5 = A_{11} + A_{22}$\n    - $S_6 = B_{11} + B_{22}$\n    - $S_7 = A_{12} - A_{22}$\n    - $S_8 = B_{21} + B_{22}$\n    - $S_9 = A_{11} - A_{21}$\n    - $S_{10} = B_{11} + B_{12}$\n    - Note: Add or subtract $n/2 \\times n/2$ matrices 10 times $\\implies \\Theta(n^2)$\n3. Create the 7 matrices:\n    - $P_1 = A_{11}\\cdot S_1 = A_{11}\\cdot B_{12} - A_{11}\\cdot B_{22}$\n    - $P_2 = S_2 \\cdot B_{22} = A_{11}\\cdot B_{22} + A_{12}\\cdot B_{22}$\n    - $P_3 = S_3 \\cdot B_{11} = A_{21}\\cdot B_{11} + A_{22}\\cdot B_{11}$\n    - $P_4 = A_{22}\\cdot S_4 = A_{22}\\cdot B_{21} -A_{22}\\cdot B_{11}$\n    - $P_5 = S_5 \\cdot S_6 = A_{11} \\cdot B_{11} + A_{11} \\cdot B_{22} + A_{22} \\cdot B_{11} + A_{22} \\cdot B_{22} $\n    - $P_6 = S_7 \\cdot S_8 = A_{12} \\cdot B_{21} + A_{12} \\cdot B_{22} - A_{22} \\cdot B_{21} - A_{22} \\cdot B_{22} $\n    - $P_7 = S_9 \\cdot S_{10} = A_{11} \\cdot B_{11} + A_{11} \\cdot B_{12} - A_{21} \\cdot B_{11} - A_{21} \\cdot B_{12} $\n    - Note: The only multiplications needed are in the middle column; right-hand column just shows the products in terms of the original submatrices of $A$ and $B$.\n    - Recursively multiply $n/2 \\times n/2$ matrices  7 times\n4. Add and subtract the $P_i$ to construct submatrices of $C$:\n    - $C_{11} = P_5 + P_4 - P_2 + P_6$\n    - $C_{12} = P_1 + P_2$\n    - $C_{21} = P_3 + P_4$\n    - $C_{22} = P_5 + P_1 - P_3 - P_7$\n    \n**At the boards: Expand the computations on the RHS in step 4. to convince yourself this method works.**\n\n**Solution:**"}
︠8d39c2d3-15d4-4846-b63e-06b663e20427︠
%md

$C_{11} = P_5 + P_4 - P_2 + P_6$
︡f0bdf505-77a3-4120-a6ef-3f7a8d24b799︡{"done":true,"md":"\n$C_{11} = P_5 + P_4 - P_2 + P_6$"}









