︠69d763ab-1322-4b16-a685-ae13f4d41855︠
%md

# Chapter 15 Dynamic Programming Goals/Overview

#### Your name: ??

Dynamic Programming

 - Not a specific algorithm, but a technique (like divide-and-conquer).
 - Developed back in the day when "programming" meant "tabular method" (like linear programming). Doesn’t really refer to computer programming.
   - **Tabulation** is an approach where you solve a dynamic programming problem by first filling up a table, and then compute the solution to the original problem based on the results in this table.
 - Divide-and-conquer algorithms partition the problem into disjoint subproblems, solve the subproblems recursively, and then combine their solutions to solve the original problem.
 - Dynamic programming applies when the subproblems overlap—that is, when subproblems share subsubproblems
   - In this context, a divide-and-conquer algorithm does more work than necessary, repeatedly solving the common subsubproblems
   - A dynamic-programming algorithm solves each subsubproblem just once and then saves its answer in a table, thereby avoiding the work of recomputing the answer every time it solves each subsubproblem
 - Used for optimization problems:
   - Find _a_ solution with _the_ optimal value.
   - Minimization or maximization.


### Four-step method
1. Characterize the structure of an optimal solution.
2. Recursively define the value of an optimal solution.
3. Compute the value of an optimal solution, typically in a bottom-up fashion.
4. Construct an optimal solution from computed information.

## 15.1 Steel Rod cutting

The problem: How should steel rods be cut into pieces in order to maximize revenue? Assume:
 - Each cut is free (no cost).
 - Rod lengths are always an integral number of inches.


> **Input:** A rod length $n$ and table of prices $p_i$ , for $i=1, \dots n$.

> **Output** The maximum revenue obtainable for rods whose lengths sum to $n$, computed
as the sum of the prices for the individual rods.


Note: If the price $p_n$ for a rod of length $n$ is large enough, an optimal solution might require no cuts, i.e., just leave the
rod as $n$ inches long.

_Example:_

| length $i$ | 1 | 2 | 3 | 4 | 5  | 6  | 7  | 8  |
|----------|---|---|---|---|----|----|----|----|
| price $p_i$  | 1 | 5 | 8 | 9 | 10 | 17 | 17 | 20 |

Can cut up a rod in $2^{n-1}$ different ways, because can choose to cut or not cut after
each of the first $n-1$ inches.  Suppose we have a rod of length $n=4$ inches.  Then there are $2^3 = 8$ ways to cut the rod.  Consider the $8$ ways with the associated prices (and revenues) from the Example:

 https://www.lucidchart.com/invitations/accept/9921afe3-9ae7-42a0-abad-0779611d06eb

We see the best way is to cut it into two 2-inch pieces, getting a revenue of $p_2 + p_2 = 5 + 5 = 10.$

 Let $r_i$ be the maximum revenue for a rod of length $i$. We can determine optimal revenues $r_i$ for the example, by inspection.  We denote a decomposition into pieces using additive notation, so that $5=2+3$ indicates a rod of length $5$ is cut into two pieces-one of length $2$ and the other of length $3$.

