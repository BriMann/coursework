︠359341f5-10ce-4481-bfe0-f0daa010e8ffi︠
%md

# 4.5 The master method for solving recurrences

### Your name: !!

- a "cookbook" method for solving recurrences of the form
    - $T(n) = aT(n/b) + f(n)$
        - where $a\geq 1, b > 1, f(n) > 0$
        
The master method is based on

### **Theorem 4.1 The Master Theorem**
> Let $a\geq 1, b > 1$ be constants, let $f(n)$ be a function, and let $T(n)$ be deﬁned on the nonnegative integers by the recurrence
 - $T(n) = aT(n/b) + f(n)$
> where $n/b$ means $\lfloor n/b \rfloor$ or $\lceil n/b \rceil$. Then $T(n)$ has the following asymptotic bounds:
1. If $f(n) = O(n^{\log_b a - \epsilon})$ for some constant $\epsilon > 0$, then $T(n) = \Theta(n^{\log_b a}).$
2. If $f(n) = \Theta(n^{\log_b a})$, then $T(n) = \Theta(n^{\log_b a}\lg n).$
3. If $f(n) = \Omega (n^{\log_b a + \epsilon})$ for some constant $\epsilon > 0$, and if $af(n/b) \leq cf(n)$ for some constant $c<1$ and all sufficienty large $n$, then $T(n) = \Theta(f(n)). \blacksquare$

In each of the 3 cases, compare $n^{\log_b a} \Longleftrightarrow f(n)$
 - The larger of the two determines the solution to the recurrence!
 
**Case 1:** $f(n) = O(n^{\log_b a - \epsilon})$ for some constant $\epsilon > 0$.
 - $\implies f(n)$ is polynomially smaller than $n^{\log_b a}$
 - **Solution:** $T(n) = \Theta(n^{\log_b a}).$
  - Intuitively: cost is dominated by leaves.
  
 **Case 2:** $f(n) = \Theta(n^{\log_b a})$ 
 - $\implies f(n)$ is the "same size" as $n^{\log_b a}$, or within a polylog factor of $n^{\log_b a}$ but not smaller
 - **Solution:** $T(n) = \Theta(n^{\log_b a}\lg n).$
  - Intuitively: cost is $n^{\log_b a}$ at each level and there are $\Theta(\lg n)$ levels.
  
**Case 3:** $f(n) = \Omega(n^{\log_b a + \epsilon})$ for some constant $\epsilon > 0$ and $f(n)$ satisfies the _regularity condition_ $af(n/b) \leq cf(n)$ for some constant $c<1$ and all sufficienty large $n$.
 - $\implies f(n)$ is polynomially greater than $n^{\log_b a}$
 - **Solution:** $T(n) = \Theta(f(n)).$
  - Intuitively: cost is dominated by root.

