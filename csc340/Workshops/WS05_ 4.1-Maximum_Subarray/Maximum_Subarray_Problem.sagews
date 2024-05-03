︠972cb3e6-0886-4d04-8f52-8603bbfadb4fi︠
%md

# 4.1 The maximum-subarray problem

### Your name: Dr. Danielson

 - **Input:** An array  $A[1..n]$ of numbers (Assume that some of the numbers are negative, otherwise a trivial problem)
 - **Output:**
   - Indices $i$ and $j$ such that $A[i..j]$ has the greatest sum of any nonempty, contiguous subarray of $A$, along with the
   - sum of the values in $A[i..j]$

**<u>Scenario</u>**
 - You have the prices that a stock traded at over a period of $n$ consecutive days.
 - When should you have bought the stock? When should you have sold the stock?

To convert to a maximum-subarray problem, let $A[i] = $(price after day $i$) - (price after day $i-1$)
- Assuming that we start with a price after day 0 (or morning before day 1).
- Note: If the price goes up on day $i$, then $A[i] > 0$ and if the price goes down on day $i$, then $A[i] < 0$
- Then the nonempty, contiguous subarray with the greatest sum brackets the days that you should have held the stock.
- If the maximum subarray is $A[i..j]$ , then we should have bought just before day $i$ and sold just after day $j$.

Why do we need to find the maximum subarray? Why not just "buy low, sell high"?
 - Lowest price might occur after the highest price. Consider:

︡1baeca7e-0868-432e-9261-127fbececf1c︡{"done":true,"md":"\n# 4.1 The maximum-subarray problem\n\n### Your name: Dr. Danielson\n\n - **Input:** An array  $A[1..n]$ of numbers (Assume that some of the numbers are negative, otherwise a trivial problem)\n - **Output:** \n   - Indices $i$ and $j$ such that $A[i..j]$ has the greatest sum of any nonempty, contiguous subarray of $A$, along with the \n   - sum of the values in $A[i..j]$ \n   \n**<u>Scenario</u>**\n - You have the prices that a stock traded at over a period of $n$ consecutive days.\n - When should you have bought the stock? When should you have sold the stock?\n \nTo convert to a maximum-subarray problem, let $A[i] = $(price after day $i$) - (price after day $i-1$)\n- Assuming that we start with a price after day 0 (or morning before day 1). \n- Note: If the price goes up on day $i$, then $A[i] > 0$ and if the price goes down on day $i$, then $A[i] < 0$ \n- Then the nonempty, contiguous subarray with the greatest sum brackets the days that you should have held the stock.\n- If the maximum subarray is $A[i..j]$ , then we should have bought just before day $i$ and sold just after day $j$.\n\nWhy do we need to find the maximum subarray? Why not just \"buy low, sell high\"?\n - Lowest price might occur after the highest price. Consider:"}
︠c5ed2ac1-fdf6-4986-a7a2-3a91adf128das︠

day = [0,1,2,3,4]
price = [10,11,7,10,6]

delta = ["A", "--", price[1]-price[0], price[2]-price[1], price[3]-price[2], price[4]-price[3]]
rows = [["day:"] + day, ["price:"] + price, delta]
table(rows)


#y1 = plot(f(x), (0, max), color = 'green', legend_label='$2 x^2$')
#y2 = plot(g(x), (0, max), color = 'blue', legend_label='$x^3$')
l1 = line([(day[0],price[0]),(day[1],price[1])], color='black')
l2 = line([(day[1],price[1]),(day[2],price[2])], color='black')
l3 = line([(day[2],price[2]),(day[3],price[3])], color='black')
l4 = line([(day[3],price[3]),(day[4],price[4])], color='black')
p = l1 + l2 + l3 + l4
p += point( (day[0],price[0]), color='red', pointsize=20)
p += point( (day[1],price[1]), color='red', pointsize=20)
p += point( (day[2],price[2]), color='red', pointsize=20)
p += point( (day[3],price[3]), color='red', pointsize=20)
p += point( (day[4],price[4]), color='red', pointsize=20)
p.show(axes=True, xmin=0, xmax=4, ymin=6, ymax=11)


︡a479f18f-93a1-4fcd-ab35-5fef0d744102︡{"stdout":"  day:     0    1    2    3    4\n  price:   10   11   7    10   6\n  A        --   1    -4   3    -4\n"}︡{"file":{"filename":"/home/user/.sage/temp/project-f89c1e29-62f1-44f8-9fe9-c1616d5c92e5/1897/tmp_b73i4n3b.svg","show":true,"text":null,"uuid":"05591749-9bf1-4222-97ea-b7962ac0545d"},"once":false}︡{"done":true}
︠9e5a2578-10ae-4560-872c-8603d1a3a85d︠
%md