| $i$ \| | $r$ | optimal solution
| -----:|:--:|:--:|
| 1 \| | 1 | 1 (no cuts)
| 2 \| |5 | 2 (no cuts)
| 3 \| | 8 | 3 (no cuts)
| 4 \| | 10 | 2+2
| 5 \| | 13 | 3+2
︡13e87f4e-4795-4c30-8aa1-bdc1245de23e︡{"done":true,"md":"\n# Chapter 15 Dynamic Programming Goals/Overview\n\n#### Your name: ??\n\nDynamic Programming\n\n - Not a specific algorithm, but a technique (like divide-and-conquer).\n - Developed back in the day when \"programming\" meant \"tabular method\" (like linear programming). Doesn’t really refer to computer programming.\n   - **Tabulation** is an approach where you solve a dynamic programming problem by first filling up a table, and then compute the solution to the original problem based on the results in this table.\n - Divide-and-conquer algorithms partition the problem into disjoint subproblems, solve the subproblems recursively, and then combine their solutions to solve the original problem.\n - Dynamic programming applies when the subproblems overlap—that is, when subproblems share subsubproblems\n   - In this context, a divide-and-conquer algorithm does more work than necessary, repeatedly solving the common subsubproblems\n   - A dynamic-programming algorithm solves each subsubproblem just once and then saves its answer in a table, thereby avoiding the work of recomputing the answer every time it solves each subsubproblem\n - Used for optimization problems:\n   - Find _a_ solution with _the_ optimal value.\n   - Minimization or maximization.\n   \n   \n### Four-step method\n1. Characterize the structure of an optimal solution.\n2. Recursively define the value of an optimal solution.\n3. Compute the value of an optimal solution, typically in a bottom-up fashion.\n4. Construct an optimal solution from computed information.\n\n## 15.1 Steel Rod cutting\n\nThe problem: How should steel rods be cut into pieces in order to maximize revenue? Assume:\n - Each cut is free (no cost).\n - Rod lengths are always an integral number of inches.\n\n\n> **Input:** A rod length $n$ and table of prices $p_i$ , for $i=1, \\dots n$.\n\n> **Output** The maximum revenue obtainable for rods whose lengths sum to $n$, computed\nas the sum of the prices for the individual rods.\n\n\nNote: If the price $p_n$ for a rod of length $n$ is large enough, an optimal solution might require no cuts, i.e., just leave the\nrod as $n$ inches long.\n\n_Example:_\n\n| length $i$ | 1 | 2 | 3 | 4 | 5  | 6  | 7  | 8  |\n|----------|---|---|---|---|----|----|----|----|\n| price $p_i$  | 1 | 5 | 8 | 9 | 10 | 17 | 17 | 20 |\n\nCan cut up a rod in $2^{n-1}$ different ways, because can choose to cut or not cut after\neach of the first $n-1$ inches.  Suppose we have a rod of length $n=4$ inches.  Then there are $2^3 = 8$ ways to cut the rod.  Consider the $8$ ways with the associated prices (and revenues) from the Example:\n\n https://www.lucidchart.com/invitations/accept/9921afe3-9ae7-42a0-abad-0779611d06eb\n \nWe see the best way is to cut it into two 2-inch pieces, getting a revenue of $p_2 + p_2 = 5 + 5 = 10.$\n\n Let $r_i$ be the maximum revenue for a rod of length $i$. We can determine optimal revenues $r_i$ for the example, by inspection.  We denote a decomposition into pieces using additive notation, so that $5=2+3$ indicates a rod of length $5$ is cut into two pieces-one of length $2$ and the other of length $3$.\n \n| $i$ \\| | $r$ | optimal solution\n| -----:|:--:|:--:|\n| 1 \\| | 1 | 1 (no cuts)\n| 2 \\| |5 | 2 (no cuts)\n| 3 \\| | 8 | 3 (no cuts)\n| 4 \\| | 10 | 2+2 \n| 5 \\| | 13 | 3+2"}
︠ec840ada-2e16-44b7-8f57-995b9fd2226b︠
%md

**At your boards:**

1. Complete the optimal revenue chart for lengths of size $i = 6, 7, 8$ using the example prices per length chart.  Record your labeled answers on your worksheet.
︡9825351d-5536-4aad-99aa-3504c906797c︡{"done":true,"md":"\n**At your boards:** \n\n1. Complete the optimal revenue chart for lengths of size $i = 6, 7, 8$ using the example prices per length chart.  Record your labeled answers on your worksheet."}
︠3c847580-11d0-4764-8a3c-c31be3aa39f9i︠
%md

