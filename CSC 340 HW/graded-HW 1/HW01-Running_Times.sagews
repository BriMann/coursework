︠f862e4d3-d651-4ba6-8778-99e91a06e608︠
%md

Your name: Brian Mann *Run this cell to update the worksheet

# Problem 1-1: Comparison of Running Times on pages 14-15

For each function $f(n)$ and time $t$ in the given table, determine the largest size $n$ of a problem that can be solved in time $t$,
assuming that the algorithm to solve the problem takes $f(n)$ microseconds.

### Solution:
︡84f739bb-1651-438f-8a08-9f1c2978ba4d︡{"done":true,"md":"\nYour name:___\n\n# Problem 1-1: Comparison of Running Times on pages 14-15\n\nFor each function $f(n)$ and time $t$ in the given table, determine the largest size $n$ of a problem that can be solved in time $t$, \nassuming that the algorithm to solve the problem takes $f(n)$ microseconds.\n\n### Solution:"}
︠de7f0680-8a91-4d16-85fe-e0c740249a6d︠

︡75147842-d88b-4369-8da4-4a2df1959b2f︡
︠8136bb33-a9ce-4529-b653-9158abf222dcs︠
#Use this sage cell to solve the Problem.  Include comments as necessary explaining your steps
import math
import scipy.optimize

#times: 1 second = 10^6 microseconds---convert times to microsecinds
sec = 10**6
minut = 60*sec
hr = 60*minut
day = 24*hr
month = 30*day
yr = 12*month
cen = 100*yr
#etc

t = ["f(n)\time", sec, minut, hr, day, month, yr]
print(t)

# for f(n) = lg(n) solve lg(n) = t or log base 2 (n) = t --2^(log base 2(n)) = n so n = 2^t
f1 = ["lg n", '{:.2E}'.format(2**sec.n()), '{:.2E}'.format(2**minut.n()), '{:.2E}'.format(2**hr.n()), '{:.2E}'.format(2**day.n()), '{:.2E}'.format(2**month.n()),                               '{:.2E}'.format(2**yr.n()), '{:.2E}'.format(2**cen.n())]
print(f1)

# for square root of n
f2 = ["sqre n",'{:.2E}'.format(sec.n()**2), '{:.2E}'.format(minut.n()**2), '{:.2E}'.format(hr.n()**2), '{:.2E}'.format(day.n()**2), '{:.2E}'.format(month.n()**2),                              '{:.2E}'.format(yr.n()**2),'{:.2E}'.format(cen.n()**2)]
print(f2)

# for f(n) = n solve n = t
f3 = ["n", sec, minut, hr, day, month, yr, cen]
print(f3)

#def f4(x):
 #   return x.n()*math.log2(x.n())-x

#print(f4(sec))

def f4_1(x):
    return x*math.log2(x)-sec

def f4_2(x):
    return x*math.log2(x)-minut

def f4_3(x):
    return x*math.log2(x)-hr

def f4_4(x):
    return x*math.log2(x)-day

def f4_5(x):
    return x*math.log2(x)-month

def f4_6(x):
    return x*math.log2(x)-yr

def f4_7(x):
    return x*math.log2(x)-cen



# for nlogn
f4 = ["n log n", (scipy.optimize.fsolve(f4_1, x0=5000)), (scipy.optimize.fsolve(f4_2, x0=5000)),                                                                                                               (scipy.optimize.fsolve(f4_3, x0=5000)),(scipy.optimize.fsolve(f4_4, x0=5000)),                                                                                                               (scipy.optimize.fsolve(f4_5, x0=5000)), (scipy.optimize.fsolve(f4_6, x0=5000)),                                                                                                             (scipy.optimize.fsolve(f4_7, x0=5000))]

print(f4)

# for f(n) = n^2 solve n^2 = t
f5 = ["n^2", sqrt(sec).n(), sqrt(minut).n(), sqrt(hr).n(), sqrt(day).n(), sqrt(month).n(), sqrt(yr).n(), sqrt(cen).n()]
print(f5)

# for n^3
f6 = ["n^3", '{:.2E}'.format(sec.n()**(1.0/3.0)), '{:.2E}'.format(minut.n()**(1.0/3.0)), '{:.2E}'.format(hr.n()**(1.0/3.0)), '{:.2E}'.format(day.n()**(1.0/3.0)),                                      '{:.2E}'.format(month.n()**(1.0/3.0)), '{:.2E}'.format(yr.n()**(1.0/3.0)), '{:.2E}'.format(cen.n()**(1.0/3.0))]
print(f6)

