%{
二分法求方程根

功能: 使用二分法求方程 f(x) = 0 的根
输入:
    f: 函数句柄, 表示方程 f(x) (@(x) f(x))
    a, b: 区间端点, 要求 f(a) * f(b) < 0
    eps: 期望精度
    maxIter: 最大迭代次数
输出:
    x: 近似解
    aproxs: 每次迭代的近似值
    opCnt: 非函数乘除法运算次数
    execT: 执行时间 (s)
%}

function [x,aproxs,opCnt,execT]=bisect(f,a,b,eps,maxIter)
tic;

if isa(f,"function_handle")
    fa=feval(f,a);fb=feval(f,b);

    if fa*fb>0
        error("ERROR: bisect: f(a) * f(b) > 0")
    end

    x=(a+b)/2;aproxs=zeros(maxIter,1);opCnt=0;cnt=0;

    while cnt<maxIter
        if abs(b-a)<2*eps
            break;
        end

        x=(a+b)/2;opCnt=opCnt+1;fx=feval(f,x);

        if fa*fx<0
            % b=x;fb=fx;
            b=x;
        else
            a=x;fa=fx;
        end

        cnt=cnt+1;aproxs(cnt)=x;
    end
else
    error("ERROR: bisect: invalid f")
end

aproxs=aproxs(1:cnt);

if cnt==maxIter
    warning("Warning: bisect: maxIter reached")
end

execT=toc;
end
