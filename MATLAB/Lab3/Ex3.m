%{
解线性方程组的直接法

一 实验目的
	通过编程, 深入理解和掌握解线性方程组的直接法的数值计算方法.

二 实验内容
1. 温习教材第五章内容;
2. 练习并理解第5.6节的算法实现示例, 以及相关的MATLAB函数;
3. 按照要求, 编程实现自定义的列主元高斯消去法、直接三角分解法的算法函数及其测试示例;
4. 按照要求, 撰写并提交实验报告.

三 实验要求 
下表列出了本次实验应编程实现的算法、算法函数文件, 以及含测试示例的文件.

(表略)

代码的基本要求:
1. 算法函数存为函数文件. 其他代码存在一个脚本文件中, 文件名格式为: Ex3_####.m  (####表示学号后四位数字, 如 "3226").
2. 文件首行用注释说明 "学号" 和 "姓名".
3. 代码应当做到条理清楚、层次分明, 有充分的注释, 使得代码的可读性好. 例如: 在自定义函数的下一行, 应当注释说明该函数的功能、参数的含义等; 对于关键代码和变量给出必要注释.
4. 能正确实现相应的算法和其他实验要求.

列主元高斯消去法的实验任务:
运行并理解教材第 5.6 节的函数文件 agui_gauss.m. 以 agui_gauss.m 为基础, 将其修改为 myGauss.m, 并完成以下任务:
1. 每次选主元消元开始时, 输出提示 "开始第*次选主元消元".
2. 在每次选主元消元过程中, 分别输出 "选主元前"、"选主元后, 消元前"、"消元后" 的增广矩阵, 并在输出前给出相应的提示.
3. 分别输出每次消元的乘除法次数、消元过程总的的乘除法次数, 以及回代过程的乘除法次数, 并在输出前给出相应的提示.
4. 在算法函数结束前, 输出提示 "求解完成, 总的乘除法次数和总的运行时间为:", 并随后输出总的乘除法次数和总的运行时间.
5. 用例 5.2.5 作为测试示例, 测试 myGauss.m, 并思考能否去掉 myGauss.m 中的语句 "a((k+1):n,k)=zeros(n-k,1);", 观察去掉与不去掉该语句的结果是否有差异.
6. 选用另外一个至少 4 阶的线性方程组作为测试示例进行测试, 并用 5.6.2 节的三种 MATLAB 函数实现方法 (直接矩阵除法、函数 lu、函数 rref) 进行验证.
7. 在实验报告中, 详细阐述列主元高斯消去法的原理、代码如何实现该原理、代码如何完成实验要求, 讨论分析占用的存储空间, 以及实验的现象与结果.

直接三角分解法的实验任务:
运行并理解教材第 5.6 节的函数文件 agui_lu.m. 以 agui_lu.m 为基础, 将其修改为 myLU.m, 并完成以下任务:
1. 输出初始化的 L 和 U.
2. 每次计算完 U 的一行和 L 的一列前, 输出提示 "开始计算 U 的第*行、L 的第*列".
3. 每次计算完 U 的一行和 L 的一列后, 输出提示 "计算完 U 的第*行、L 的第*列, 此轮计算的乘除法次数为:", 并随后输出此轮计算的乘除法次数; 然后提示 "此轮计算更新后的矩阵 L 和 U:", 并随后输出此轮计算更新后的矩阵.
4. LU 分解完后, 输出提示 "LU 分解完成, 总的乘除法次数和分解结果为: ”, 并随后输出 LU 分解总的乘除法次数, 以及分解后的 L 和 U.
5. 求解 y 完后, 输出提示 "求解 y 完成, 求解 y 的乘除法次数和结果为:", 并随后输出求解 y 的乘除法次数, 以及求解后的y.
6. 求解 x 完后, 输出提示 "求解 x 完成, 求解 x 的乘除法次数和结果为:", 并随后输出求解 x 的乘除法次数, 以及求解后的x.
7. 在算法函数结束前, 输出提示 "求解完成, 总的乘除法次数和总的运行时间为:", 并随后输出总的乘除法次数和总的运行时间.
8. 用例 5.3.1 作为测试示例, 测试 myLU.m.
9. 选用另外一个至少 4 阶的线性方程组作为测试示例进行测试, 并用 5.6.2 节的三种 MATLAB 函数实现方法 (直接矩阵除法、函数 lu、函数 rref) 进行验证.
10. 在实验报告中, 详细阐述直接三角法的原理、代码如何实现该原理、代码如何完成实验要求, 讨论分析占用的存储空间, 以及实验的现象与结果.
%}