**At the boards: 1) Determine the maximum profit and the time to buy and sell to yield that maximum.  2) Does this solution support the "buy low, sell high" philosophy? Explain.**

**Solution:**

︡3547cc27-1a84-4f24-8a66-230e3fd92237︡{"done":true,"md":"\n**At the boards: 1) Determine the maximum profit and the time to buy and sell to yield that maximum.  2) Does this solution support the \"buy low, sell high\" philosophy? Explain.**\n\n**Solution:**"}
︠9fedf1f3-87f3-403a-a634-5a16438b8d46i︠
%md

We can solve the maximum-subarray problem by brute force: Consider all possible pairs of buy and sell days--
$$ = \binom{n}{2} = \frac{n!}{2!(n-2)!} = \frac{n(n-1)}{2} = \Theta(n^2) \text{ time }$$

Claim: We can do better! Use the divide-and-conquer strategy to solve in $O(n \lg n)$ time.


## Solving by divide-and-conquer

Note: Maximum subarray might NOT be unique, though its value is.  This is why we speak of _a_ maximum subarray, rather than _the_ maximum subarray.

- **_Subproblem_:** Find a max subarray of $A[low..high]$.  In original call, $low = 1, high = n$.

**Divide** the subarray into two subarrays of $\approx$ equal size. Find the $mid$ of the subarrays, $A[low..mid]$ and $A[mid+1..high]$.

**Conquer** by finding a maximum subarrays of $A[low..mid]$ and $A[mid+1..high]$.

**Combine** by finding a max subarray that crosses the $A[mid]$, and using the best solution out of the three (the subarray crossing $A[mid]$ and the two solutions found in the conquer step).

- Note: This strategy works because any subarray must either lie entirely on one side of $A[mid]$ or cross the $A[mid]$.

### _Finding the maximum subarray that crosses $A[mid]$_
 - Not a smaller instance of the original problem: has the added restriction that the subarray must cross $A[mid]$.
 - Again, could use brute force:  if size of $A[low..high]$ is $n$, would have $n/2$ choices for left endpoint (before $mid$) and $n/2$  choices right endpoint (after $mid$), so would have $\Theta(n^2)$ combinations altogether.
 - BUT, can solve in linear time:
   - Any subarray crossing $A[mid]$ is made of two subarrays: $A[i..mid]$ and $A[mid+1..j]$ where $low \leq i \leq mid$ and $mid \leq j \leq high$
   - Find max subarrays of the form $A[i..mid]$ and $A[mid+1..j]$ and then combine them.

**_Procedure to take array $A$ and indices $low, mid, high$ and return a tuple giving indices of max subarray that crosses $A[mid]$, along with the sum in this max subarray:_**
︡cacf36d2-db78-4a04-844a-44610ba10e2d︡{"done":true,"md":"\nWe can solve the maximum-subarray problem by brute force: Consider all possible pairs of buy and sell days--\n$$ = \\binom{n}{2} = \\frac{n!}{2!(n-2)!} = \\frac{n(n-1)}{2} = \\Theta(n^2) \\text{ time }$$\n\nClaim: We can do better! Use the divide-and-conquer strategy to solve in $O(n \\lg n)$ time.\n\n\n## Solving by divide-and-conquer\n\nNote: Maximum subarray might NOT be unique, though its value is.  This is why we speak of _a_ maximum subarray, rather than _the_ maximum subarray.\n\n- **_Subproblem_:** Find a max subarray of $A[low..high]$.  In original call, $low = 1, high = n$.\n\n**Divide** the subarray into two subarrays of $\\approx$ equal size. Find the $mid$ of the subarrays, $A[low..mid]$ and $A[mid+1..high]$.\n\n**Conquer** by finding a maximum subarrays of $A[low..mid]$ and $A[mid+1..high]$.\n\n**Combine** by finding a max subarray that crosses the $A[mid]$, and using the best solution out of the three (the subarray crossing $A[mid]$ and the two solutions found in the conquer step).\n\n- Note: This strategy works because any subarray must either lie entirely on one side of $A[mid]$ or cross the $A[mid]$.\n\n### _Finding the maximum subarray that crosses $A[mid]$_\n - Not a smaller instance of the original problem: has the added restriction that the subarray must cross $A[mid]$.\n - Again, could use brute force:  if size of $A[low..high]$ is $n$, would have $n/2$ choices for left endpoint (before $mid$) and $n/2$  choices right endpoint (after $mid$), so would have $\\Theta(n^2)$ combinations altogether.\n - BUT, can solve in linear time:\n   - Any subarray crossing $A[mid]$ is made of two subarrays: $A[i..mid]$ and $A[mid+1..j]$ where $low \\leq i \\leq mid$ and $mid \\leq j \\leq high$ \n   - Find max subarrays of the form $A[i..mid]$ and $A[mid+1..j]$ and then combine them.\n   \n**_Procedure to take array $A$ and indices $low, mid, high$ and return a tuple giving indices of max subarray that crosses $A[mid]$, along with the sum in this max subarray:_**"}
︠7d2b0475-c1dc-477d-9cdc-d5a1b928b928o︠
####### Do not run :)######
#pseudocode
FIND-MAX-CROSSING-SUBARRAY(A, low, mid, high):
    #Find a maximum subarray of the form A[i..mid]
    left-sum = -inf
    sum = 0
    for i = mid downto low:
        sum = sum + A[i]
        if sum > left-sum:
            left-sum = sum
            max-left = i
    #Find a maximum subarray of the form A[mid+1..j]
    right-sum = -inf
    sum = 0
    for j = mid + 1 to high:
        sum = sum + A[j]
        if sum > right-sum:
            right-sum = sum
            max-right = j
    # Return the indices and the sum of the two subarrays.
    return (max-left, max-right,  left-sum + right-sum)
