︠4a64ebb7-3041-4d62-a3d4-79ac5679552c︠
%md

## 15.1 Optimal Rod cutting-Dynamic Programming

#### Your name: ??

Recall our problem:

> **Input:** A rod length $n$ and table of prices $p_i$ , for $i=1, \dots n$.

> **Output** The maximum revenue obtainable for rods whose lengths sum to $n$, computed
as the sum of the prices for the individual rods.

_Example:_

| length $i$ | 1 | 2 | 3 | 4 | 5  | 6  | 7  | 8  |
|----------|---|---|---|---|----|----|----|----|
| price $p_i$  | 1 | 5 | 8 | 9 | 10 | 17 | 17 | 20 |

 - Instead of solving the same subproblems repeatedly, arrange to solve each subproblem just once.
 - "Store, don’t recompute" $\implies$ a time-memory trade-off.
 - We can turn an exponential-time solution into a polynomial-time solution.
 
 
There are two basic (equivalent) approaches to dynamic programming:

 - top-down with memoization (comes from "memo"), and
 - bottom-up.

### Top-down with memoization

 - Solve recursively, but store each result in a table.
 - To find the solution to a subproblem, first look in the table. If the answer is there, use it. Otherwise, compute the solution to the subproblem and then store the solution in the table for future use.
 - _Memoizing_ is remembering what we have computed previously.
 
 Consider the memoized version of the recursive solution, storing the solution to the subproblem of length $i$ in array entry $r[i]$:
︡206e8b37-1442-4505-8aa6-6268b1bd260f︡{"done":true,"md":"\n## 15.1 Optimal Rod cutting-Dynamic Programming\n\n#### Your name: ??\n\nRecall our problem:\n\n> **Input:** A rod length $n$ and table of prices $p_i$ , for $i=1, \\dots n$.\n\n> **Output** The maximum revenue obtainable for rods whose lengths sum to $n$, computed\nas the sum of the prices for the individual rods.\n\n_Example:_\n\n| length $i$ | 1 | 2 | 3 | 4 | 5  | 6  | 7  | 8  |\n|----------|---|---|---|---|----|----|----|----|\n| price $p_i$  | 1 | 5 | 8 | 9 | 10 | 17 | 17 | 20 |\n\n - Instead of solving the same subproblems repeatedly, arrange to solve each subproblem just once.\n - \"Store, don’t recompute\" $\\implies$ a time-memory trade-off.\n - We can turn an exponential-time solution into a polynomial-time solution.\n \n \nThere are two basic (equivalent) approaches to dynamic programming:\n\n - top-down with memoization (comes from \"memo\"), and\n - bottom-up.\n\n### Top-down with memoization\n\n - Solve recursively, but store each result in a table.\n - To find the solution to a subproblem, first look in the table. If the answer is there, use it. Otherwise, compute the solution to the subproblem and then store the solution in the table for future use.\n - _Memoizing_ is remembering what we have computed previously.\n \n Consider the memoized version of the recursive solution, storing the solution to the subproblem of length $i$ in array entry $r[i]$:"}
︠bf6f9f5c-850f-4566-8ae5-ba0544445ee9︠
####### Do not run :)######
#pseudocode                                     

# top-down memoized rod cutting
MEMOIZED-CUT-ROD(p,n)
    let r[0..n] be a new array
    for i = 0 to n:
        r[i] = -infinity
    return MEMOIZED-CUT-ROD-AUX(p, n, r)

# memoized rod cutting helper function
MEMOIZED-CUT-ROD-AUX(p,n, r)
    if r[n] >= 0: # desired value already known
        return r[n]
    if n == 0: #desired value not known
        q = 0
    else:
        q = -infinity
        for i = 1 to n:
            q = max(q, p[i] + MEMOIZED-CUT-ROD-AUX(p, n-i, r))
    r[n] = q #store the new value
    return q
####### Do not run :)######
︡8222ded2-488a-453c-9ad9-06f09db33a71︡
︠11a6e92b-e079-4ac5-b18a-e1c261765e66i︠
%md

### Bottom-up

Sort the subproblems by size and solve the smaller ones first. That way, when solving a subproblem, we have already solved the smaller subproblems we need.
︡62507591-7c88-4048-842b-bd659c6f72c0︡{"done":true,"md":"\n### Bottom-up\n\nSort the subproblems by size and solve the smaller ones first. That way, when solving a subproblem, we have already solved the smaller subproblems we need."}
︠bc214e00-d41e-4627-b283-0dedb1b11241︠
####### Do not run :)######
#pseudocode                                     

# bottom-up rod cutting
BOTTOM-UP-CUT-ROD(p,n)
    let r[0..n] be a new array
    r[0] = 0 #a rod of length 0 earns no revenue
    for j = 1 to n: #solve each subproblem of size j in order of increasing size
        q = -infinity
        for i = 1 to j:
            q = max(q, p[i] + r[j-i]) #directly references r[j-i]
        r[j] = q                          #instead of recursive call
    return r[n]