%% 列主元高斯消去法
disp("myGauss");
disp(repmat('*',1,50));

disp("ex 5.2.5: ")
A_gauss1=[12,-3,3;-18,3,-1;1,1,1];b_gauss1=[15;-15;6];

[x_gauss1,opCnt_gauss1,execT_gauss1]=myGauss(A_gauss1,b_gauss1);

disp("x: ");
disp(x_gauss1);
disp("operation count, time: "+num2str(opCnt_gauss1)+", "+num2str(execT_gauss1));
disp(repmat('*',1,50));

disp("Other test: ");
A_gauss2_str=input("A (order >= 4) = ","s");
b_gauss2_str=input("b (dim = A's order) = ","s");
A_gauss2=eval(A_gauss2_str);b_gauss2=eval(b_gauss2_str);

[x_gauss2,opCnt_gauss2,execT_gauss2]=myGauss(A_gauss2,b_gauss2);

disp("x: ");
disp(x_gauss2);
disp("operation count, time: "+num2str(opCnt_gauss2)+", "+num2str(execT_gauss2));
disp(repmat('*',1,50));

disp("Verify: ");

x_veri_backslash_gauss=A_gauss2\b_gauss2;

disp("A \ b: ");
disp(x_veri_backslash_gauss);

[L_veri_gauss,U_veri_gauss]=lu(A_gauss2);
x_veri_lu_gauss=U_veri_gauss\(L_veri_gauss\b_gauss2);

disp("LU: ");
disp(x_veri_lu_gauss);

R_verify_gauss=rref([A_gauss2,b_gauss2]);
x_verify_rref_gauss=R_verify_gauss(:,end);

disp("rref: ");
disp(x_verify_rref_gauss);

disp(repmat('=',1,50));

%% 直接三角分解法
disp("myLU");
disp(repmat('*',1,50));

disp("ex 5.3.1: ")
A_LU1=[2,1,5;4,1,12;-2,-4,5];b_LU1=[11;27;12];

[x_LU1,y_LU1,L_LU1,U_LU1,opCnt_LU1,execT_LU1]=myLU(A_LU1,b_LU1);

disp("x: ")
disp(x_LU1);
disp("y: ")
disp(y_LU1);
disp("L ");
disp(L_LU1);
disp("U: ");
disp(U_LU1);
disp("operation count, time: "+num2str(opCnt_LU1)+", "+num2str(execT_LU1));
disp(repmat('*',1,50));

disp("Other test: ");
A_LU2_str=input("A (order >= 4) = ","s");
b_LU2_str=input("b (dim = A's order) = ","s");
A_LU2=eval(A_LU2_str);b_LU2=eval(b_LU2_str);

[x_LU2,y_LU2,L_LU2,U_LU2,opCnt_LU2,execT_LU2]=myLU(A_LU2,b_LU2);

disp("x: ")
disp(x_LU2);
disp("y: ")
disp(y_LU2);
disp("L ");
disp(L_LU2);
disp("U: ");
disp(U_LU2);
disp("operation count, time: "+num2str(opCnt_LU2)+", "+num2str(execT_LU2));
disp(repmat('*',1,50));

disp("Verify: ");

x_veri_backslash_LU=A_LU2\b_LU2;

disp("A \ b: ");
disp(x_veri_backslash_LU);

[L_veri_LU,U_veri_LU]=lu(A_LU2);
x_veri_lu_LU=U_veri_LU\(L_veri_LU\b_LU2);

disp("LU: ");
disp("L: ")
disp(L_veri_LU);
disp("U: ");
disp(U_veri_LU);
disp("x: ");
disp(x_veri_lu_LU);

R_verify_LU=rref([A_LU2,b_LU2]);
x_verify_rref_LU=R_verify_LU(:,end);

disp("rref: ");
disp(x_verify_rref_LU);

disp(repmat('=',1,50));