We can determine optimal revenue $r_n$ by taking the maximum of
 - $p_n$: the price we get by not making a cut,
 - $r_1 + r_{n-1}$: the maximum revenue from a rod of 1 inch and a rod of $n-1$ inches,
 - $r_2 + r_{n-2}$: the maximum revenue from a rod of 2 inches and a rod of $n-2$ inches,

 $\vdots$

 - $r_{n-1} + r_1$

 That is,
$$r_n = \text{max}(p_n, r_1 + r_{n-1}, r_2 + r_{n-2}, \dots, r_{n-1} + r_1)$$

Here $p_n$ corresponds to making no cuts and selling the rod of length $n$ as is.  The other $n-1$ arguments to max correspond to the maximum revenue obtained by making an initial cut of the rod into two pieces of size $i$ and $n-i$ and then optimally cutting up those pieces further. We say that the rod-cutting exhibits:

>_Optimal substructure:_ To solve the original problem of size $n$, solve subproblems on smaller sizes. After making a cut, we have two subproblems. The optimal solution to the original problem incorporates optimal solutions to the subproblems. We may solve the subproblems independently.

_Example:_ For $n=7$, one of the optimal solutions makes a cut at 3 inches, giving two subproblems, of lengths 3 and 4. We need to solve both of them optimally. The optimal solution for the problem of length 4, cutting into 2 pieces, each of length 2, is used in the optimal solution to the original problem with length 7.

_A simpler way to decompose the problem:_ Every optimal solution has a leftmost cut. In other words, there’s some cut that gives a first piece of length $i$ cut off the left end, and a remaining piece of length $n-i$ on the right.
 -  Need to divide only the remainder, not the first piece.
 - This leaves only one subproblem to solve, rather than two subproblems.
 - Say that the solution with no cuts has first piece size $i = n$ with revenue $p_n$, and remainder size $0$ with revenue $r_0 = 0$.
 - Gives a simpler version of the equation for $r_n$:
$$r_n = \max\limits_{1\leq i \leq n}(p_i + r_{n-i}).$$


### Recursive top-down solution

Direct implementation of the simpler equation for $r_n$. The call CUT-ROD(p,n) returns the optimal revenue $r_n$:
︡6fdd42a2-495f-450e-b147-7c02dd7e2286︡{"done":true,"md":"\nWe can determine optimal revenue $r_n$ by taking the maximum of\n - $p_n$: the price we get by not making a cut,\n - $r_1 + r_{n-1}$: the maximum revenue from a rod of 1 inch and a rod of $n-1$ inches,\n - $r_2 + r_{n-2}$: the maximum revenue from a rod of 2 inches and a rod of $n-2$ inches,\n \n $\\vdots$\n \n - $r_{n-1} + r_1$\n \n That is,\n$$r_n = \\text{max}(p_n, r_1 + r_{n-1}, r_2 + r_{n-2}, \\dots, r_{n-1} + r_1)$$\n\nHere $p_n$ corresponds to making no cuts and selling the rod of length $n$ as is.  The other $n-1$ arguments to max correspond to the maximum revenue obtained by making an initial cut of the rod into two pieces of size $i$ and $n-i$ and then optimally cutting up those pieces further. We say that the rod-cutting exhibits:\n\n>_Optimal substructure:_ To solve the original problem of size $n$, solve subproblems on smaller sizes. After making a cut, we have two subproblems. The optimal solution to the original problem incorporates optimal solutions to the subproblems. We may solve the subproblems independently.\n\n_Example:_ For $n=7$, one of the optimal solutions makes a cut at 3 inches, giving two subproblems, of lengths 3 and 4. We need to solve both of them optimally. The optimal solution for the problem of length 4, cutting into 2 pieces, each of length 2, is used in the optimal solution to the original problem with length 7.\n\n_A simpler way to decompose the problem:_ Every optimal solution has a leftmost cut. In other words, there’s some cut that gives a first piece of length $i$ cut off the left end, and a remaining piece of length $n-i$ on the right.\n -  Need to divide only the remainder, not the first piece.\n - This leaves only one subproblem to solve, rather than two subproblems.\n - Say that the solution with no cuts has first piece size $i = n$ with revenue $p_n$, and remainder size $0$ with revenue $r_0 = 0$.\n - Gives a simpler version of the equation for $r_n$:\n$$r_n = \\max\\limits_{1\\leq i \\leq n}(p_i + r_{n-i}).$$\n\n\n### Recursive top-down solution\n\nDirect implementation of the simpler equation for $r_n$. The call CUT-ROD(p,n) returns the optimal revenue $r_n$:"}
︠589fbd63-c985-486c-91f4-5f1c154c819a︠
####### Do not run :)######
#pseudocode

