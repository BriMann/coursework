︠a75ceb23-0b8a-4b73-89a1-22e329f13e55i︠
%md

# 3.1 Asymptotic notation

### Your name: Dr. Danielson

#### **"Big-Oh" $O$-notation**

$O(g(n)) = \{f(n) : \text{ there exist positive constants } c \text{ and } n_0 \text{ such that } 0 \leq f(n) \leq c g(n) \text{ for all } n \geq n_0  \}.$


$O(g(n)) = \{f(n) : \exists \, c>0,  n_0>0 \text{ s.t. } 0 \leq f(n) \leq c g(n)\, \forall\, n \geq n_0  \}.$

<img src='images/example_graph_Big_oh.PNG' width=30% />$g(n)$ is an _**asymptotic upper bound**_ for $f(n)$

If $f(n)\in O(g(n))$, we write $f(n) =  O(g(n))$.

_**Example**_

$2n^2 = O(n^3)$ with $c=1$ and $n_0 = 2$. Plot in Desmos for initial graphical understanding.

︡3bf8f901-3798-4744-ad3a-598f83a53830︡{"done":true,"md":"\n# 3.1 Asymptotic notation\n\n### Your name: Dr. Danielson\n\n#### **\"Big-Oh\" $O$-notation**\n\n$O(g(n)) = \\{f(n) : \\text{ there exist positive constants } c \\text{ and } n_0 \\text{ such that } 0 \\leq f(n) \\leq c g(n) \\text{ for all } n \\geq n_0  \\}.$\n\n\n$O(g(n)) = \\{f(n) : \\exists \\, c>0,  n_0>0 \\text{ s.t. } 0 \\leq f(n) \\leq c g(n)\\, \\forall\\, n \\geq n_0  \\}.$\n\n<img src='images/example_graph_Big_oh.PNG' width=30% />$g(n)$ is an _**asymptotic upper bound**_ for $f(n)$\n\nIf $f(n)\\in O(g(n))$, we write $f(n) =  O(g(n))$.\n\n_**Example**_\n\n$2n^2 = O(n^3)$ with $c=1$ and $n_0 = 2$. Plot in Desmos for initial graphical understanding."}
︠4d6169a3-5ab8-43d4-b825-07f9acedbae5︠

︡4f9c27cd-69e6-4386-bef6-546911371be2︡
︠31f1cc03-d862-47fc-b848-f531540441c5︠
#plot in sage :)
f(x) = 2*x^2
g(x) = x^3
n0 = 2
max = 4
y1 = plot(f(x), (0, max), color = 'green', legend_label='$2 x^2$')
y2 = plot(g(x), (0, max), color = 'blue', legend_label='$x^3$')
l1 = line([(n0,0),(n0, max^3)], legend_label='$n_0$', color='red')
p = y1 + y2 + l1
#p += point( (x1,x1), color='red', pointsize=20)
#p += point( (x2,x2), color='red', pointsize=20)
p.show(axes=True, xmin=0, xmax=max, ymin=0, ymax=max^3)
︡83acb3eb-e166-45cc-bfdb-0ba5650abf7b︡{"file":{"filename":"/home/user/.sage/temp/project-f89c1e29-62f1-44f8-9fe9-c1616d5c92e5/849/tmp_7tv_medu.svg","show":true,"text":null,"uuid":"f9fce8c2-9315-4929-98bf-381f16746ce1"},"once":false}︡{"done":true}
︠c6f77f90-9a99-4741-922f-616876848ddci︠
%md

Examples of functions in $O(n^2)$:
 - $n^2$
 - $n^2 + n$
 - $n^2 + 1000n$
 - $1000n^2 + 1000n$
 - $n$
 - $n/1000$
 - $n^{1.99999}$
 - $n^2/\lg \lg \lg n$
 
 #### **"Big-Omega" $\Omega$-notation**

$\Omega(g(n)) = \{f(n) : \exists \, c>0,  n_0>0 \text{ s.t. } 0 \leq c g(n) \leq f(n) \, \forall\, n \geq n_0  \}.$

<img src='images/example_graph_Big_omega.PNG' width=30% />$g(n)$ is an _**asymptotic lower bound**_ for $f(n)$

If $f(n)\in \Omega(g(n))$, we write $f(n) =  \Omega(g(n))$.

_**Example**_

$\sqrt{n} = \Omega(\lg n)$ with $c=1$ and $n_0 = 16$.

