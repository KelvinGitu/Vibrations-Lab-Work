clear;
clc;
a = input("Coefficient a: "); 
b = input("Coefficient b: ");
c = input("Coefficient c: ");
y_initial = input("First initial condition: ");
y_initial_prime = input("Second initial condition: ");

if (b^2 - 4*a*c > 0)
    fprintf("Roots are real and distinct\n");
    r1 = (-b + sqrt(b^2 - 4*a*c))/(2*a);
    r2 = (-b - sqrt(b^2 - 4*a*c))/(2*a);
    fprintf("Roots: %.4f, %.4f\n", r1, r2);
    fprintf("Equation is c1e^%.4f t + c2e^%.4f t\n",r1, r2);
    A = [1, 1; r1, r2];
    B = [y_initial; y_initial_prime];
    C = A\ B;
    fprintf("Solution: y = %.4fe^%.4f t + %.4fe^%.4f t\n", C(1), r1, C(2), r2);
end

if (b^2 - 4*a*c == 0)
    fprintf("Roots are real and repeated\n");
    r1 = (-b + sqrt(b^2 - 4*a*c))/(2*a);
    fprintf("Roots: %.4f, %.4f\n", r1, r1);
    fprintf("Equation is: y = %.4fe^%.4f t + %.4fte^%.4f t\n", y_initial, r1, (y_initial_prime - r1*y_initial), r1);
end

if (b^2 - 4*a*c < 0)
    fprintf("Roots are complex\n");
    r1 = (-b + sqrt((b^2) - (4*a*c))/(2*a));
    r2 = (-b - sqrt((b^2) - (4*a*c))/(2*a));
    disp(["Roots: ",r1, r2]);
    A = [0, 1 ; real(r1), imag(r1)];
    B = [y_initial; y_initial_prime];
    C = A\ B;
    fprintf("Solution: y = e^%.4f t (%.4f cos(%.4ft) + %.4f sin(%.4ft))\n", real(r1), C(1), imag(r1), C(2), -1 * imag(r2));
end      

syms y(t)
Dy = diff(y, t);
ode_equation = a * diff(y, t, 2) + b * diff(y, t) + c * y == 0;
cond = [y(0) == y_initial, Dy(0) == y_initial_prime];
dsolve(ode_equation, cond);
fprintf('DSolve Solution\n');
