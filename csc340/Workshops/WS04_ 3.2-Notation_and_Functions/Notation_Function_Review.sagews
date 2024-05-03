︠47f78dbe-c5ab-4127-b7eb-5ce23fc227bb︠
%md

# 3.2 Standard Notations and Common Functions

### Your name: ??

## Monotonicity

1. Complete the **Monotonicity** definitions:
- (a) A function $ f(n)$ is _monotonically increasing_ if...
- (b) A function $ f(n)$ is _monotonically decreasing_ if...
- (c) A function $ f(n)$ is _strictly increasing_ if...
- (d) A function $ f(n)$ is _strictly decreasing_ if...
︡25b6d2b0-4d7a-416a-ad20-dffe0107aad1︡{"done":true,"md":"\n# 3.2 Standard Notations and Common Functions\n\n### Your name: ??\n\n## Monotonicity\n\n1. Complete the **Monotonicity** definitions:\n- (a) A function $ f(n)$ is _monotonically increasing_ if...\n- (b) A function $ f(n)$ is _monotonically decreasing_ if...\n- (c) A function $ f(n)$ is _strictly increasing_ if...\n- (d) A function $ f(n)$ is _strictly decreasing_ if..."}
︠03b3b4ef-792b-45a0-a839-b9d0c77cdece︠
%md

## Exponentials

1. Complete the useful **Exponential** identities:
- (a) $ a^{-1} = $
- (b) $ (a^m)^n = $
- (c) $ a^m a^n = $

2. We can relate rates of growth of polynomials and exponentials:
- (a) For all real constants $a$ and $b$ such that $a > 1$, $ \displaystyle\lim_{n \to \infty} \frac{n^b}{a^n} = $ ??  (Why?)
- (b) which implies that $n^b = ?? \left( a^n \right) $ (write/circle $ O, \Omega, \Theta, o,$ or $ \omega $).
- (c) Thus any exponential function with a base strictly greater than $1$ grows ?? than any polynomial function (write _faster_ or _slower_).

3. $e^x$
- (a) Write the Taylor series for $ e^x = $ \
- (b) This gives a surprisingly useful inequality: for all real $x$, $e^x ?? 1+x $ (write $\geq$ or $\le$).
- (c) And as $x$ gets closer to $0$, $e^x$ gets closer to...

︡da0c761b-665b-4b03-ad8a-873ad282aaff︡{"done":true,"md":"\n## Exponentials\n\n1. Complete the useful **Exponential** identities:\n- (a) $ a^{-1} = $\n- (b) $ (a^m)^n = $\n- (c) $ a^m a^n = $\n\n2. We can relate rates of growth of polynomials and exponentials:\n- (a) For all real constants $a$ and $b$ such that $a > 1$, $ \\displaystyle\\lim_{n \\to \\infty} \\frac{n^b}{a^n} = $ ??  (Why?)\n- (b) which implies that $n^b = ?? \\left( a^n \\right) $ (write/circle $ O, \\Omega, \\Theta, o,$ or $ \\omega $).\n- (c) Thus any exponential function with a base strictly greater than $1$ grows ?? than any polynomial function (write _faster_ or _slower_).\n\n3. $e^x$\n- (a) Write the Taylor series for $ e^x = $ \\\n- (b) This gives a surprisingly useful inequality: for all real $x$, $e^x ?? 1+x $ (write $\\geq$ or $\\le$).\n- (c) And as $x$ gets closer to $0$, $e^x$ gets closer to..."}
︠4757aa18-2faf-4c1f-bc68-c3fd8bcd783b︠
%md

## Logarithms

1. Complete the useful **Logarithm** identities for $a>0, b>0, c>0$:
- (a) $ b^{\log_b a} = $
- (b) $ \log_c(ab)= $
- (c) $ \log_b(a^n) = $
- (d) $\frac{\log_c a}{\log_c b} = $ ?? (Change of base formula)
- (e) $ \log_b (1/a) = $
- (f)  Relate $ \log_b a $ and $ \log_a b $:
- (g)  $ a^{\log_b c} = c^?$ where ? = ???

2. Changing the base of a logarithm from one constant to another only changes the value by a constant factor, so we usually don’t worry about logarithm bases in asymptotic notation. Convention is to use ?? within asymptotic notation, unless the base actually matters.

3. Just as polynomials grow more ?? than exponentials, logarithms grow more ?? than polynomials (write _slowly_ or _quickly_ in each case).