︡41ec888c-c7fd-4679-a901-a643cee5351f︡{"done":true,"md":"\nExamples of functions in $O(n^2)$:\n - $n^2$\n - $n^2 + n$\n - $n^2 + 1000n$\n - $1000n^2 + 1000n$\n - $n$\n - $n/1000$\n - $n^{1.99999}$\n - $n^2/\\lg \\lg \\lg n$\n \n #### **\"Big-Omega\" $\\Omega$-notation**\n\n$\\Omega(g(n)) = \\{f(n) : \\exists \\, c>0,  n_0>0 \\text{ s.t. } 0 \\leq c g(n) \\leq f(n) \\, \\forall\\, n \\geq n_0  \\}.$\n\n<img src='images/example_graph_Big_omega.PNG' width=30% />$g(n)$ is an _**asymptotic lower bound**_ for $f(n)$\n\nIf $f(n)\\in \\Omega(g(n))$, we write $f(n) =  \\Omega(g(n))$.\n\n_**Example**_\n\n$\\sqrt{n} = \\Omega(\\lg n)$ with $c=1$ and $n_0 = 16$."}
︠6de523d6-eb75-4e8c-b174-fb5d04b2ac48s︠
import math
print("Invesitigate the base of log(x) in sage.  log(e) = ", log(e).n())
# what is the base of log(x)? __
f(x) = sqrt(x)
g(x) = log(x)/log(2) #recall how to convert to base 2
# OR try h(x) = math.log2(x)--this didn't  work for Dr. Danielson
n0 = 16
max = 2^6
y1 = plot(f(x), (1, max), color = 'green', legend_label='sqrt$(x)$')
y2 = plot(g(x), (1, max), color = 'blue', legend_label='lg$x$')
# y3 = plot(h(x), (1,max), color = 'yellow', legend_label = 'log2$x$')
l1 = line([(n0,0),(n0, 6)], legend_label='$n_0$', color='red')
p = y1 + y2 + l1 # + y3
#p += point( (x1,x1), color='red', pointsize=20)
#p += point( (x2,x2), color='red', pointsize=20)
p.show(axes=True, xmin=0, xmax=max, ymin=0, ymax=6)
︡a2865606-e999-4721-bc6f-3d93d3cc3e95︡{"stdout":"Invesitigate the base of log(x) in sage.  log(e) =  1.00000000000000\n"}︡{"file":{"filename":"/home/user/.sage/temp/project-f89c1e29-62f1-44f8-9fe9-c1616d5c92e5/2475/tmp_tsivd67m.svg","show":true,"text":null,"uuid":"92d1d804-18f0-440a-892b-629bfd5a903a"},"once":false}︡{"done":true}
︠ecd62b5c-b602-4f5d-8c56-bdb108d5cc91i︠
%md

Examples of functions in $\Omega(n^2)$:
 - $n^2$
 - $n^2 + n$
 - $n^2 - n$
 - $1000n^2 + 1000n$
 - $1000n^2 - 1000n$
 - $n^3$
 - $n^{2.00001}$
 - $n^2\cdot\lg \lg \lg n$
 - $2^{2^n}$
 
 #### **"Theta" $\Theta$-notation**

$\Theta(g(n)) = \{f(n) : \exists \, c_1, c_2, n_0>0 \text{ s.t. } 0 \leq c_1 g(n) \leq f(n) \leq c_2 g(n) \, \forall\, n \geq n_0  \}.$

<img src='images/example_graph_Big_theta.PNG' width=30% />$g(n)$ is an _**asymptotically tight bound**_ for $f(n)$

If $f(n)\in \Theta(g(n))$, we write $f(n) =  \Theta(g(n))$.

_**Example**_

