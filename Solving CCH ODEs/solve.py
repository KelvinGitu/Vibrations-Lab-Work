import math
import cmath
import numpy as np

#prompt user for input
a = float(input("Coefficient a: "))
b = float(input("Coefficient b: "))
c = float(input("Coefficient c: "))
y_initial = float(input("First initial condition: "))
y_initial_prime = float(input("Second initial condition: "))

#solve for the roots and check their nature.
#solve the equation
def solve(a, b, c, y_initial, y_initial_prime):
    if b**2 - 4*a*c > 0:
        print("Roots are real and distinct")
        r1 = (-b + math.sqrt(b**2 - 4*a*c))/(2*a)
        r2 = (-b - math.sqrt(b**2 - 4*a*c))/(2*a)
        print("Roots: ", r1, r2)
        print("Equation is c1e^{}t + c2e^{}t".format(r1, r2))
        A = np.array([[1, 1], [r1, r2]])
        B = np.array([y_initial, y_initial_prime])
        C = np.linalg.solve(A, B)
        print("Solution: y = {}e^{}t + {}e^{}t".format(C[0], r1, C[1], r2))
    
    elif b**2 - 4*a*c == 0:
        print("Roots are real and repeated")
        r1 = (-b + math.sqrt(b**2 - 4*a*c))/(2*a)
        print("Roots: ", r1, r1)    
        print("Equation is: y = {}e^{}t + {}te^{}t".format(round(y_initial, 4), r1, round((y_initial_prime - r1*y_initial), 4), r1))
    
    elif b**2 - 4*a*c < 0:
        print("Roots are complex")
        r1 = (-b + cmath.sqrt((b*b) - (4*a*c))/(2*a))
        r2 = (-b - cmath.sqrt((b*b) - (4*a*c))/(2*a))
        print("Roots: ", r1, r2)
        A = np.array([[0, 1], [r1.real, r1.imag]])
        B = np.array([y_initial, y_initial_prime])
        C = np.linalg.solve(A, B)
        print("Solution: y = e^{}t ({} cos({}t) + {} sin({}t))".format(r1.real, round(C[0], 4), r1.imag, round(C[1], 4), -1 * r2.imag))        

print(solve(a, b, c, y_initial, y_initial_prime))