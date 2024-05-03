︠4e82f0d0-371a-409c-9ebb-1f98ffc699cbi︠
%md

# II Sorting and Order Statistics

### Your name: !!

Solve the **_sorting problem:_**

 - **Input:** A sequence of $n$ numbers $A = (a_1,a_2,\dots, a_n)$
 - **Output:** A permutation/reordering $(a_1', a_2',\cdots, a_n')$ of the input set $A$ with $a_1'\leq a_2'\leq \cdots \leq a_n'$

In practice, we are sorting <u>records</u> based on a <u>key</u>
 - the remainder of the record consists of <u>satellite data</u>, carried around with the key
 
# Chapter 6 Heapsort!

 - $O(n\lg n)$worst case -- like merge sort
 - Sorts in place -- like insertion sort
 - Combines the best of both algorithms
 
To understand heapsort, we’ll cover heaps and heap operations, and then we’ll take a look at priority queues.

## First: Appendix B.5.3 Binary Trees

Defined recursively:

(page 1177)  A **<u>binary tree</u> $T$** is on a finite set of nodes that either
 - contains no nodes, or
 - is composed of three disjoint sets of nodes: 
   - a **_root node_** 
   - a binary tree called its **_left subtree_**
   - binary tree called its **_right subtree_**
   
A **<u>complete binary tree</u>** is a binary tree in which all leaves have the same depth and all internal nodes have two children.

The **_depth_** of a node $p$ is the number of edges from the root to the node.

The **_height_** of a tree is the maximum depth of any node.

https://lucid.app/lucidchart/invitations/accept/d7ab152a-1d1d-49e3-9cb6-d8de8b2a36f0

A **<u>nearly complete binary tree</u>** is a tree that is completely filled on all levels, except possibly the lowest level, which is filled from the left up to a point.

# 6.1 Heaps

The (binary) <u><strong>heap</strong></u> data structure is a nearly complete binary tree where
 - the <u>height of a node</u> is the number of edges on a longest simple path from the node down to a leaf
 - the <u>height of the heap</u> is the height of the root = $\Theta(\lg n)$ (why?).
 
A heap can be stored as an array $A$:
 - root of tree is $A[1]$
 - parent of $A[i] = A[\lfloor i/2\rfloor]$
 - left child of $A[i] = A[2i]$
 - right child of $A[i] = A[2i+1]$
 - Computing is fast!
 
### <u>Example of a max-heap</u>

https://lucid.app/lucidchart/invitations/accept/a7ca84ff-a8e1-4a41-9df7-4abf2ff2f2e2


︡bd9aa5c9-05da-49c0-b116-f675d9daba20︡{"done":true,"md":"\n# II Sorting and Order Statistics\n\n### Your name: !!\n\nSolve the **_sorting problem:_**\n\n - **Input:** A sequence of $n$ numbers $A = (a_1,a_2,\\dots, a_n)$\n - **Output:** A permutation/reordering $(a_1', a_2',\\cdots, a_n')$ of the input set $A$ with $a_1'\\leq a_2'\\leq \\cdots \\leq a_n'$\n\nIn practice, we are sorting <u>records</u> based on a <u>key</u>\n - the remainder of the record consists of <u>satellite data</u>, carried around with the key\n \n# Chapter 6 Heapsort!\n\n - $O(n\\lg n)$worst case -- like merge sort\n - Sorts in place -- like insertion sort\n - Combines the best of both algorithms\n \nTo understand heapsort, we’ll cover heaps and heap operations, and then we’ll take a look at priority queues.\n\n## First: Appendix B.5.3 Binary Trees\n\nDefined recursively:\n\n(page 1177)  A **<u>binary tree</u> $T$** is on a finite set of nodes that either\n - contains no nodes, or\n - is composed of three disjoint sets of nodes: \n   - a **_root node_** \n   - a binary tree called its **_left subtree_**\n   - binary tree called its **_right subtree_**\n   \nA **<u>complete binary tree</u>** is a binary tree in which all leaves have the same depth and all internal nodes have two children.\n\nThe **_depth_** of a node $p$ is the number of edges from the root to the node.\n\nThe **_height_** of a tree is the maximum depth of any node.\n\nhttps://lucid.app/lucidchart/invitations/accept/d7ab152a-1d1d-49e3-9cb6-d8de8b2a36f0\n\nA **<u>nearly complete binary tree</u>** is a tree that is completely filled on all levels, except possibly the lowest level, which is filled from the left up to a point.\n\n# 6.1 Heaps\n\nThe (binary) <u><strong>heap</strong></u> data structure is a nearly complete binary tree where\n - the <u>height of a node</u> is the number of edges on a longest simple path from the node down to a leaf\n - the <u>height of the heap</u> is the height of the root = $\\Theta(\\lg n)$ (why?).\n \nA heap can be stored as an array $A$:\n - root of tree is $A[1]$\n - parent of $A[i] = A[\\lfloor i/2\\rfloor]$\n - left child of $A[i] = A[2i]$\n - right child of $A[i] = A[2i+1]$\n - Computing is fast!\n \n### <u>Example of a max-heap</u>\n\nhttps://lucid.app/lucidchart/invitations/accept/a7ca84ff-a8e1-4a41-9df7-4abf2ff2f2e2"}
︠583e0c60-3590-44a9-b898-1ca68a7d641f︠
%hide
####### Do not run :)######
#pseudocode                                     
PARENT(i):
    return i/2

LEFT(i):
    return 2i

RIGHT(i):
    return (2i+1)

####### Do not run :)######
︡fffac869-e1f6-45e3-907b-33f4c816d37f︡
︠3e9a11e1-e578-4f8e-bde2-dcf3967de402︠
%md

## Heap property (there are 2 kinds of heaps)

 - For <u>max-heaps</u> (largest element at the root): 
   - _<u>max-heap property</u>_: for all nodes $i$, excluding the root, $A[Parent(i)] \geq A[i]$
 - For <u>min-heaps</u> (smallest element at the root): 
   - _<u>min-heap property</u>_: for all nodes $i$, excluding the root, $A[Parent(i)] \leq A[i]$
   
By induction and transitivity of $\leq$, the max(min)-heap property guarantees the maximum(minimum) element at the root of a max(min)-heap.

For the heapsort algorithm, we use max-heaps (min-heaps implement priority queues).

Note: In general, heaps can be any $k$-ary tree instead of binary.

**At the boards in groups:** 

1. What are the minimum and maximum number of elements in a heap of height 5? (This is Ex 3 on WS08. Justify answers in WS.)
2. What are the minimum and maximum number of elements in a heap of height $k$? (This is Ex 4 on WS08. Justify answers in WS.)

**Solution**

︡4158eaae-83a7-4da0-bd60-0dcbc0e526cd︡{"done":true,"md":"\n## Heap property (there are 2 kinds of heaps)\n\n - For <u>max-heaps</u> (largest element at the root): \n   - _<u>max-heap property</u>_: for all nodes $i$, excluding the root, $A[Parent(i)] \\geq A[i]$\n - For <u>min-heaps</u> (smallest element at the root): \n   - _<u>min-heap property</u>_: for all nodes $i$, excluding the root, $A[Parent(i)] \\leq A[i]$\n   \nBy induction and transitivity of $\\leq$, the max(min)-heap property guarantees the maximum(minimum) element at the root of a max(min)-heap.\n\nFor the heapsort algorithm, we use max-heaps (min-heaps implement priority queues).\n\nNote: In general, heaps can be any $k$-ary tree instead of binary.\n\n**At the boards in groups:** \n\n1. What are the minimum and maximum number of elements in a heap of height 5? (This is Ex 3 on WS08. Justify answers in WS.)\n2. What are the minimum and maximum number of elements in a heap of height $k$? (This is Ex 4 on WS08. Justify answers in WS.)\n\n**Solution**"}
︠937b78ec-c088-4551-b32a-c7af0cd89ea3︠
%md

# 6.2 Maintaining the heap order

MAX-HEAPIFY is important for manipulating max-heaps. It is used to maintain the max-heap property.

 - Before MAX-HEAPIFY, $A[i]$ may be smaller than its children
 - Assume LEFT(i) and RIGHT(i) are max-heaps, but $A[i]$ might be smaller than it's children.
   - MAX-HEAPIFY lets the value at $A[i]$ "ﬂoat down" in the max-heap
 - After MAX-HEAPIFY, subtree rooted at $i$ is a max-heap.
 
︡aaac1328-d52c-42e7-ad2c-e3125721b771︡{"done":true,"md":"\n# 6.2 Maintaining the heap order\n\nMAX-HEAPIFY is important for manipulating max-heaps. It is used to maintain the max-heap property.\n\n - Before MAX-HEAPIFY, $A[i]$ may be smaller than its children\n - Assume LEFT(i) and RIGHT(i) are max-heaps, but $A[i]$ might be smaller than it's children.\n   - MAX-HEAPIFY lets the value at $A[i]$ \"ﬂoat down\" in the max-heap\n - After MAX-HEAPIFY, subtree rooted at $i$ is a max-heap."}
︠c5712185-d29c-4916-bfc2-fc9c325623dfo︠
%hide
####### Do not run :)######
#pseudocode                                     
MAX-HEAPIFY(A, i, n):
    l = LEFT(i)
    r = RIGHT(i)
    if l<=n and A[l] > A[i]:
        largest = l
    else:
        largest = i
    if r<=n and A[r]>A[largest]:
        lergest = r
    if largest != i:
        exchange A[i] with A[largest]
        MAX-HEAPIFY(A, largest, n)

####### Do not run :)######
︡0ac67944-9290-4381-b4c4-22ceb8bb9b85︡{"stderr":"Error in lines 1-12\n"}︡{"stderr":"Traceback (most recent call last):\n  File \"/cocalc/lib/python3.8/site-packages/smc_sagews/sage_server.py\", line 1210, in execute\n    exec(compile(block2, '', 'single'), namespace,\n  File \"\", line 1, in <module>\n  File \"sage/misc/session.pyx\", line 215, in sage.misc.session.show_identifiers (build/cythonized/sage/misc/session.c:2235)\n    from sage.doctest.forker import DocTestTask\n  File \"/ext/sage/sage-9.2/local/lib/python3.8/site-packages/sage/doctest/forker.py\", line 54, in <module>\n    import IPython.lib.pretty\n  File \"/ext/sage/sage-9.2/local/lib/python3.8/site-packages/IPython/__init__.py\", line 56, in <module>\n    from .terminal.embed import embed\n  File \"/ext/sage/sage-9.2/local/lib/python3.8/site-packages/IPython/terminal/embed.py\", line 16, in <module>\n    from IPython.terminal.interactiveshell import TerminalInteractiveShell\n  File \"/ext/sage/sage-9.2/local/lib/python3.8/site-packages/IPython/terminal/interactiveshell.py\", line 19, in <module>\n    from prompt_toolkit.enums import DEFAULT_BUFFER, EditingMode\n  File \"/ext/sage/sage-9.2/local/lib/python3.8/site-packages/prompt_toolkit/__init__.py\", line 16, in <module>\n    from .application import Application\n  File \"/ext/sage/sage-9.2/local/lib/python3.8/site-packages/prompt_toolkit/application/__init__.py\", line 1, in <module>\n    from .application import Application\n  File \"/ext/sage/sage-9.2/local/lib/python3.8/site-packages/prompt_toolkit/application/application.py\", line 55, in <module>\n    from prompt_toolkit.key_binding.defaults import load_key_bindings\n  File \"/ext/sage/sage-9.2/local/lib/python3.8/site-packages/prompt_toolkit/key_binding/defaults.py\", line 10, in <module>\n    from prompt_toolkit.key_binding.bindings.emacs import (\n  File \"<frozen importlib._bootstrap>\", line 991, in _find_and_load\n  File \"<frozen importlib._bootstrap>\", line 975, in _find_and_load_unlocked\n  File \"<frozen importlib._bootstrap>\", line 671, in _load_unlocked\n  File \"<frozen importlib._bootstrap_external>\", line 779, in exec_module\n  File \"<frozen importlib._bootstrap_external>\", line 874, in get_code\n  File \"<frozen importlib._bootstrap_external>\", line 972, in get_data\n  File \"src/cysignals/signals.pyx\", line 320, in cysignals.signals.python_check_interrupt\nKeyboardInterrupt\n"}︡{"done":true}
︠99a9c91e-3ee6-4cc9-9844-6cb620bdb9a3i︠
%md

### The way MAX-HEAPIFY works:

 - Compare $A[i]$, $A[LEFT(i)]$, and $A[RIGHT(i)]$
 - If necessary, swap $A[i]$ with the larger of the two children to preserve heap property
 - Continue this process of comparing and swapping down the heap, until subtree rooted at $i$ is max-heap. If we hit a leaf, then the subtree rooted at the leaf is trivially a max-heap.
 
 Example: https://lucid.app/lucidchart/invitations/accept/aa61e3df-58a4-4b59-9907-eaf870b6d93f
 
### Time

$O(\lg n)$

_Analysis_

A heap is a nearly complete binary tree, thus we must process $O(\lg n)$ levels, with constant work at each level (comparing 3 items and maybe swapping 2).
︡66d310f0-4ae0-4bfe-8c50-40fc98919a51︡{"done":true,"md":"\n### The way MAX-HEAPIFY works:\n\n - Compare $A[i]$, $A[LEFT(i)]$, and $A[RIGHT(i)]$\n - If necessary, swap $A[i]$ with the larger of the two children to preserve heap property\n - Continue this process of comparing and swapping down the heap, until subtree rooted at $i$ is max-heap. If we hit a leaf, then the subtree rooted at the leaf is trivially a max-heap.\n \n Example: https://lucid.app/lucidchart/invitations/accept/aa61e3df-58a4-4b59-9907-eaf870b6d93f\n \n### Time\n\n$O(\\lg n)$\n\n_Analysis_\n\nA heap is a nearly complete binary tree, thus we must process $O(\\lg n)$ levels, with constant work at each level (comparing 3 items and maybe swapping 2)."}









