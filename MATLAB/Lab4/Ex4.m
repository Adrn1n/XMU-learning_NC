%{
实验标题: 解线性方程组的迭代法
一 实验目的
	通过编程, 深入理解和掌握解线性方程组的迭代法的数值计算方法.

二 实验内容
1. 温习教材第六章内容;
2. 练习并理解第6.5节的算法实现示例, 以及相关的MATLAB函数;
3. 按照要求, 编程实现自定义的Jacobi迭代法、Gauss-Seidel迭代法的算法函数及其测试示例;
4. 按照要求, 撰写并提交实验报告.

三 实验要求
下表列出了本次实验应编程实现的算法、算法函数文件, 以及含测试示例的文件.

(表略)

代码的基本要求:
1. 算法函数存为函数文件. 其他代码存在一个脚本文件中, 文件名格式为: Ex4_####.m  (####表示学号后四位数字, 如 "3226").
2. 文件首行用注释说明 "学号" 和 "姓名".
3. 代码应当做到条理清楚、层次分明, 有充分的注释, 使得代码的可读性好. 例如: 在自定义函数的下一行, 应当注释说明该函数的功能、参数的含义等; 对于关键代码和变量给出必要注释.
4. 能正确实现相应的算法和其他实验要求.

Jacobi迭代法的实验任务:
运行并理解教材第6.5节的函数文件 agui_jacobi.m. 以 agui_jacobi.m 为基础, 将其修改为 myJacobi.m, 并完成以下任务:
1. 函数myJacobi的输入输出参数要求如下:
function [B_J x]= myJacobi(a, b, x0, e, N)
% a为系数阵、b为右端向量、x0为初始向量 (默认0向量)
% e为精度, N为最大迭代次数
% B_J为返回的Jacobi迭代矩阵, x为返回的解向量
2. 函数myJacobi在迭代超过N次时, 应给出警告信息.
3. 用习题6.9(2)作为测试示例, 并分别用N=15和N=20做测试, 观察程序运行结果, 并用6.5.2节的两种MATLAB函数实现方法 (函数bicg、函数lsqr) 进行验证.
4. 选用另外一个至少4阶的线性方程组作为测试示例进行测试, 并用6.5.2节的两种MATLAB函数实现方法 (函数bicg、函数lsqr) 进行验证.
5. 在实验报告中, 详细阐述Jacobi迭代法的原理、代码如何实现该原理、代码如何完成实验要求, 讨论分析占用的存储空间, 以及实验的现象与结果.

Gauss-Seidel迭代法的实验任务:
运行并理解教材第6.5节的函数文件 agui_jacobi.m. 以 agui_jacobi.m 为基础, 将其修改为 myGS.m, 并完成以下任务:
6. 函数myGS的输入输出参数要求如下:
function [B_GS x]= myGS(a, b, x0, e, N)
% a为系数阵、b为右端向量、x0为初始向量 (默认0向量)
% e为精度, N为最大迭代次数
% B_GS为返回的Gauss-Seidel迭代矩阵, x为返回的解向量
7. 函数myGS在迭代超过N次时, 应给出警告信息.
8. 用习题6.9(2)作为测试示例, 并分别用N=6和N=9做测试, 观察程序运行结果, 并用6.5.2节的两种MATLAB函数实现方法 (函数bicg、函数lsqr) 进行验证.
9. 选用另外一个至少4阶的线性方程组作为测试示例进行测试, 并用6.5.2节的两种MATLAB函数实现方法 (函数bicg、函数lsqr) 进行验证.
10. 在实验报告中, 详细阐述Gauss-Seidel迭代法的原理、代码如何实现该原理、代码如何完成实验要求, 讨论分析占用的存储空间, 以及实验的现象与结果.
%}

%% 全局变量
A_ex0=[5,2,1;-1,4,2;2,-3,10];b_ex0=[-12;20;3];x0_ex0=[0;0;0];e_ex0=10^-4;
N_J0=15;N_J1=20;N_GS0=6;N_GS1=9;

