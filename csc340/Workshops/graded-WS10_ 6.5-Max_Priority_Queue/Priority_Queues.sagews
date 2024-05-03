︠b6b01d32-b4eb-452f-bb69-456910140df0︠
%md

# 6.5 Priority Queues

#### Your name: !!

Our authors state:

>"Heapsort is an excellent algorithm, but a good implementation of quicksort, presented in Chapter 7, usually beats it in practice."

- Heaps efficiently implement priority queues. 
- A heap gives a good compromise between fast insertion but slow extraction and vice versa. 
  - Both operations take $O(\lg n)$ time.
  
We will consider max-priority queues implemented with max-heaps. Min-priority queues are implemented with min-heaps similarly.

##  Priority queues

 - Maintains a dynamic set $S$ of elements.
 - Each set element has a **_key_**—an associated value.
 - A **_max-priority queue_** supports dynamic-set operations:
    - INSERT($S, x$): inserts element $x$ into set $S$.
    - MAXIMUM($S$): returns element of $S$ with the largest key.
    - EXTRACT-MAX($S$): removes and returns element of $S$ with the largest key.
    - INCREASE-KEY($S, x, k$): increases value of element $x$’s key to $k$. Assume $k \geq x$’s current key value.
- Example max-priority queue application: schedule jobs on shared computer, serving jobs with the highest priority first.

- A **_min-priority queue_** supports similar operations:
    - INSERT($S, x$): inserts element $x$ into set $S$.
    - MINIMUM($S$): returns element of $S$ with the smallest key.
    - EXTRACT-MIN($S$): removes and returns element of $S$ with the smallest key.
    - DECREASE-KEY($S, x, k$): decreases value of element $x$’s key to $k$. Assume $k \leq x$’s current key value.
- Example min-priority queue application: an event-driven simulator: the items in the queue are events to be simulated, each with an associated time of occurrence that serves as its key. The events must be simulated in order of their time of occurrence, because the simulation of an event can cause  other events to be simulated in the future.
︡b8c8cfea-7763-42fd-bf34-5541eefd7da9︡{"done":true,"md":"\n# 6.5 Priority Queues\n\n#### Your name: !!\n\nOur authors state:\n\n>\"Heapsort is an excellent algorithm, but a good implementation of quicksort, presented in Chapter 7, usually beats it in practice.\"\n\n- Heaps efficiently implement priority queues. \n- A heap gives a good compromise between fast insertion but slow extraction and vice versa. \n  - Both operations take $O(\\lg n)$ time.\n  \nWe will consider max-priority queues implemented with max-heaps. Min-priority queues are implemented with min-heaps similarly.\n\n##  Priority queues\n\n - Maintains a dynamic set $S$ of elements.\n - Each set element has a **_key_**—an associated value.\n - A **_max-priority queue_** supports dynamic-set operations:\n    - INSERT($S, x$): inserts element $x$ into set $S$.\n    - MAXIMUM($S$): returns element of $S$ with the largest key.\n    - EXTRACT-MAX($S$): removes and returns element of $S$ with the largest key.\n    - INCREASE-KEY($S, x, k$): increases value of element $x$’s key to $k$. Assume $k \\geq x$’s current key value.\n- Example max-priority queue application: schedule jobs on shared computer, serving jobs with the highest priority first.\n\n- A **_min-priority queue_** supports similar operations:\n    - INSERT($S, x$): inserts element $x$ into set $S$.\n    - MINIMUM($S$): returns element of $S$ with the smallest key.\n    - EXTRACT-MIN($S$): removes and returns element of $S$ with the smallest key.\n    - DECREASE-KEY($S, x, k$): decreases value of element $x$’s key to $k$. Assume $k \\leq x$’s current key value.\n- Example min-priority queue application: an event-driven simulator: the items in the queue are events to be simulated, each with an associated time of occurrence that serves as its key. The events must be simulated in order of their time of occurrence, because the simulation of an event can cause  other events to be simulated in the future."}
︠a59b5e6e-5e25-4b6c-8008-825e58926e72︠
%md

 **At the boards:**

1. FIFO Example: consider the following job requests coming in to a shared computer:
 -  J1 requiring time 40
 -  J2 requiring time 4
 -  J3 requiring time 20
 -  J4 requiring time 8
 
and suppose the requests arrive in a FIFO (first-in-first-out) queue–meaning the server responds to the job requests in the arrival order. Then the waiting time for each job to be completed is:
 - J1: 40
 - J2: 40 + 4 = 44
 - J3: __
 - J4: __
 
 Compute the average wait time using the ordinary queue data structure. __
 
2. Min-queue Example: Consider the same job requests coming in to a shared computer:
 -  J1 requiring time 40
 -  J2 requiring time 4
 -  J3 requiring time 20
 -  J4 requiring time 8