$n^2/2 - 2n = \Theta(n^2)$ with $c_1=1/4, c_2 = 1/2$ and $n_0 = 8$.
︡0707b1a6-b132-44ca-b764-eac1e1138721︡{"done":true,"md":"\nExamples of functions in $\\Omega(n^2)$:\n - $n^2$\n - $n^2 + n$\n - $n^2 - n$\n - $1000n^2 + 1000n$\n - $1000n^2 - 1000n$\n - $n^3$\n - $n^{2.00001}$\n - $n^2\\cdot\\lg \\lg \\lg n$\n - $2^{2^n}$\n \n #### **\"Theta\" $\\Theta$-notation**\n\n$\\Theta(g(n)) = \\{f(n) : \\exists \\, c_1, c_2, n_0>0 \\text{ s.t. } 0 \\leq c_1 g(n) \\leq f(n) \\leq c_2 g(n) \\, \\forall\\, n \\geq n_0  \\}.$\n\n<img src='images/example_graph_Big_theta.PNG' width=30% />$g(n)$ is an _**asymptotically tight bound**_ for $f(n)$\n\nIf $f(n)\\in \\Theta(g(n))$, we write $f(n) =  \\Theta(g(n))$.\n\n_**Example**_\n\n$n^2/2 - 2n = \\Theta(n^2)$ with $c_1=1/4, c_2 = 1/2$ and $n_0 = 8$."}
︠9825649f-e4c6-4f64-9918-e45e18d3516cs︠
f(x) = x^2/2 - 2*x
g(x) = x^2
c1 = 1/4
c2 = 1/2
n0 = 8
max = 16
y1 = plot(f(x), (0, max), color = 'green', legend_label='$x^2/2 - 2x$')
y21 = plot(c1*g(x), (0, max), color = 'blue', legend_label='$c1 x^2$')
y22 = plot(c2*g(x), (0, max), color = 'purple', legend_label='$c2 x^2$')
l1 = line([(n0,0),(n0, max^2)], legend_label='$n_0$', color='red')
p = y1 + y21 + y22 + l1
#p += point( (x1,x1), color='red', pointsize=20)
#p += point( (x2,x2), color='red', pointsize=20)
p.show(axes=True, xmin=0, xmax=max, ymin=0, ymax=max^2)
︡6742b5a6-9819-417f-8172-c874507f4f64︡{"file":{"filename":"/home/user/.sage/temp/project-f89c1e29-62f1-44f8-9fe9-c1616d5c92e5/849/tmp_f6n5inaq.svg","show":true,"text":null,"uuid":"bb1a21f4-510e-4172-9560-bfbf40a9f2a9"},"once":false}︡{"done":true}
︠17766feb-00a7-4531-915b-654a3dad9a60i︠
%md

**<u>Theorem 3.1</u>**

$f(n) = \Theta(g(n))$ if and only if $f = O(g(n))$ and $ f = \Omega(g(n))$.

Note: Leading constants and low-order terms don’t matter. 

We usually use Theorem 3.1 to prove asymptotically tight bounds from asymptotic upper and lower bounds.

#### Asymptotic notation in equations

_When on right-hand side_

$O(n^2)$ stands for some anonymous function in the set $O(n^2)$.

$2n^2 + 3n + 1 = 2n^2 + \Theta(n)$ means $2n^2 + 3n + 1 = 2n^2 + f(n)$ for some $f(n) \in \Theta(n)$. (In particular, $f(n) = 3n + 1$.)


We interpret the number of anonymous functions in an expression as equal to the number of times the asymptotic notation appears:

$\sum\limits_{i=1}^n O(i)$ is OK: there is only 1 single anonymous function (a function of $i$).  This is NOT the same as $O(1) + O(2) + \cdots + O(n)$, which doesn't really have a clean interpretation with $n$ hidden constants.

_When on left-hand side_

No matter how the anonymous functions are chosen on the left-hand side, there is a way to choose the anonymous functions on the right-hand side to make the equation valid--

Interpret $2n^2 + \Theta(n) = \Theta(n^2)$ as meaning for all functions $f(n) \in \Theta(n)$, there exists a function $g(n) \in \Theta(n^2)$ such that $2n^2 + f(n) = g(n)$.

We can chain together:

\begin{equation} 
\begin{split}
    2n^2 + 3n + 1  & = 2n^2 + \Theta(n) \\
                   & = \Theta(n^2)
\end{split}
\end{equation}

Interpretation:
 - First equation: There exists $f(n) \in \Theta(n)$ such that $2n^2 + 3n + 1 = 2n^2 + f(n)$
 - Second equation: For all $g(n) \in \Theta(n)$ (such as the $f(n)$ used to make the first equation hold) there exists $h(n)\in\Theta(n^2)$ such that $2n^2 + g(n) = h(n)$
 
#### **"little-oh" $o$-notation**

$o(g(n)) = \{f(n) : \forall \, c>0, \exists\, n_0>0 \text{ s.t. } 0 \leq f(n) < c g(n)\, \forall\, n \geq n_0  \}.$

That is, $f(n) = o(g(n)) \implies \lim\limits_{n\to\infty} \dfrac{f(n)}{g(n)} = 0$.

$o$-notation denotes an upper bound <u>not</u> asymptotically tight.

Examples: $2n^2 = O(n^2)$,  $2n^2 \neq o(n^2)$, but $2n = o(n^2)$.
 - $n^{1.9999} = o(n^2)$
 - $n^2/\lg n = o(n^2)$
 - $n^2 \neq o(n^2)$ (just like $5 \nless 5$)
 - $n^2/1000 \neq o(n^2)$