####### Do not run :)######
︡d4d38b8e-dc81-41da-8f75-65540bac8dab︡{"stderr":"Error in lines 1-15\nTraceback (most recent call last):\n  File \"/cocalc/lib/python3.8/site-packages/smc_sagews/sage_server.py\", line 1231, in execute\n    compile(block + '\\n',\n  File \"<string>\", line 1\n    FIND-MAX-CROSSING-SUBARRAY(A, low, mid, high):\n                                                 ^\nSyntaxError: invalid syntax\n"}︡{"done":true}
︠7ab6b6a3-b386-49ef-b7a0-1351689fda8di︠
%md

**_Time:_** The two loops together consider each index in the range $low..high$ exactly once, and each iteration takes $\Theta(1)$ time $\implies$ procedure takes $\Theta(n)$ time.

**_Divide-and-conquer procedure for the max-subarray problem:_**
︡6249e711-9ec5-4cee-af19-19333d84fe68︡{"done":true,"md":"\n**_Time:_** The two loops together consider each index in the range $low..high$ exactly once, and each iteration takes $\\Theta(1)$ time $\\implies$ procedure takes $\\Theta(n)$ time.\n\n**_Divide-and-conquer procedure for the max-subarray problem_**"}
︠87a74e46-5d42-440a-95c3-14741739617co︠
####### Do not run :)######
#pseudocode
FIND-MAXIMUM-SUBARRAY(A, low, high):
    if high == low:
        #base case: only one element
        return (low, high, A[low])
    else:
        mid = (low + high)//2
        (left-low, left-high, left-sum) = FIND-MAXIMUM-SUBARRAY(A, low, mid)
        (right-low, right-high, right-sum) = FIND-MAXIMUM-SUBARRAY(A, mid+1, high)
        (cross-low, cross-high, cross-sum) = FIND-MAX-CROSSING-SUBARRAY(A, low, mid, high)
        if left-sum >= right-sum and left-sum >= cross-sum:
            return (left-low, left-high, left-sum)
        elseif right-sum >= left-sum and right-sum >= cross-sum:
            return (right-low, right-high, right-sum)
        else:
            return (cross-low, cross-high, cross-sum)

####### Do not run :)######
︡10790902-ae4e-48d1-b97e-257362080d0c︡{"stderr":"Error in lines 1-14\nTraceback (most recent call last):\n  File \"/cocalc/lib/python3.8/site-packages/smc_sagews/sage_server.py\", line 1231, in execute\n    compile(block + '\\n',\n  File \"<string>\", line 1\n    FIND-MAXIMUM-SUBARRAY(A, low, high):\n                                       ^\nSyntaxError: invalid syntax\n"}︡{"done":true}
︠96977e0d-2584-4b2d-b9db-ae56de13ad11i︠
%md

**_Initial call_**: FIND-MAXIMUM-SUBARRAY(A,1,n)

 - Divide by computing mid.
 - Conquer by the two recursive calls to FIND-MAXIMUM-SUBARRAY.
 - Combine by calling FIND-MAX-CROSSING-SUBARRAY and then determining which of the three results gives the maximum sum.
 - Base case is when the subarray has only 1 element.