%% Jacobi 迭代法
disp("myJacobi");

disp(repmat('-',1,50));

disp("6.9(2): ");

disp("N = "+num2str(N_J0))
[B_J0,x_J0]=myJacobi(A_ex0,b_ex0,x0_ex0,e_ex0,N_J0);

disp("B = ");
disp(B_J0);
disp("x = ");
disp(x_J0);

disp(repmat('-',1,50));

disp("N = "+num2str(N_J1))
[B_J1,x_J1]=myJacobi(A_ex0,b_ex0,x0_ex0,e_ex0,N_J1);

disp("B = ");
disp(B_J1);
disp("x = ");
disp(x_J1);

disp(repmat('-',1,50));

disp("bicg: ");
x_ex0_bicg=bicg(A_ex0,b_ex0);
disp("x = ");
disp(x_ex0_bicg);

disp("lsqr: ");
x_ex0_lsqr=lsqr(A_ex0,b_ex0);
disp("x = ");
disp(x_ex0_lsqr);

disp(repmat('-',1,50));

disp("Other test: ");
A_J2_str=input("A (order >= 4) = ","s");b_J2_str=input("b (dim = A's order) = ","s");x0_J2_str=input("x0 (dim = A's order) = ","s");
A_J2=eval(A_J2_str);b_J2=eval(b_J2_str);x0_J2=eval(x0_J2_str);e_J2=input("e = ");N_J2=input("N = ");

[B_J2,x_J2]=myJacobi(A_J2,b_J2,x0_J2,e_J2,N_J2);
disp("B = ");
disp(B_J2);
disp("x = ");
disp(x_J2);

disp("bicg: ");
x_J2_bicg=bicg(A_J2,b_J2);
disp("x = ");
disp(x_J2_bicg);

disp("lsqr: ");
x_J2_lsqr=lsqr(A_J2,b_J2);
disp("x = ");
disp(x_J2_lsqr);

disp(repmat('*',1,50));

%% Gauss-Seidel 迭代法
disp("myGS");

disp(repmat('-',1,50));

disp("6.9(2): ");

disp("N = "+num2str(N_GS0))
[B_GS0,x_GS0]=myGS(A_ex0,b_ex0,x0_ex0,e_ex0,N_GS0);

disp("B = ");
disp(B_GS0);
disp("x = ");
disp(x_GS0);

disp(repmat('-',1,50));

disp("N = "+num2str(N_GS1))
[B_GS1,x_GS1]=myGS(A_ex0,b_ex0,x0_ex0,e_ex0,N_GS1);

disp("B = ");
disp(B_GS1);
disp("x = ");
disp(x_GS1);

disp(repmat('-',1,50));

disp("bicg: ");
x_ex0_bicg=bicg(A_ex0,b_ex0);
disp("x = ");
disp(x_ex0_bicg);

disp("lsqr: ");
x_ex0_lsqr=lsqr(A_ex0,b_ex0);
disp("x = ");
disp(x_ex0_lsqr);

disp(repmat('-',1,50));

disp("Other test: ");
A_GS2_str=input("A (order >= 4) = ","s");b_GS2_str=input("b (dim = A's order) = ","s");x0_GS2_str=input("x0 (dim = A's order) = ","s");
A_GS2=eval(A_GS2_str);b_GS2=eval(b_GS2_str);x0_GS2=eval(x0_GS2_str);e_GS2=input("e = ");N_GS2=input("N = ");

[B_GS2,x_GS2]=myGS(A_GS2,b_GS2,x0_GS2,e_GS2,N_GS2);
disp("B = ");
disp(B_GS2);
disp("x = ");
disp(x_GS2);

disp("bicg: ");
x_GS2_bicg=bicg(A_GS2,b_GS2);
disp("x = ");
disp(x_GS2_bicg);

disp("lsqr: ");
x_GS2_lsqr=lsqr(A_GS2,b_GS2);
disp("x = ");
disp(x_GS2_lsqr);

disp(repmat('*',1,50));
