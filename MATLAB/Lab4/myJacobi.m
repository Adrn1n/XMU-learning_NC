%{
Jacobi 迭代法

功能: 雅可比迭代法解方程组 Ax = b (要求 A 必须为方阵, 且阶数等于 b 的维数)
输入:
    A: 系数阵
    b: 右端向量
    x0: 初始向量 % (默认 0 向量)
    e: 精度
    N: 最大迭代次数
输出:
    B_J: Jacobi 迭代矩阵
    x: 解向量
%}

function[B_J,x]=myJacobi(A,b,x0,e,N)
[rows,cols]=size(A);n=length(b);n0=length(x0);

if rows==cols && cols==n && n==n0 && n>0
    D=diag(diag(A));L=-tril(A,-1);U=-triu(A,1);B_J=D\(L+U);
    x=x0;x0=x+2*e;
    k=0;

    while norm(x-x0,inf)>e && k<N
        x0=x;x=B_J*x+D\b;
        k=k+1;
    end

    if(k>=N)
        warning("Warning: myJacobi: maxIter reached");
    end
else
    error("ERROR: myJacobi: invaild input");
end