︡34c310bf-5eed-4f86-9a7c-063b9d145373︡{"done":true,"md":"\n# 4.5 The master method for solving recurrences\n\n### Your name: !!\n\n- a \"cookbook\" method for solving recurrences of the form\n    - $T(n) = aT(n/b) + f(n)$\n        - where $a\\geq 1, b > 1, f(n) > 0$\n        \nThe master method is based on\n\n### **Theorem 4.1 The Master Theorem**\n> Let $a\\geq 1, b > 1$ be constants, let $f(n)$ be a function, and let $T(n)$ be deﬁned on the nonnegative integers by the recurrence\n - $T(n) = aT(n/b) + f(n)$\n> where $n/b$ means $\\lfloor n/b \\rfloor$ or $\\lceil n/b \\rceil$. Then $T(n)$ has the following asymptotic bounds:\n1. If $f(n) = O(n^{\\log_b a - \\epsilon})$ for some constant $\\epsilon > 0$, then $T(n) = \\Theta(n^{\\log_b a}).$\n2. If $f(n) = \\Theta(n^{\\log_b a})$, then $T(n) = \\Theta(n^{\\log_b a}\\lg n).$\n3. If $f(n) = \\Omega (n^{\\log_b a + \\epsilon})$ for some constant $\\epsilon > 0$, and if $af(n/b) \\leq cf(n)$ for some constant $c<1$ and all sufficienty large $n$, then $T(n) = \\Theta(f(n)). \\blacksquare$\n\nIn each of the 3 cases, compare $n^{\\log_b a} \\Longleftrightarrow f(n)$\n - The larger of the two determines the solution to the recurrence!\n \n**Case 1:** $f(n) = O(n^{\\log_b a - \\epsilon})$ for some constant $\\epsilon > 0$.\n - $\\implies f(n)$ is polynomially smaller than $n^{\\log_b a}$\n - **Solution:** $T(n) = \\Theta(n^{\\log_b a}).$\n  - Intuitively: cost is dominated by leaves.\n  \n **Case 2:** $f(n) = \\Theta(n^{\\log_b a})$ \n - $\\implies f(n)$ is the \"same size\" as $n^{\\log_b a}$, or within a polylog factor of $n^{\\log_b a}$ but not smaller\n - **Solution:** $T(n) = \\Theta(n^{\\log_b a}\\lg n).$\n  - Intuitively: cost is $n^{\\log_b a}$ at each level and there are $\\Theta(\\lg n)$ levels.\n  \n**Case 3:** $f(n) = \\Omega(n^{\\log_b a + \\epsilon})$ for some constant $\\epsilon > 0$ and $f(n)$ satisfies the _regularity condition_ $af(n/b) \\leq cf(n)$ for some constant $c<1$ and all sufficienty large $n$.\n - $\\implies f(n)$ is polynomially greater than $n^{\\log_b a}$\n - **Solution:** $T(n) = \\Theta(f(n)).$\n  - Intuitively: cost is dominated by root."}
︠f8211572-bf21-41eb-80cd-b601278c6277i︠
%md

### **_What’s with the Case 3 regularity condition?_**

- Generally not a problem.
- *It always holds when $f(n) = n^k$ and $f(n) = \Omega(n^{\log_b a + \epsilon})$ for some constant $\epsilon > 0$ 
  - This means we don't need to check this when $f$ is a polynomial.
  
*proof: Since  $f(n) = n^k$ and $f(n) = \Omega(n^{\log_b a + \epsilon})$

$\implies k > \log_b a$

$\implies b^k > b^{\log_b a} = a$

$\implies 1 >  \dfrac{a}{b^k}$ 

Since $a, b, k$ are constants, if we let $c = \dfrac{a}{b^k}$ then $c < 1$ is a constant and then

$af(n/b) = a\left(\dfrac{n}{b} \right)^k = c\cdot n^k = cf(n)$ and the regularity condition is satisfied. $\blacksquare$

### Examples

1. $T(n) = 9T(n/3) + n$ : $a = 9, b = 3, f(n) = n$

Recall: In each of the 3 cases, compare $n^{\log_b a} \Longleftrightarrow f(n)$
 - The larger of the two determines the solution to the recurrence!
 
 $n^{\log_b a} = n^{\log_3 9} = n^2 = \Theta(n^2)$ 
 
 Since $f(n) = n = \Theta(n^1) = \Theta(n^{2-1}) = \Theta(n^{\log_3 9 - 1}) = \Theta(n^{\log_3 9 - \epsilon})$ where $\epsilon = 1$,
 
 by <u>Case 1</u> of the Master Theorem, $T(n) = \Theta( n^{\log_3 9}) = \Theta(n^2) \blacksquare$.
 
2. $T(n) = 5T(n/2) + \Theta(n^2)$ : $a = 5, b = 2, f(n) = \Theta(n^2)$

Recall: In each of the 3 cases, compare $n^{\log_b a} \Longleftrightarrow f(n)$
 - The larger of the two determines the solution to the recurrence!
 
Compare $n^{\log_b a} = n^{\log_2 5}$ with $n^2$: 
 
 Since $2 = \log_2 4 < \log_2 5 < \log_2 8 = 3, \log_2 5 - \epsilon = 2$ for some $\epsilon >0$. 
 
 by <u>Case 1</u> of the Master Theorem, $T(n) = \Theta(n^{\log_2 5 }) \blacksquare$.
 
 3. $T(n) = 5T(n/2) + \Theta(n^3)$ : $a = 5, b = 2, f(n) = \Theta(n^3)$