4. Justify the limit:
- (a) $ \displaystyle\lim_{n \to \infty} \frac{\lg^b n}{(2^a)^{\lg n}} = \displaystyle\lim_{n \to \infty} \frac{\lg^b n}{n^a} = 0$
- (b) which implies that $\lg^b n = ?? \left( n^a \right) $ (write/circle $ O, \Omega, \Theta, o,$ or $ \omega $).
︡a78ebe41-06a1-4e5c-9e6a-5f2d7a35e8ae︡{"done":true,"md":"\n## Logarithms\n\n1. Complete the useful **Logarithm** identities for $a>0, b>0, c>0$:\n- (a) $ b^{\\log_b a} = $\n- (b) $ \\log_c(ab)= $\n- (c) $ \\log_b(a^n) = $\n- (d) $\\frac{\\log_c a}{\\log_c b} = $ ?? (Change of base formula)\n- (e) $ \\log_b (1/a) = $\n- (f)  Relate $ \\log_b a $ and $ \\log_a b $:\n- (g)  $ a^{\\log_b c} = c^?$ where ? = ???\n\n2. Changing the base of a logarithm from one constant to another only changes the value by a constant factor, so we usually don’t worry about logarithm bases in asymptotic notation. Convention is to use ?? within asymptotic notation, unless the base actually matters.\n\n3. Just as polynomials grow more ?? than exponentials, logarithms grow more ?? than polynomials (write _slowly_ or _quickly_ in each case).\n\n4. Justify the limit:\n- (a) $ \\displaystyle\\lim_{n \\to \\infty} \\frac{\\lg^b n}{(2^a)^{\\lg n}} = \\displaystyle\\lim_{n \\to \\infty} \\frac{\\lg^b n}{n^a} = 0$\n- (b) which implies that $\\lg^b n = ?? \\left( n^a \\right) $ (write/circle $ O, \\Omega, \\Theta, o,$ or $ \\omega $)."}
︠60228830-afd2-4915-b1d2-b126c2464bf3︠
%md

## Factorials

1. $n!$
- (a) $n! = $
- (b)  $0! = $   ?? (Why?)
- (c)  Write down _Stirling’s approximation_:
- (d)  $ n! = o(??)$
- (e)  $ n! = \omega(??)$
- (f)  $ \lg(n!) = \Theta(??)$
︡ce421daa-c4f2-4a21-8e34-b163e8ce6be9︡{"done":true,"md":"\n## Factorials\n\n1. $n!$\n- (a) $n! = $\n- (b)  $0! = $   ?? (Why?)\n- (c)  Write down _Stirling’s approximation_:\n- (d)  $ n! = o(??)$\n- (e)  $ n! = \\omega(??)$\n- (f)  $ \\lg(n!) = \\Theta(??)$"}
︠e60f772d-5c54-4996-88f5-6f3dc97a0249︠
%md

## Test your understanding

1. Let $k\geq 1$ and $c>0$ Consider $\lg^k n$ and $n^c$.  Yes or no? Justify your responses.
- (a) Is $\lg^k n = O(n^c)$?
- (b) Is $\lg^k n = o(n^c)$?
- (c) Is $\lg^k n = \Omega(n^c)$?
- (d) Is $\lg^k n = \omega(n^c)$?
- (e) Is $\lg^k n = \Theta(n^c)$?

2. Let $k\geq 1$ and $c>0$ Consider $n^k$ and $c^n$.  Yes or no? Justify your responses.
- (a) Is $n^k = O(c^n)$?
- (b) Is $n^k = o(c^n)$?
- (c) Is $n^k = \Omega(c^n)$?
- (d) Is $n^k= \omega(c^n)$?
- (e) Is $n^k = \Theta(c^n)$?

3. Consider $\lg(n!)$ and $\lg(n^n)$.  Yes or no?  Justify your responses.
- (a) Is $\lg(n!) = O(c^n)$?
- (b) Is $\lg(n!) = o(c^n)$?
- (c) Is $\lg(n!) = \Omega(c^n)$?
- (d) Is $\lg(n!)= \omega(c^n)$?
- (e) Is $\lg(n!) = \Theta(c^n)$?
︡e42d3e82-8db7-4864-b570-26be2c6dc2aa︡{"done":true,"md":"\n## Test your understanding\n\n1. Let $k\\geq 1$ and $c>0$ Consider $\\lg^k n$ and $n^c$.  Yes or no? Justify your responses.\n- (a) Is $\\lg^k n = O(n^c)$?\n- (b) Is $\\lg^k n = o(n^c)$?\n- (c) Is $\\lg^k n = \\Omega(n^c)$?\n- (d) Is $\\lg^k n = \\omega(n^c)$?\n- (e) Is $\\lg^k n = \\Theta(n^c)$?\n\n2. Let $k\\geq 1$ and $c>0$ Consider $n^k$ and $c^n$.  Yes or no? Justify your responses.\n- (a) Is $n^k = O(c^n)$?\n- (b) Is $n^k = o(c^n)$?\n- (c) Is $n^k = \\Omega(c^n)$?\n- (d) Is $n^k= \\omega(c^n)$?\n- (e) Is $n^k = \\Theta(c^n)$?\n\n3. Consider $\\lg(n!)$ and $\\lg(n^n)$.  Yes or no?  Justify your responses.\n- (a) Is $\\lg(n!) = O(c^n)$?\n- (b) Is $\\lg(n!) = o(c^n)$?\n- (c) Is $\\lg(n!) = \\Omega(c^n)$?\n- (d) Is $\\lg(n!)= \\omega(c^n)$?\n- (e) Is $\\lg(n!) = \\Theta(c^n)$?"}









