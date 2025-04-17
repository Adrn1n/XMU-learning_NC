%{
弦截法求方程根

功能: 使用弦截法, 求方程 f(x) = 0 的根
输入:
    f: 函数句柄, 表示方程 f(x) (@(x) f(x))
    x0: 初始点
    k: 初始偏移系数, k (> 1) 倍的期望精度
    eps: 期望精度
    maxIter: 最大迭代次数
输出:
    x: 近似解
    aproxs: 每次迭代的近似值
    opCnt: 非函数乘除法运算次数
    execT: 执行时间 (s)
%}

function [x,aproxs,opCnt,execT]=Secant(f,x0,k,eps,maxIter)
tic;

if isa(f,"function_handle")
    x=x0;x1=x+k*eps;aproxs=zeros(maxIter,1);opCnt=0;cnt=0;

    while cnt<maxIter
        f_val=feval(f,x);x2=x-f_val/((f_val-feval(f,x1))/(x-x1));

        if abs(x2-x1)<eps
            break;
        end

        x=x1;x1=x2;opCnt=opCnt+2;cnt=cnt+1;aproxs(cnt)=x;
    end
else
    error("ERROR: Secant: invalid f")
end

aproxs=aproxs(1:cnt);

if cnt==maxIter
    warning("Warning: Secant: maxIter reached")
end

execT=toc;
end