Compare $n^{\log_2 5}$ with $n^3$: 
 
 Since $2 = \log_2 4 < \log_2 5 < \log_2 8 = 3, \log_2 5 + \epsilon = 3$ for some $\epsilon >0$ and $f(n) = \Theta(n^3)$, 
 
 by <u>Case 3</u> of the Master Theorem, $T(n) = \Theta(n^{3})$
 
 * Check regularity: $f(n) = n^3$ 
 
 $af(n/b) = 5f(n/2) = 5(n/2)^3 = \dfrac{5}{2^3}n^3$.  
 
 Let $c=\dfrac{5}{2^3} < 1.$
 
 Then $5f(n/2) \leq c n^3 = cf(n).  \blacksquare$
︡20a8f3fd-bab8-4132-b956-b429385fd84d︡{"done":true,"md":"\n### **_What’s with the Case 3 regularity condition?_**\n\n- Generally not a problem.\n- *It always holds when $f(n) = n^k$ and $f(n) = \\Omega(n^{\\log_b a + \\epsilon})$ for some constant $\\epsilon > 0$ \n  - This means we don't need to check this when $f$ is a polynomial.\n  \n*proof: Since  $f(n) = n^k$ and $f(n) = \\Omega(n^{\\log_b a + \\epsilon})$\n\n$\\implies k > \\log_b a$\n\n$\\implies b^k > b^{\\log_b a} = a$\n\n$\\implies 1 >  \\dfrac{a}{b^k}$ \n\nSince $a, b, k$ are constants, if we let $c = \\dfrac{a}{b^k}$ then $c < 1$ is a constant and then\n\n$af(n/b) = a\\left(\\dfrac{n}{b} \\right)^k = c\\cdot n^k = cf(n)$ and the regularity condition is satisfied. $\\blacksquare$\n\n### Examples\n\n1. $T(n) = 9T(n/3) + n$ : $a = 9, b = 3, f(n) = n$\n\nRecall: In each of the 3 cases, compare $n^{\\log_b a} \\Longleftrightarrow f(n)$\n - The larger of the two determines the solution to the recurrence!\n \n $n^{\\log_b a} = n^{\\log_3 9} = n^2 = \\Theta(n^2)$ \n \n Since $f(n) = n = \\Theta(n^1) = \\Theta(n^{2-1}) = \\Theta(n^{\\log_3 9 - 1}) = \\Theta(n^{\\log_3 9 - \\epsilon})$ where $\\epsilon = 1$,\n \n by <u>Case 1</u> of the Master Theorem, $T(n) = \\Theta( n^{\\log_3 9}) = \\Theta(n^2) \\blacksquare$.\n \n2. $T(n) = 5T(n/2) + \\Theta(n^2)$ : $a = 5, b = 2, f(n) = \\Theta(n^2)$\n\nRecall: In each of the 3 cases, compare $n^{\\log_b a} \\Longleftrightarrow f(n)$\n - The larger of the two determines the solution to the recurrence!\n \nCompare $n^{\\log_b a} = n^{\\log_2 5}$ with $n^2$: \n \n Since $2 = \\log_2 4 < \\log_2 5 < \\log_2 8 = 3, \\log_2 5 - \\epsilon = 2$ for some $\\epsilon >0$. \n \n by <u>Case 1</u> of the Master Theorem, $T(n) = \\Theta(n^{\\log_2 5 }) \\blacksquare$.\n \n 3. $T(n) = 5T(n/2) + \\Theta(n^3)$ : $a = 5, b = 2, f(n) = \\Theta(n^3)$\n\nCompare $n^{\\log_2 5}$ with $n^3$: \n \n Since $2 = \\log_2 4 < \\log_2 5 < \\log_2 8 = 3, \\log_2 5 + \\epsilon = 3$ for some $\\epsilon >0$ and $f(n) = \\Theta(n^3)$, \n \n by <u>Case 3</u> of the Master Theorem, $T(n) = \\Theta(n^{3})$\n \n * Check regularity: $f(n) = n^3$ \n \n $af(n/b) = 5f(n/2) = 5(n/2)^3 = \\dfrac{5}{2^3}n^3$.  \n \n Let $c=\\dfrac{5}{2^3} < 1.$\n \n Then $5f(n/2) \\leq c n^3 = cf(n).  \\blacksquare$"}
︠93e96027-2b31-4049-8a01-69a3615349eei︠
%md

