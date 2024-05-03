import math

def find_max_crossing_subarray(A, low, mid, high):
    left_sum = -math.inf
    sum_ = 0
    max_left = 0
    for i in reversed(range(mid + 1 )):
        sum_ = sum_ + A[i]
        if sum_ > left_sum:
            left_sum = sum_
            max_left = i
    right_sum = -math.inf
    sum_ = 0
    max_right = 0
    for j in range(mid + 1, high + 1):
        sum_ = sum_ + A[j]
        if sum_ > right_sum:
            right_sum = sum_
            max_right = j
    return (max_left, max_right, (left_sum + right_sum))


def find_max_subarray(A, low, high):
    if high == low:
        return (low, high, A[low])
    else:
        mid = (low + high)//2
        (left_low, left_high, left_sum) = find_max_subarray(A, low, mid)
        (right_low, right_high, right_sum) = find_max_subarray(A, mid+1, high)
        (cross_low, cross_high, cross_sum) = find_max_crossing_subarray(A, low, mid, high)
        if left_sum >= right_sum and left_sum >= cross_sum:
            return (left_low, left_high, left_sum)
        elif right_sum >= left_sum and right_sum >= cross_sum:
            return (right_low, right_high, right_sum)
        else:
            return (cross_low, cross_high, cross_sum)
        
def print_subarray(v, low, high):
    sub_sub = []
    for i in range(low, high+1):
        sub_sub.append(v[i])
    print("from [ {}, {}] = {}".format(low, high, sub_sub))
    
    

def main():
    A = [13, -3, -25, 20, -3, -16, -23, 18, 20, -7, 12, -5, -22, 15, -12, 7]
    (low, high, true_sum) = find_max_subarray(A, 0, len(A)-1)
    print("The vector to be considered: ", A)
    print( "The subbarray A")
    str_ = print_subarray(A, low, high)
    print("With the sum ", true_sum, "has the greatest sum of any contiguous subarray A")
    B = [1, -4, 3, -4]
    (low, high, true_sum) = find_max_subarray(B, 0, len(B)-1)
    print("The vector to be considered: ", B)
    print( "The subbarray B")
    print_subarray(B, low, high)
    print("With the sum ", true_sum, "has the greatest sum of any contiguous subarray B")
    
    #LAD: test code
    C = [-11, -4, -3, -4, -1]
    print("Another vector to be considered: C=", C)
    
    (low_index, high_index, greatest_sum) = find_max_subarray(C, 0, len(C)-1)
    print("The subarray C[", low_index, "..", high_index, "] = ")
    # error! note specifications print_sub_array(C, low_index, high_index)
    print_subarray(C, low_index, high_index)
    print("with the sum", greatest_sum, "has the greatest sum of any contiguous subarray of C.")
    
    D = [-11, 10, -4, 12, -7, 20, -3, -4, -1]
    print("Another vector to be considered: D=", D)
    
    (low_index, high_index, greatest_sum) = find_max_subarray(D, 0, len(D)-1)
    print("The subarray D[", low_index, "..", high_index, "] = ")
    # print_sub_array(D, low_index, high_index)
    print_subarray(D, low_index, high_index)
    print("with the sum", greatest_sum, "has the greatest sum of any contiguous subarray of D.")
    
    
main()