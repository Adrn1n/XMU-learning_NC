%{
习题3
%}
%% 3.1
disp("3.1");

x=[7 4 3];y=[-1 -2 -3];
% (1)
disp("(1)");

u=[y,x];

disp(u);

% (2)
disp("(2)");

v=[x,y];

disp(v);

%% 3.2
disp("3.2");

a=[4 -1 2 -8 4 5 -3 -1 6 -7];

a(a<0)=a(a<0)*2;

disp(a);

%% 3.3
disp("3.3");

a=[4 -1 2 -8 4 5 -3 -1 6 -7];

S_p=sum(a(a>0));

disp(S_p);

%% 3.4
disp("3.4");

% x=[1:99];
x=1:99;

x(isprime(x))=[];
S=sum(x);

disp(S);

%% 3.5
disp("3.5");

function y=fun_ex(x)
y=0.8*exp(-x)+x.^3.*sin(x);
end

%{
测试用, 输入 x 的值, 输出 y 的值
%}
x=input("x = ");

disp(fun_ex(x));
%% 3.6
disp("3.6");

function f=fun_es(x,n)
f=0;
for i=0:n
    f=+(x^i)/factorial(i);
end
end

%{
测试用, 输入 x, n 的值, 输出 y 的值
%}
x=input("x = ");
n=input("n = ");

disp(fun_es(x,n));

%% 3.7
disp("3.7");

function y=func(x)
y=1./(1+(x-2).^2);
end

x_min=0;x_max=4;

%{
输入细分步长
%}
step=input("step(0 < step < "+num2str(x_max-x_min)+") = ");
x_vals=x_min:step:x_max;

y_vals=func(x_vals);

plot(x_vals,y_vals);
xlabel=("x");ylabel=("y");title=("y(x)");grid on;

%% 3.8
disp("3.8");

A=[1,2,3;
    0,1,4;
    3,0,2];

B=[4,1,2;
    3,2,1;
    0,1,2];

C=A+B;

disp(C);

D=A-B;

disp(D);

E=A*B;

disp(E);

F=B*A;

disp(F);

%% 3.9
disp("3.9");

B=[4,1,2;
    3,2,1;
    0,1,2];

disp(det(B));
disp(B*inv(B));

%% 3.10
disp("3.10");

syms x
c=5;
% y=5*(x-3)*(x-4)*(x+1)*(x+3);
y=c*(x-3)*(x-4)*(x+1)*(x+3);

roots=solve(y==0,x);
coeff=c*(poly(double(roots)));

poly_x=poly2sym(coeff,x);

disp(poly_x);
