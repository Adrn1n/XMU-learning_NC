%{
非线性方程求根的数值计算实验

一 实验目的
	通过编程，深入理解和掌握求解单变量非线性方程的数值计算方法。

二 实验内容
1.温习教材第四章内容；
2.练习并理解第4.6节的算法实现示例，以及相关的MATLAB函数；
3.按照要求，编程实现自定义的二分法、不动点迭代法、牛顿法、弦截法的算法函数及其测试示例；
4.按照要求，撰写并提交实验报告。

三 实验要求
下表列出了本次实验应编程实现的算法、算法函数文件，以及含测试示例的文件。

(表略)

算法实现函数的要求：
1.每个算法采用一个函数文件实现，函数文件名如上表所示。
2.有充分的注释，使得代码的可读性好。例如：在自定义函数的下一行，应当注释说明该函数的功能、参数的含义等；对于关键代码和变量给出必要注释。
3.能正确实现相应的算法。
4.能根据最大迭代次数和精度要求等参数，结束算法的执行。
5.能返回算法主要迭代循环体中乘除法计算次数（不包括函数值的计算）。
6.能返回算法主要迭代循环体的执行时间。
7.能列表返回每次迭代的近似值。

算法实现函数的测试代码要求：
1.每个算法实现函数都采用相同的测试示例：
        求方程 x^3 - x - 1 = 0 在 x = 1.5 附近的根。
2.用MATLAB的自带函数 table(),列表输出每个算法的每次迭代的迭代次数和近似值。
3.输出算法主要过程的运行时间和乘除法次数。
4.用MATLAB的自带函数 table(),列表输出所有算法的运行时间和乘除法次数，以便相互比较，并在实验报告中进行讨论。

代码的其他要求：
1.算法函数存为函数文件。其他代码存在一个脚本文件中，文件名格式为：Ex2_####.m  (####表示学号后四位数字，如“3226”)。
2.文件首行用注释说明“学号”和“姓名”。
3.代码应当做到条理清楚、层次分明、可读性好。
%}

%% 全局变量
syms x

f_sym=x^3-x-1;x0=1.5;
eps=input("eps = ");maxIter=input("maxIter = ");

df_dx_sym=diff(f_sym,x);
g0_sym=f_sym+x;g1_sym=(x+1)^(1/3); % g0_sym: 更加通用的迭代函数, 任何函数都行, 但是会有收敛性 (此实验中发散) 和精度方面的问题; g1_sym: 针对这个方程进行优化的迭代方程

f=matlabFunction(f_sym);df_dx=matlabFunction(df_dx_sym);g0=matlabFunction(g0_sym);g1=matlabFunction(g1_sym);

%{
二分法初始区间端点, 要求 f(a) * f(b) <= 0
%}
a=1;b=2;

fprintf("\n")

%% 二分法
disp("bisect")

[x_bisect,aproxs_bisect,opCnt_bisect,execT_bisect]=bisect(f,a,b,eps,maxIter);
T_bisect=table((1:length(aproxs_bisect))',aproxs_bisect,'VariableNames',{'n','x'});

disp(T_bisect)
fprintf("x: %.6f\n",x_bisect)
fprintf("t: %.6f s\n",execT_bisect)
fprintf("opCnt: %d\n\n",opCnt_bisect)

%% 不动点迭代法
disp("fixedPoint")

%{
g0
%}
disp("g0:")
[x_fixed0,aproxs_fixed0,opCnt_fixed0,execT_fixed0]=fixedPoint(g0,x0,eps,maxIter);
T_fixed0=table((1:length(aproxs_fixed0))',aproxs_fixed0,'VariableNames',{'n','x'});

disp(T_fixed0)
fprintf("x: %.6f\n",x_fixed0)
fprintf("t: %.6f s\n",execT_fixed0)
fprintf("opCnt: %d\n\n",opCnt_fixed0)

%{
g1
%}
disp("g1:")
[x_fixed1,aproxs_fixed1,opCnt_fixed1,execT_fixed1]=fixedPoint(g1,x0,eps,maxIter);
T_fixed1=table((1:length(aproxs_fixed1))',aproxs_fixed1,'VariableNames',{'n','x'});

disp(T_fixed1)
fprintf("x: %.6f\n",x_fixed1)
fprintf("t: %.6f s\n",execT_fixed1)
fprintf("opCnt: %d\n\n",opCnt_fixed1)

%% 牛顿法
disp("Newton")

[x_newton,aproxs_newton,opCnt_newton,execT_newton]=Newton(f,df_dx,x0,eps,maxIter);
T_newton=table((1:length(aproxs_newton))',aproxs_newton,'VariableNames',{'n','x'});

disp(T_newton)
fprintf("x: %.6f\n",x_newton)
fprintf("t: %.6f s\n",execT_newton)
fprintf("opCnt: %d\n\n",opCnt_newton)

%% 弦截法
disp("Secant")

k=input("k (k > 1) = ");

[x_secant,aproxs_secant,opCnt_secant,execT_secant]=Secant(f,x0,k,eps,maxIter);
T_secant = table((1:length(aproxs_secant))',aproxs_secant,'VariableNames',{'n','x'});

disp(T_secant)
fprintf("x: %.6f\n",x_secant)
fprintf("t: %.6f s\n",execT_secant);
fprintf("opCnt: %d\n\n",opCnt_secant);

%% 性能比较
disp("Perform compare")

T_compare=table({'bisect';'fixedPoint (g0)';'fixedPoint (g1)';'Newton';'Secant'},[execT_bisect;execT_fixed0;execT_fixed1;execT_newton;execT_secant],[opCnt_bisect;opCnt_fixed0;opCnt_fixed1;opCnt_newton;opCnt_secant],'VariableNames',{'Algos','t','opCnt'});

disp(T_compare);
