%{
Gauss-Seidel 迭代法

功能: 高斯-赛德尔迭代法解方程组 Ax = b (要求 A 必须为方阵, 且阶数等于 b 的维数)
输入:
    A: 系数阵
    b: 右端向量
    x0: 初始向量 % (默认 0 向量)
    e: 精度
    N: 最大迭代次数
输出:
    B_GS: Gauss-Seidel 迭代矩阵
    x: 解向量
%}

function[B_GS,x]=myGS(A,b,x0,e,N)
[rows,cols]=size(A);n=length(b);n0=length(x0);

if rows==cols && cols==n && n==n0 && n>0
    D=diag(diag(A));L=-tril(A,-1);U=-triu(A,1);B_GS=(D-L)\U;
    x=x0;x0=x+2*e;
    k=0;

    while norm(x-x0,inf)>e && k<N
        x0=x;x=B_GS*x+(D-L)\b;
        k=k+1;
    end

    if(k>=N)
        warning("Warning: myGS: maxIter reached");
    end
else
    error("ERROR: myGS: invaild input");
end
