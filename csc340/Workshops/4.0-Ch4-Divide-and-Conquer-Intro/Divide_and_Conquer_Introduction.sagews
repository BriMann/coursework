︠f635eab8-1ff2-426b-939c-c070e309a04di︠
%md

# Chapter 4 Divide-and-Conquer

### Your name: !!

In Section 2.3, we saw merge sort is an example of the divide-and-conquer paradigm. Recall we solve recursively:

**Divide** the problem into a number of subproblems that are smaller instances of the same problem.

**Conquer** the subproblems by solving them recursively.
  - Base case: If the subproblems are small enough, just solve them by brute force!

**Combine** the subproblem solutions to give a solution to the original problem.

## Analyzing divide-and-conquer algorithms

- Use a recurrence

A **_recurrence_** is a function that is defined in terms of
- one or more base cases, and
- itself, with smaller arguments.

**<u>Examples (to be completed/solved in class)</u>**

- $T(n) = \begin{cases} 
          1 & \text{if } n = 1 \\
           T(n-1) + 1 & \text{if } n > 1
       \end{cases} $
  - $T(1) = 1, T(2) = T(1) + 1 = 1 + 1 = 2, T(3) = ??, T(n) = ??$
  
\\\\
mk- $T(n) = \begin{cases} 
          1 & \text{if } n = 1 \\
           2T(n/2) + n & \text{if } n \geq 1
       \end{cases} $
  - $T(n) = 2T(n/2) + n$
    - $T(n/2) = 2T(n/4) + n/2 = 2T(n/2^2) + n/2$  Plug this back in $T(n)$
  - $T(n) = 2T(n/2) + n = 2[2T(n/2^2) + n/2] + n = 2^2T(n/2^2) + n + n = 2^2T(n/2^2) + 2n$
    - $T(n/4) = T(n/2^2) = 2T(n/2^3) + n/2^2$ Plug this back in $T(n)$
  - $T(n) = 2^2T(n/2^2) + 2n = 2^2[2T(n/2^3) + n/2^2] + 2n = 2^3T(n/2^3) + 3n$
  
  ... ( suppose stop after $k$ times)
  - $T(n) = 2^kT(n/2^k) + kn$ and we reached the base case: $T(n/2^k) = T(1)$ so $n/2^k = 1 \implies n=2^k \implies k = ??$
  - So $T(n) = 2^kT(1) + kn = ??$  Solve the recurrence!
  
- $T(n) = \begin{cases} 
          0 & \text{if } n = 2 \\
           T(\sqrt(n)) + 1 & \text{if } n > 2
       \end{cases} $
  - $T(n) = T(\sqrt(n)) + 1 = T(n^{1/2}) + 1$
    - $T(\sqrt(n)) = T(n^{1/2}) = T((n^{1/2})^{1/2}) + 1 = T(n^{1/4})+1 = T(n^{1/2^2}) + 1$ Plug this back in $T(n)$
  - $T(n) = T(n^{1/2^2}) + 1 + 1 = T(n^{1/2^2}) + 2$
    - $T(n^{1/2^2}) = T(n^{1/2^3}) + 1$ Plug this back in $T(n)$
  - $T(n) = T(n^{1/2^3}) + 3$
  
  ... ( suppose stop after $k$ times)
  - $T(n) = T(n^{1/2^k}) + k$ and we reached the base case: $T(n^{1/2^k}) = T(2)$ so $n^{1/2^k} = 2$ ...solve for $k$
  
︡abfec389-108a-4398-a7ca-49c3dda12481︡{"done":true,"md":"\n# Chapter 4 Divide-and-Conquer\n\n### Your name: !!\n\nIn Section 2.3, we saw merge sort is an example of the divide-and-conquer paradigm. Recall we solve recursively:\n\n**Divide** the problem into a number of subproblems that are smaller instances of the same problem.\n\n**Conquer** the subproblems by solving them recursively.\n  - Base case: If the subproblems are small enough, just solve them by brute force!\n\n**Combine** the subproblem solutions to give a solution to the original problem.\n\n## Analyzing divide-and-conquer algorithms\n\n- Use a recurrence\n\nA **_recurrence_** is a function that is defined in terms of\n- one or more base cases, and\n- itself, with smaller arguments.\n\n**<u>Examples (to be completed/solved in class)</u>**\n\n- $T(n) = \\begin{cases} \n          1 & \\text{if } n = 1 \\\\\n           T(n-1) + 1 & \\text{if } n > 1\n       \\end{cases} $\n  - $T(1) = 1, T(2) = T(1) + 1 = 1 + 1 = 2, T(3) = ??, T(n) = ??$\n  \n- $T(n) = \\begin{cases} \n          1 & \\text{if } n = 1 \\\\\n           2T(n/2) + n & \\text{if } n \\geq 1\n       \\end{cases} $\n  - $T(n) = 2T(n/2) + n$\n    - $T(n/2) = 2T(n/4) + n/2 = 2T(n/2^2) + n/2$  Plug this back in $T(n)$\n  - $T(n) = 2T(n/2) + n = 2[2T(n/2^2) + n/2] + n = 2^2T(n/2^2) + n + n = 2^2T(n/2^2) + 2n$\n    - $T(n/4) = T(n/2^2) = 2T(n/2^3) + n/2^2$ Plug this back in $T(n)$\n  - $T(n) = 2^2T(n/2^2) + 2n = 2^2[2T(n/2^3) + n/2^2] + 2n = 2^3T(n/2^3) + 3n$\n  \n  ... ( suppose stop after $k$ times)\n  - $T(n) = 2^kT(n/2^k) + kn$ and we reached the base case: $T(n/2^k) = T(1)$ so $n/2^k = 1 \\implies n=2^k \\implies k = ??$\n  - So $T(n) = 2^kT(1) + kn = ??$  Solve the recurrence!\n  \n- $T(n) = \\begin{cases} \n          0 & \\text{if } n = 2 \\\\\n           T(\\sqrt(n)) + 1 & \\text{if } n > 2\n       \\end{cases} $\n  - $T(n) = T(\\sqrt(n)) + 1 = T(n^{1/2}) + 1$\n    - $T(\\sqrt(n)) = T(n^{1/2}) = T((n^{1/2})^{1/2}) + 1 = T(n^{1/4})+1 = T(n^{1/2^2}) + 1$ Plug this back in $T(n)$\n  - $T(n) = T(n^{1/2^2}) + 1 + 1 = T(n^{1/2^2}) + 2$\n    - $T(n^{1/2^2}) = T(n^{1/2^3}) + 1$ Plug this back in $T(n)$\n  - $T(n) = T(n^{1/2^3}) + 3$\n  \n  ... ( suppose stop after $k$ times)\n  - $T(n) = T(n^{1/2^k}) + k$ and we reached the base case: $T(n^{1/2^k}) = T(2)$ so $n^{1/2^k} = 2$ ...solve for $k$"}