**At the boards: What does FIND-MAXIMUM-SUBARRAY return whan all of the elements of $A$ are negative?**

**Solution:**
︡039c2cb1-c01b-4f0d-81dd-4bb97294b9e6︡{"done":true,"md":"\n**_Initial call_**: FIND-MAXIMUM-SUBARRAY(A,1,n)\n\n - Divide by computing mid.\n - Conquer by the two recursive calls to FIND-MAXIMUM-SUBARRAY.\n - Combine by calling FIND-MAX-CROSSING-SUBARRAY and then determining which of the three results gives the maximum sum.\n - Base case is when the subarray has only 1 element.\n\n**At the boards: What does FIND-MAXIMUM-SUBARRAY return whan all of the elements of $A$ are negative?**\n \n**Solution:**"}
︠58bff9e7-ff45-477a-aaa6-97baf0683b97︠
%md

### Analysis

**_Simplifying assumption:_** $n = 2^k$, so that all subproblem sizes are integers.

Let $T(n) = $ running time of FIND-MAXIMUM-SUBARRAY on $A[1..n]$

**_Base case:_** Occurs when $high = low$, so $n=1$ and the procedure just returns $\implies T(n) = \Theta(1)$.

**_Recursive case:_** Occurs when $n > 1$:
 - Dividing takes $\Theta(1)$ time.
 - Conquering solves 2 subproblems, each on a subarray of $n/2$ size.  Takes $T(n/2)$ time each $\implies 2T(n/2)$ time.
 - Combining consists of calling FIND-MAX-CROSSING-SUBARRAY, which takes $\Theta(n)$ time and a constant number of constant-time tests $\implies \Theta(n) + \Theta(1)$ time.

$\implies T(n) = \Theta(1) + 2T(n/2) + \Theta(n) + \Theta(1) = 2T(n/2) + \Theta(n) $
 - (absorb $\Theta(1)$ terms into $\Theta(n)$)

The recurrence for all cases:

 $$T(n) = \begin{cases}
          \Theta(1) & \text{if } n = 1 \\
           2T(n/2) + \Theta(n) & \text{if } n > 1
       \end{cases} $$

 - Same recurrence as for merge-sort: $T(n) = \Theta(n \lg n)$

 **At the boards: 1) Determine the maximum sum and the max-subarray for $A = (13, -3, -25, 20, -3, -16, -23, 18, 20, -7, 12, -5, -22, 15, -4, 7)$**

**Solution:**


Complete an Example walk through:

https://lucid.app/lucidchart/invitations/accept/3a34a94b-ff18-4e07-aba9-baba1c998ee5

︡2750a827-01e3-4c6b-812e-03391c8a702d︡{"done":true,"md":"\n### Analysis\n\n**_Simplifying assumption:_** $n = 2^k$, so that all subproblem sizes are integers.\n\nLet $T(n) = $ running time of FIND-MAXIMUM-SUBARRAY on $A[1..n]$\n\n**_Base case:_** Occurs when $high = low$, so $n=1$ and the procedure just returns $\\implies T(n) = \\Theta(1)$.\n\n**_Recursive case:_** Occurs when $n > 1$:\n - Dividing takes $\\Theta(1)$ time.\n - Conquering solves 2 subproblems, each on a subarray of $n/2$ size.  Takes $T(n/2)$ time each $\\implies 2T(n/2)$ time.\n - Combining consists of calling FIND-MAX-CROSSING-SUBARRAY, which takes $\\Theta(n)$ time and a constant number of constant-time tests $\\implies \\Theta(n) + \\Theta(1)$ time.\n\n$\\implies T(n) = \\Theta(1) + 2T(n/2) + \\Theta(n) + \\Theta(1) = 2T(n/2) + \\Theta(n) $ \n - (absorb $\\Theta(1)$ terms into $\\Theta(n)$)\n \nThe recurrence for all cases:\n\n $$T(n) = \\begin{cases} \n          \\Theta(1) & \\text{if } n = 1 \\\\\n           2T(n/2) + \\Theta(n) & \\text{if } n > 1\n       \\end{cases} $$\n       \n - Same recurrence as for merge-sort: $T(n) = \\Theta(n \\lg n)$\n \n **At the boards: 1) Determine the maximum sum and the max-subarray for $A = (13, -3, -25, 20, -3, -16, -23, 18, 20, -7, 12, -5, -22, 15, -4, 7)$**\n\n**Solution:**\n\n \nComplete an Example walk through:\n\nhttps://lucid.app/lucidchart/invitations/accept/3a34a94b-ff18-4e07-aba9-baba1c998ee5"}