####### Do not run :)######
︡a53ff872-322b-4811-8bc6-b67dd0c2a579︡
︠e3513f2e-9d9a-4f5a-b762-08f439c556b1︠
%md

### Running time

Both the top-down and bottom-up versions run in $\Theta(n^2)$time.  Recall the recursive top-down running time! :(

 -  _Bottom-up_: Doubly nested loops. Number of iterations of inner for loop forms an arithmetic series $\sum_{j = 1}^{n} j = \frac{n(n+1)}{2}$.
 -  _Top-down_: MEMOIZED-CUT-ROD solves each subproblem just once, and it solves subproblems for sizes $0, 1, \dots, n$. To solve a subproblem of size $n$, the for loop iterates $n \text{ times } \implies$ over all recursive calls, total number of iterations also forms an arithmetic series.
 
### Subproblem graphs

How to understand the subproblems involved and how they depend on each other.

Directed graph:
 - One vertex for each distinct subproblem.
 - Has a directed edge $(x, y)$  if computing an optimal solution to subproblem $x$ directly requires knowing an optimal solution to subproblem $y$.
 
 _Example:_ The subproblem graph for the rod-cutting problem with $n=4$:

https://lucid.app/lucidchart/invitations/accept/0d558320-bf74-436b-9c98-5e632dab0d1e?viewport_loc=-1455%2C42%2C4619%2C2218%2C0_0

We can think of the subproblem graph as a collapsed version of the tree of recursive calls, where all nodes for the same subproblem are collapsed into a single vertex, and all edges go from parent to child.

The subproblem graph can help determine running time. Because we solve each subproblem just once, running time is sum of times needed to solve each subproblem.

 - Time to compute solution to a subproblem is typically linear in the out-degree (number of outgoing edges) of its vertex.
 - Number of subproblems equals number of vertices.
 
When these conditions hold, running time is linear in number of vertices and edges.


︡54e4a910-1656-4d35-b471-702e7b19eeeb︡{"done":true,"md":"\n### Running time\n\nBoth the top-down and bottom-up versions run in $\\Theta(n^2)$time.  Recall the recursive top-down running time! :(\n\n -  _Bottom-up_: Doubly nested loops. Number of iterations of inner for loop forms an arithmetic series $\\sum_{j = 1}^{n} j = \\frac{n(n+1)}{2}$.\n -  _Top-down_: MEMOIZED-CUT-ROD solves each subproblem just once, and it solves subproblems for sizes $0, 1, \\dots, n$. To solve a subproblem of size $n$, the for loop iterates $n \\text{ times } \\implies$ over all recursive calls, total number of iterations also forms an arithmetic series.\n \n### Subproblem graphs\n\nHow to understand the subproblems involved and how they depend on each other.\n\nDirected graph:\n - One vertex for each distinct subproblem.\n - Has a directed edge $(x, y)$  if computing an optimal solution to subproblem $x$ directly requires knowing an optimal solution to subproblem $y$.\n \n _Example:_ The subproblem graph for the rod-cutting problem with $n=4$:\n\nhttps://lucid.app/lucidchart/invitations/accept/0d558320-bf74-436b-9c98-5e632dab0d1e?viewport_loc=-1455%2C42%2C4619%2C2218%2C0_0\n\nWe can think of the subproblem graph as a collapsed version of the tree of recursive calls, where all nodes for the same subproblem are collapsed into a single vertex, and all edges go from parent to child.\n\nThe subproblem graph can help determine running time. Because we solve each subproblem just once, running time is sum of times needed to solve each subproblem.\n\n - Time to compute solution to a subproblem is typically linear in the out-degree (number of outgoing edges) of its vertex.\n - Number of subproblems equals number of vertices.\n \nWhen these conditions hold, running time is linear in number of vertices and edges."}
︠88aeda88-3537-4ddf-9189-7e1412095b93i︠
%md

### Reconstructing a solution

So far, we have focused on computing the value of an optimal solution, rather than the choices that produced an optimal solution.

Extend the bottom-up approach to record not just optimal values, but optimal choices. Save the optimal choices in a separate table. Then use a separate procedure to print the optimal choices.
︡855d5a81-7521-43b9-b241-637e37560d5b︡{"done":true,"md":"\n### Reconstructing a solution\n\nSo far, we have focused on computing the value of an optimal solution, rather than the choices that produced an optimal solution.\n\nExtend the bottom-up approach to record not just optimal values, but optimal choices. Save the optimal choices in a separate table. Then use a separate procedure to print the optimal choices."}
︠85d06266-1bb4-4236-80ef-c1e0fcde4fb8︠
####### Do not run :)######
#pseudocode                                     

# bottom-up rod cutting extended to provide optimal choices

EXTENDED-BOTTOM-UP-CUT-ROD(p,n)
    let r[0..n] and s[1..n] be a new arrays
    r[0] = 0
    for j = 1 to n:
        q = -infinity
        for i = 1 to j:
            if q < p[i] + r[j-1]:
                q = p[i] + r[j-i]
                s[j] = i
        r[j] = q
    return r and s
####### Do not run :)######
︡61d30573-6cd5-4eae-8ce4-0143c199cc57︡
︠377fc341-2559-4ad0-84e6-88c13f4c8e17i︠
%md

EXTENDED-BOTTOM-UP-CUT-ROD(p,n) saves the first cut made in an optimal solution for a problem of size $i$ in $s[i]$.

To print out the cuts made in an optimal solution:
︡e86b52ab-3ad6-4481-ab55-a70bc759c709︡{"done":true,"md":"\nEXTENDED-BOTTOM-UP-CUT-ROD(p,n) saves the first cut made in an optimal solution for a problem of size $i$ in $s[i]$.\n\nTo print out the cuts made in an optimal solution:"}
︠05cc5e54-98d1-4a1b-bbd0-bb195e864a81︠
####### Do not run :)######
#pseudocode                                     

# print optimal cuts
PRINT-CUT-ROD-SOLUTION(p,n)
    (r,s) = EXTENDED-BOTTOM-UP-CUT-ROD(p,n)
    while n > 0:
        print s[n]
        n = n - s[n]
####### Do not run :)######
︡19237b1b-158f-4d40-8df4-910130abe4f4︡
︠bb0bba45-fbd4-45f3-950e-5c4e09719298︠
%md

_Recall Example:_

| length $i$ | 1 | 2 | 3 | 4 | 5  | 6  | 7  | 8  |
|----------|---|---|---|---|----|----|----|----|
| price $p_i$  | 1 | 5 | 8 | 9 | 10 | 17 | 17 | 20 |
︡d54b105d-22ef-4a88-a66d-f9318963239c︡{"done":true,"md":"\n_Recall Example:_\n\n| length $i$ | 1 | 2 | 3 | 4 | 5  | 6  | 7  | 8  |\n|----------|---|---|---|---|----|----|----|----|\n| price $p_i$  | 1 | 5 | 8 | 9 | 10 | 17 | 17 | 20 |"}
︠6f8dc808-b1e5-4173-880e-0142485de404︠
%md

**At your boards:**

1. Complete the EXTENDED-BOTTOM-UP-CUT-ROD return-values chart (BELOW) for lengths of size $i = 6, 7, 8$ using the example prices per length chart.  Record your labeled answers on your worksheet.
    
For the example, EXTENDED-BOTTOM-UP-CUT-ROD returns

| $i$ \| | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8
|----------|---|---|---|---|----|----|----|----|
| $r_i$  \| | 1 | 5| 8 | 10 | 13 | 17 | 18 | 22
| $s_i$  \| | 1 | 2| 3 | 2 | 2 |?? | ?? |??


2.  Consider the implementation of the Rod-Cutting Algorithms from CSC-340 2017 found in folder **WS15: 15.1-Dynamic_Programming_Rod_cutting**.  Compile and run the program _rodcut2.cpp_. Were your answers to Question 1 above correct?  

Identify the names of the following algorithms/structures in program: 
 - p[1..n]
 - r[0..n]
 - s[1..n]
 - CUT-ROD(p,n)
 - MEMOIZED-CUT-ROD(p,n)
 - MEMOIZED-CUT-ROD-AUX(p,n, r)
 - BOTTOM-UP-CUT-ROD(p,n)
 - EXTENDED-BOTTOM-UP-CUT-ROD(p,n)
 - PRINT-CUT-ROD-SOLUTION(p,n)
︡679e3f9e-7409-40b0-a40d-708c27ec7acb︡{"done":true,"md":"\n**At your boards:**\n\n1. Complete the EXTENDED-BOTTOM-UP-CUT-ROD return-values chart (BELOW) for lengths of size $i = 6, 7, 8$ using the example prices per length chart.  Record your labeled answers on your worksheet.\n    \nFor the example, EXTENDED-BOTTOM-UP-CUT-ROD returns\n\n| $i$ \\| | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8\n|----------|---|---|---|---|----|----|----|----|\n| $r_i$  \\| | 1 | 5| 8 | 10 | 13 | 17 | 18 | 22\n| $s_i$  \\| | 1 | 2| 3 | 2 | 2 |?? | ?? |??\n\n\n2.  Consider the implementation of the Rod-Cutting Algorithms from CSC-340 2017 found in folder **WS15: 15.1-Dynamic_Programming_Rod_cutting**.  Compile and run the program _rodcut2.cpp_. Were your answers to Question 1 above correct?  \n\nIdentify the names of the following algorithms/structures in program: \n - p[1..n]\n - r[0..n]\n - s[1..n]\n - CUT-ROD(p,n)\n - MEMOIZED-CUT-ROD(p,n)\n - MEMOIZED-CUT-ROD-AUX(p,n, r)\n - BOTTOM-UP-CUT-ROD(p,n)\n - EXTENDED-BOTTOM-UP-CUT-ROD(p,n)\n - PRINT-CUT-ROD-SOLUTION(p,n)"}