and suppose the requests arrive in a queue but now the server responds to the job requests according to the job time, serving the jobs with minimum times first. Now the waiting time for each job to be completed is:
 - J2: 4
 - J4: 4 + 8 = 12
 - __
 - __
 
 Compute the average wait time using the min-queue data structure. __
︡ff9656f1-2cf0-4719-ac13-9c52f79d353a︡{"done":true,"md":"\n **At the boards:**\n\n1. FIFO Example: consider the following job requests coming in to a shared computer:\n -  J1 requiring time 40\n -  J2 requiring time 4\n -  J3 requiring time 20\n -  J4 requiring time 8\n \nand suppose the requests arrive in a FIFO (first-in-first-out) queue–meaning the server responds to the job requests in the arrival order. Then the waiting time for each job to be completed is:\n - J1: 40\n - J2: 40 + 4 = 44\n - J3: __\n - J4: __\n \n Compute the average wait time using the ordinary queue data structure. __\n \n2. Min-queue Example: Consider the same job requests coming in to a shared computer:\n -  J1 requiring time 40\n -  J2 requiring time 4\n -  J3 requiring time 20\n -  J4 requiring time 8\nand suppose the requests arrive in a queue but now the server responds to the job requests according to the job time, serving the jobs with minimum times first. Now the waiting time for each job to be completed is:\n - J2: 4\n - J4: 4 + 8 = 12\n - __\n - __\n \n Compute the average wait time using the min-queue data structure. __"}
︠1478b139-9cd1-4141-9848-74317880a393i︠
%md

### Max-priority queue operations

Getting the maximum element is easy: it’s the root!
︡76f2cc03-6fbf-4934-80ef-450486929c40︡{"done":true,"md":"\n### Max-priority queue operations\n\nGetting the maximum element is easy: it’s the root!"}
︠fce3e43f-2d36-4ae4-ac3d-c97f3d7de501so︠
####### Do not run :)######
#pseudocode                                     

HEAP-MAXIMUM(A)
    return A[1]
    
####### Do not run :)######

︡022fb8b9-9904-4041-abce-4ceb7cc4c97a︡{"stderr":"Error in lines 1-2\n"}︡{"stderr":"Traceback (most recent call last):\n  File \"/cocalc/lib/python3.8/site-packages/smc_sagews/sage_server.py\", line 1231, in execute\n    compile(block + '\\n',\n  File \"<string>\", line 1\n    HEAP-MAXIMUM(A)\n                  ^\nSyntaxError: multiple statements found while compiling a single statement\n"}︡{"done":true}
︠5f73a989-0306-4595-9209-f9ea0c327167i︠
%md

**At the boards:**

3. What is the time complexity of HEAP-MAXIMUM? __
︡345466cd-5a9b-46ae-8eb7-0559c1e05a0c︡{"done":true,"md":"\n**At the boards:**\n\n3. What is the time complexity of HEAP-MAXIMUM? __"}
︠bbb65894-c080-4645-bdbd-1ceb055cd8b5i︠
%md

Consider extracting the max element. Given the array A:
 - Make sure heap is not empty.
 - Make a copy of the maximum element (the root).
 - Make the last node in the tree the new root.
 - Re-heapify the heap, with one fewer node.
 - Return the copy of the maximum element.
︡5d36aa10-7ab6-4317-b734-767332e672f2︡{"done":true,"md":"\nConsider extracting the max element. Given the array A:\n - Make sure heap is not empty.\n - Make a copy of the maximum element (the root).\n - Make the last node in the tree the new root.\n - Re-heapify the heap, with one fewer node.\n - Return the copy of the maximum element."}
︠d7c80d49-da7c-4583-b4db-4bf0da4e8703︠
####### Do not run :)######
#pseudocode                                     

HEAP-EXTRACT-MAX(A,n)
    if n < 1:
        error "heap underflow"
    max = A[1]
    A[1] = A[n]
    n = n - 1
    MAX-HEAPIFY(A, 1, n) // remakes heap
    return max
    
####### Do not run :)######
︡d2961972-e54a-4c18-a140-f76dc13e3384︡
︠d1daa864-f74b-4acf-8cdb-7d83bd0361fai︠
%md

**At the boards:**

4. What is the time complexity of HEAP-EXTRACT-MAX? Explain briefly.__

5. Illustrate the operation of HEAP-EXTRACT-MAX on the heap A = ⟨15, 13, 9, 5, 12, 8, 7, 4, 0, 6, 2, 1⟩. 
︡dcb864c5-3fe7-4917-8454-a46cf911847d︡{"done":true,"md":"\n**At the boards:**\n\n4. What is the time complexity of HEAP-EXTRACT-MAX? Explain briefly.__\n\n5. Illustrate the operation of HEAP-EXTRACT-MAX on the heap A = ⟨15, 13, 9, 5, 12, 8, 7, 4, 0, 6, 2, 1⟩."}
︠5dea1a19-6589-4963-ad40-38476cbf3b98i︠
%md