#### **"little-omega" $\omega$-notation**

$\omega(g(n)) = \{f(n) : \forall \, c>0, \exists\, n_0>0 \text{ s.t. } 0 \leq c g(n) < f(n) \, \forall\, n \geq n_0  \}.$

That is, $f(n) = \omega(g(n)) \implies \lim\limits_{n\to\infty} \dfrac{f(n)}{g(n)} = \infty$.

$\omega$-notation denotes a lower bound <u>not</u> asymptotically tight.

Examples: 
 - $n^{2.0001} = \omega(n^2)$
 - $n^2\lg n = \omega(n^2)$
 - $n^2 \neq \omega(n^2)$ 

︡67cf49db-09c3-467f-8235-361cad8ad6f5︡{"done":true,"md":"\n**<u>Theorem 3.1</u>**\n\n$f(n) = \\Theta(g(n))$ if and only if $f = O(g(n))$ and $ f = \\Omega(g(n))$.\n\nNote: Leading constants and low-order terms don’t matter. \n\nWe usually use Theorem 3.1 to prove asymptotically tight bounds from asymptotic upper and lower bounds.\n\n#### Asymptotic notation in equations\n\n_When on right-hand side_\n\n$O(n^2)$ stands for some anonymous function in the set $O(n^2)$.\n\n$2n^2 + 3n + 1 = 2n^2 + \\Theta(n)$ means $2n^2 + 3n + 1 = 2n^2 + f(n)$ for some $f(n) \\in \\Theta(n)$. (In particular, $f(n) = 3n + 1$.)\n\n\nWe interpret the number of anonymous functions in an expression as equal to the number of times the asymptotic notation appears:\n\n$\\sum\\limits_{i=1}^n O(i)$ is OK: there is only 1 single anonymous function (a function of $i$).  This is NOT the same as $O(1) + O(2) + \\cdots + O(n)$, which doesn't really have a clean interpretation with $n$ hidden constants.\n\n_When on left-hand side_\n\nNo matter how the anonymous functions are chosen on the left-hand side, there is a way to choose the anonymous functions on the right-hand side to make the equation valid--\n\nInterpret $2n^2 + \\Theta(n) = \\Theta(n^2)$ as meaning for all functions $f(n) \\in \\Theta(n)$, there exists a function $g(n) \\in \\Theta(n^2)$ such that $2n^2 + f(n) = g(n)$.\n\nWe can chain together:\n\n\\begin{equation} \n\\begin{split}\n    2n^2 + 3n + 1  & = 2n^2 + \\Theta(n) \\\\\n                   & = \\Theta(n^2)\n\\end{split}\n\\end{equation}\n\nInterpretation:\n - First equation: There exists $f(n) \\in \\Theta(n)$ such that $2n^2 + 3n + 1 = 2n^2 + f(n)$\n - Second equation: For all $g(n) \\in \\Theta(n)$ (such as the $f(n)$ used to make the first equation hold) there exists $h(n)\\in\\Theta(n^2)$ such that $2n^2 + g(n) = h(n)$\n \n#### **\"little-oh\" $o$-notation**\n\n$o(g(n)) = \\{f(n) : \\forall \\, c>0, \\exists\\, n_0>0 \\text{ s.t. } 0 \\leq f(n) < c g(n)\\, \\forall\\, n \\geq n_0  \\}.$\n\nThat is, $f(n) = o(g(n)) \\implies \\lim\\limits_{n\\to\\infty} \\dfrac{f(n)}{g(n)} = 0$.\n\n$o$-notation denotes an upper bound <u>not</u> asymptotically tight.\n\nExamples: $2n^2 = O(n^2)$,  $2n^2 \\neq o(n^2)$, but $2n = o(n^2)$.\n - $n^{1.9999} = o(n^2)$\n - $n^2/\\lg n = o(n^2)$\n - $n^2 \\neq o(n^2)$ (just like $5 \\nless 5$)\n - $n^2/1000 \\neq o(n^2)$\n\n#### **\"little-omega\" $\\omega$-notation**\n\n$\\omega(g(n)) = \\{f(n) : \\forall \\, c>0, \\exists\\, n_0>0 \\text{ s.t. } 0 \\leq c g(n) < f(n) \\, \\forall\\, n \\geq n_0  \\}.$\n\nThat is, $f(n) = \\omega(g(n)) \\implies \\lim\\limits_{n\\to\\infty} \\dfrac{f(n)}{g(n)} = \\infty$.\n\n$\\omega$-notation denotes a lower bound <u>not</u> asymptotically tight.\n\nExamples: \n - $n^{2.0001} = \\omega(n^2)$\n - $n^2\\lg n = \\omega(n^2)$\n - $n^2 \\neq \\omega(n^2)$"}
︠540f06ac-7808-4433-aedb-8a8cc87faa9fi︠
%md