# for 2^n
f7 = ["2^n", '{:.2E}'.format(math.log2(sec.n())), '{:.2E}'.format(math.log2(minut.n())), '{:.2E}'.format(math.log2(hr.n())), '{:.2E}'.format(math.log2(day.n())),                              '{:.2E}'.format(math.log2(month.n())), '{:.2E}'.format(math.log2(yr.n())), '{:.2E}'.format(math.log2(cen.n()))]
print(f7)


def factorial(x):
    n = 1
    fact = 1
    while fact < x:
        n += 1
        fact = fact * n
    return(n-1)

print(factorial(sec))
#for n!
f8 = ["n!", factorial(sec), factorial(minut), factorial(hr), factorial(day), factorial(month), factorial(yr), factorial(cen)]
print(f8)




 #scipy.optimize.fsolve takes a function with at least one positional argument, which is the variable you need to estimate to find the roots of the function.
#x0=50000 is the starting estimate.
#result_1sec
#result_1sec[0]

#format output

print("\n Dr. Danielson started a table for you :) for inspiration\n") #EDIT ME

rows = [[' ', '1 sec' , '1 minut', '1 hr', '1 day', '1 month', '1 yr', '1 cen'], [' ', '-----', '-----', '-----', '-----', '-----', '-----', '-----'], f1, f2, f3, f4, f5, f6, f7, f8]
table(rows)




︡80d8db70-100e-429c-8dd2-5d437b30554c︡{"stdout":"['f(n)\\time', 1000000, 60000000, 3600000000, 86400000000, 2592000000000, 31104000000000]\n"}︡{"stdout":"['lg n', '9.90E+301029', '5.49E+18061799', '2.46E+1083707984', '2.33E+26008991625', '1.09E+780269748761', '2.96E+9363236985132', '1.29E+936323698513247']\n"}︡{"stdout":"['sqre n', '1.00E+12', '3.60E+15', '1.30E+19', '7.46E+21', '6.72E+24', '9.67E+26', '9.67E+30']\n"}︡{"stdout":"['n', 1000000, 60000000, 3600000000, 86400000000, 2592000000000, 31104000000000, 3110400000000000]\n"}︡{"stderr":"/ext/sage/9.4/local/lib/python3.9/site-packages/scipy/optimize/minpack.py:175: RuntimeWarning: The iteration is not making good progress, as measured by the \n  improvement from the last ten iterations.\n  warnings.warn(msg, RuntimeWarning)\n"}︡{"stdout":"['n log n', array([62746.12646969]), array([2801417.88324151]), array([1.33378059e+08]), array([2.75514751e+09]), array([7.18708564e+10]), array([1.27755e+08]), array([1.27755e+08])]\n"}︡{"stdout":"['n^2', 1000.00000000000, 7745.96669241483, 60000.0000000000, 293938.769133981, 1.60996894379985e6, 5.57709601853868e6, 5.57709601853868e7]\n"}︡{"stdout":"['n^3', '1.00E+2', '3.91E+2', '1.53E+3', '4.42E+3', '1.37E+4', '3.14E+4', '1.46E+5']\n"}︡{"stdout":"['2^n', '1.99E+01', '2.58E+01', '3.17E+01', '3.63E+01', '4.12E+01', '4.48E+01', '5.15E+01']\n"}︡{"stdout":"9\n"}︡{"stdout":"['n!', 9, 11, 12, 13, 15, 16, 17]\n"}︡{"stdout":"\n Dr. Danielson started a table for you :) for inspiration\n\n"}︡{"stdout":"            1 sec              1 minut              1 hr               1 day               1 month              1 yr                  1 cen\n            -----              -----                -----              -----               -----                -----                 -----\n  lg n      9.90E+301029       5.49E+18061799       2.46E+1083707984   2.33E+26008991625   1.09E+780269748761   2.96E+9363236985132   1.29E+936323698513247\n  sqre n    1.00E+12           3.60E+15             1.30E+19           7.46E+21            6.72E+24             9.67E+26              9.67E+30\n  n         1000000            60000000             3600000000         86400000000         2592000000000        31104000000000        3110400000000000\n  n log n   [62746.12646969]   [2801417.88324151]   [1.33378059e+08]   [2.75514751e+09]    [7.18708564e+10]     [1.27755e+08]         [1.27755e+08]\n  n^2       1000.00000000000   7745.96669241483     60000.0000000000   293938.769133981    1.60996894379985e6   5.57709601853868e6    5.57709601853868e7\n  n^3       1.00E+2            3.91E+2              1.53E+3            4.42E+3             1.37E+4              3.14E+4               1.46E+5\n  2^n       1.99E+01           2.58E+01             3.17E+01           3.63E+01            4.12E+01             4.48E+01              5.15E+01\n  n!        9                  11                   12                 13                  15                   16                    17\n"}︡{"done":true}