4. $T(n) = T(2n/3) + 1$ : $a = 1, b = 3/2, f(n) = 1$

 
 $n^{\log_b a} = n^{\log_{3/2} 1} = n^0 = 1 = f(n)$ 
 
 Since $f(n) = \Theta(n^{\log_b a}),$ 
 
 by <u>Case 2</u> of the Master Theorem, $T(n) = \Theta(n^{\log_{3/2} 1} \lg n) = \Theta(\lg n). \blacksquare$
 
 5. $T(n) = 2T(n/2) + n\lg n$ : $a = 2, b = 2, f(n) = n\lg n$

 
 $n^{\log_b a} = n^{\log_{2} 2} = n^1 = n$ to $f(n) = n\lg n$ 
 
 There is a problem here... $f(n) = n\lg n$ is asymptotically larger than $n^{\log_b a} = n$. But not polynomially larger. 
 
 Consider the regularity condition: $af(n/b) = 2(n/2 \lg(n/2)) = ????$
 
 <u>We can't apply the Master Theorem</u>. $\blacksquare$
 
6.  Apply to merge-sort! $T(n) = 2T(n/2) + \Theta(n)$

Compare $n^{\log_{2} 2} = n^1 = n$ to $n = f(n) = \Theta(n^{\log_{2} 2})$.

By <u>Case ??</u> of the Master Theorem, $T(n) = \Theta(n^{\log_{2} 2} \lg n) = \Theta(n \lg n). \checkmark$

7.  Apply to Strassen! $T(n) = 7T(n/2) + \Theta(n^2)$

Compare $n^{\log_{2} 7}$ to $n^2 = f(n)$.

Since $n^{\log_2 7 - \epsilon} = n^2$ for some $\epsilon >0$,

by <u>Case ??</u> of the Master Theorem, $T(n) = \Theta(n^{\log_{2} 7}) = \Theta(n^{\lg 7}). \checkmark$
︡7a99a4a6-522a-4d36-975a-d5ecd702c32a︡{"done":true,"md":"\n4. $T(n) = T(2n/3) + 1$ : $a = 1, b = 3/2, f(n) = 1$\n\n \n $n^{\\log_b a} = n^{\\log_{3/2} 1} = n^0 = 1 = f(n)$ \n \n Since $f(n) = \\Theta(n^{\\log_b a}),$ \n \n by <u>Case 2</u> of the Master Theorem, $T(n) = \\Theta(n^{\\log_{3/2} 1} \\lg n) = \\Theta(\\lg n). \\blacksquare$\n \n 5. $T(n) = 2T(n/2) + n\\lg n$ : $a = 2, b = 2, f(n) = n\\lg n$\n\n \n $n^{\\log_b a} = n^{\\log_{2} 2} = n^1 = n$ to $f(n) = n\\lg n$ \n \n There is a problem here... $f(n) = n\\lg n$ is asymptotically larger than $n^{\\log_b a} = n$. But not polynomially larger. \n \n Consider the regularity condition: $af(n/b) = 2(n/2 \\lg(n/2)) = ????$\n \n <u>We can't apply the Master Theorem</u>. $\\blacksquare$\n \n6.  Apply to merge-sort! $T(n) = 2T(n/2) + \\Theta(n)$\n\nCompare $n^{\\log_{2} 2} = n^1 = n$ to $n = f(n) = \\Theta(n^{\\log_{2} 2})$.\n\nBy <u>Case ??</u> of the Master Theorem, $T(n) = \\Theta(n^{\\log_{2} 2} \\lg n) = \\Theta(n \\lg n). \\checkmark$\n\n7.  Apply to Strassen! $T(n) = 7T(n/2) + \\Theta(n^2)$\n\nCompare $n^{\\log_{2} 7}$ to $n^2 = f(n)$.\n\nSince $n^{\\log_2 7 - \\epsilon} = n^2$ for some $\\epsilon >0$,\n\nby <u>Case ??</u> of the Master Theorem, $T(n) = \\Theta(n^{\\log_{2} 7}) = \\Theta(n^{\\lg 7}). \\checkmark$"}
︠5f31fd62-fc61-404c-81ee-974683a16e49i︠
%md

In groups, work on ws07_master_method.pdf

︡70354ccd-28d5-478c-8220-7673507fa54b︡{"done":true,"md":"\nIn groups, work on ws07_master_method.pdf"}