#### Comparisons of functions

Relational properties: 

**Transitivity:**

$f(n) = \Theta(g(n))$ and $g(n) = \Theta(h(n)) \implies f(n) = \Theta(h(n))$.

Same for $O, \Omega, o, \omega$.

**Reflexivity:**

$f(n) = \Theta(f(n))$.

Same for $O, \Omega.$

**Symmetry:**

$f(n) = \Theta(g(n))$ if and only if $g(n) = \Theta(f(n))$

**Transpose symmetry:**

$f(n) = O(g(n))$ if and only if $g(n) = \Omega(f(n))$

$f(n) = o(g(n))$ if and only if $g(n) = \omega(f(n))$

Analogy between the asymptotic comparison of two functions $f$ and $g$ and the comparison of two real numbers $a$ and $b:$
 - $f(n) = O(g(n))$  is like $a\leq b$
 - $f(n) = \Omega(g(n))$  is like $a\geq b$
 - $f(n) = \Theta(g(n))$  is like $a = b$
 - $f(n) = o(g(n))$  is like $a < b$
 - $f(n) = \omega(g(n))$  is like $a > b$
 
Comparisons:
- $f(n)$ is _**asymptotically smaller**_ than $g(n)$ if $f(n) = o(g(n))$.
- $f(n)$ is _**asymptotically larger**_ than $g(n)$ if $f(n) = \omega(g(n))$.

One property of real numbers that does not carry over to asymptotic notation:

**Trichotomy:**  For any two real numbers $a$ and $b$, exactly one of the following must hold: $a < b$, $a = b$, or $a >b $.

Although any two real numbers can be compared, not all functions are asymptotically comparable.

Example: $n$ and $n^{1+\sin(n)}$

Neither $n = O\left(n^{1+\sin(n)}\right)$ nor $n = \Omega\left(n^{1+\sin(n)}\right)$ holds since $1+\sin(n)$ oscillates between 0 and 2, taking on all values in between.

# In groups in class: Discuss WS03.sagews. Due next time.

︡a257f896-1b8c-444b-9a6d-45af2e1aca20︡{"done":true,"md":"\n#### Comparisons of functions\n\nRelational properties: \n\n**Transitivity:**\n\n$f(n) = \\Theta(g(n))$ and $g(n) = \\Theta(h(n)) \\implies f(n) = \\Theta(h(n))$.\n\nSame for $O, \\Omega, o, \\omega$.\n\n**Reflexivity:**\n\n$f(n) = \\Theta(f(n))$.\n\nSame for $O, \\Omega.$\n\n**Symmetry:**\n\n$f(n) = \\Theta(g(n))$ if and only if $g(n) = \\Theta(f(n))$\n\n**Transpose symmetry:**\n\n$f(n) = O(g(n))$ if and only if $g(n) = \\Omega(f(n))$\n\n$f(n) = o(g(n))$ if and only if $g(n) = \\omega(f(n))$\n\nAnalogy between the asymptotic comparison of two functions $f$ and $g$ and the comparison of two real numbers $a$ and $b:$\n - $f(n) = O(g(n))$  is like $a\\leq b$\n - $f(n) = \\Omega(g(n))$  is like $a\\geq b$\n - $f(n) = \\Theta(g(n))$  is like $a = b$\n - $f(n) = o(g(n))$  is like $a < b$\n - $f(n) = \\omega(g(n))$  is like $a > b$\n \nComparisons:\n- $f(n)$ is _**asymptotically smaller**_ than $g(n)$ if $f(n) = o(g(n))$.\n- $f(n)$ is _**asymptotically larger**_ than $g(n)$ if $f(n) = \\omega(g(n))$.\n\nOne property of real numbers that does not carry over to asymptotic notation:\n\n**Trichotomy:**  For any two real numbers $a$ and $b$, exactly one of the following must hold: $a < b$, $a = b$, or $a >b $.\n\nAlthough any two real numbers can be compared, not all functions are asymptotically comparable.\n\nExample: $n$ and $n^{1+\\sin(n)}$\n\nNeither $n = O\\left(n^{1+\\sin(n)}\\right)$ nor $n = \\Omega\\left(n^{1+\\sin(n)}\\right)$ holds since $1+\\sin(n)$ oscillates between 0 and 2, taking on all values in between.\n\n# In groups in class: Discuss WS03.sagews. Due next time."}