Consider increasing a key value. Given the set $S$, element $x$, and new key value $k$:
 - Make sure $k \geq x$’s current key.
 - Update $x$’s key value to $k$.
 - Traverse the tree upward comparing $x$ to its parent and swapping keys if necessary, until $x$’s key is smaller than its parent’s key.
︡90a02ff1-28cd-419e-b477-303ed2843fb2︡{"done":true,"md":"\nConsider increasing a key value. Given the set $S$, element $x$, and new key value $k$:\n - Make sure $k \\geq x$’s current key.\n - Update $x$’s key value to $k$.\n - Traverse the tree upward comparing $x$ to its parent and swapping keys if necessary, until $x$’s key is smaller than its parent’s key."}
︠96f8f38f-0626-4b95-b6dc-a0c8d970c9b4︠
####### Do not run :)######
#pseudocode                                     

HEAP-INCREASE-KEY(A,i,key)
    if key < A[i]:
        error "new key is smaller than current key"
    A[i] = key
    while i > 1 and A[PARENT(i)] < A[i]:
        exchange A[i] with A[PARENT(i)]
        i = PARENT(i)
    
####### Do not run :)######
︡2bb4e8f0-1b16-4bbd-bb1f-71883bca0379︡
︠138d0299-2f6b-4692-a54b-ada51eb67c91i︠
%md

**At the boards:**

6. What is the time complexity of HEAP-INCREASE-KEY? Explain briefly.

7. Illustrate the operation of HEAP-INCREASE-KEY(A, 9, 14) on the heap A = ⟨15, 13, 9, 5, 12, 8, 7, 4, 0, 6, 2, 1⟩.
︡ec638c8d-510e-45a1-9565-edd1ea98596f︡{"done":true,"md":"\n**At the boards:**\n\n6. What is the time complexity of HEAP-INCREASE-KEY? Explain briefly.\n\n7. Illustrate the operation of HEAP-INCREASE-KEY(A, 9, 14) on the heap A = ⟨15, 13, 9, 5, 12, 8, 7, 4, 0, 6, 2, 1⟩."}
︠a84bb5bb-b854-48db-b480-0a3f126d5417i︠
%md

Consider inserting into the heap. Given a key $k$ to insert into the heap:
 - Increment the heap size.
 - Insert a new node in the last position in the heap, with key $-\infty$.
 - Increase the $-\infty$ key to $k$ using the HEAP-INCREASE-KEY procedure defined above.
︡b6144461-e121-4c49-b73d-3ea50029344d︡{"done":true,"md":"\nConsider inserting into the heap. Given a key $k$ to insert into the heap:\n - Increment the heap size.\n - Insert a new node in the last position in the heap, with key $-\\infty$.\n - Increase the $-\\infty$ key to $k$ using the HEAP-INCREASE-KEY procedure defined above."}
︠cf66f69b-9f24-484d-b599-40a430be3d3f︠
####### Do not run :)######
#pseudocode                                     

MAX-HEAP-INSERT(A,key ,n)
    n = n + 1
    A[n] = -infinity
    HEAP-INCREASE-KEY(A,n,key)
    
####### Do not run :)######
︡dabc62fd-8048-4d8f-9922-c7e8757fa5a4︡
︠51b4b260-871b-4120-980f-c0f5abe42c31i︠
%md

**At the boards:**

8. What is the time complexity of MAX-HEAP-INSERT? Explain briefly.

9. Illustrate the operation of MAX-HEAP-INSERT(A, 10, 12) on the heap A = ⟨15, 13, 9, 5, 12, 8, 7, 4, 0, 6, 2, 1⟩.
︡c0a46f50-ea9d-4395-a35e-0abacfee202b︡{"done":true,"md":"\n**At the boards:**\n\n8. What is the time complexity of MAX-HEAP-INSERT? Explain briefly.\n\n9. Illustrate the operation of MAX-HEAP-INSERT(A, 10, 12) on the heap A = ⟨15, 13, 9, 5, 12, 8, 7, 4, 0, 6, 2, 1⟩."}
︠e95d2285-ab68-498f-a480-f6a37df69dd9︠
%md

When you are done, in CoCalc Workshop WS10: 6.5-Max_Priority_Queue, write a program max_priority_queue.cpp or max_priority_queue.py that ultimately implements and demonstrates the above max-priority queue operations. HINT: You may start with the file heapsort.cpp or heapsort.py from the Midterm if you’d like.

See ws10_priority_queue.pdf in CoCalc for specifications.
︡3d646bdf-5d1d-42fc-9991-36bae04b2920︡{"done":true,"md":"\nWhen you are done, in CoCalc Workshop WS10: 6.5-Max_Priority_Queue, write a program max_priority_queue.cpp or max_priority_queue.py that ultimately implements and demonstrates the above max-priority queue operations. HINT: You may start with the file heapsort.cpp or heapsort.py from the Midterm if you’d like.\n\nSee ws10_priority_queue.pdf in CoCalc for specifications."}