CUT-ROD(p,n)
    if n == 0:
        return 0
    q = -infinity
    for i = 1 to n:
        q = max(q, p[i] + CUT-ROD(p, n-i))
    return q

####### Do not run :)######

︡3befef76-463c-4542-a1e0-93a42706c21b︡
︠acda4bf3-294e-4b00-987e-bc3b2017a0a1i︠
%md
Here $p[1..n]$ is the price array and $n$ is the length of the rod. CUT-ROD returns the maximum revenue possible for a rod of length $n$.

This procedure works, but it is terribly _inefficient_. If you code it up and run it, it could take more than an hour for $n = 40$. Running time almost doubles each time $n$ increases by $1$.

_Why so inefficient?:_ CUT-ROD calls itself repeatedly, even on subproblems it has already solved. Consider a tree of recursive calls for $n = 4$:

https://www.lucidchart.com/invitations/accept/20fbeba1-f3b6-4b19-8d55-5acfc4a5c13d
︡b2b0e902-f1b7-44e8-b094-b0604ba7c2a5︡{"done":true,"md":"Here $p[1..n]$ is the price array and $n$ is the length of the rod. CUT-ROD returns the maximum revenue possible for a rod of length $n$.\n\nThis procedure works, but it is terribly _inefficient_. If you code it up and run it, it could take more than an hour for $n = 40$. Running time almost doubles each time $n$ increases by $1$.\n\n_Why so inefficient?:_ CUT-ROD calls itself repeatedly, even on subproblems it has already solved. Consider a tree of recursive calls for $n = 4$:\n\nhttps://www.lucidchart.com/invitations/accept/20fbeba1-f3b6-4b19-8d55-5acfc4a5c13d"}
︠ee5c702a-4a4b-4b88-8012-2f6c6ce9e9d2i︠
%md

**At your boards:**

2. Trace through the CUT-ROD(p, 4) algorithm and verify that the tree illustrates the number of recursive calls to CUT-ROD. Are you satisfied the tree illustrates the number of recursive calls to CUT-ROD?

3. Let $T(n)$ denote the number of CUT-ROD(p, n) calls made. This expression equals the number of nodes in a subtree whose root is labeled $n$ in the recursion tree. What is T(0)? T(1)? T(2)? T(3)? T(4)? T(n)?  Record your labeled answers on your worksheet.

4. Identify why CUT-ROD is so inefficient and write your explanation on your worksheet.
︡191e9baa-42dc-4b03-8cf9-2dea0df43110︡{"done":true,"md":"\n**At your boards:**\n\n2. Trace through the CUT-ROD(p, 4) algorithm and verify that the tree illustrates the number of recursive calls to CUT-ROD. Are you satisfied the tree illustrates the number of recursive calls to CUT-ROD?\n\n3. Let $T(n)$ denote the number of CUT-ROD(p, n) calls made. This expression equals the number of nodes in a subtree whose root is labeled $n$ in the recursion tree. What is T(0)? T(1)? T(2)? T(3)? T(4)? T(n)?  Record your labeled answers on your worksheet.\n\n4. Identify why CUT-ROD is so inefficient and write your explanation on your worksheet."}









