%{
不动点迭代法求方程根

功能: 使用不动点迭代法, 求迭代函数为 g(x) 的方程 f(x) = 0 的根
输入:
    g: 函数句柄, 表示方程 g(x) (@(x) g(x))
    x0: 初始点
    eps: 期望精度
    maxIter: 最大迭代次数
输出:
    x: 近似解
    aproxs: 每次迭代的近似值
    opCnt: 非函数乘除法运算次数
    execT: 执行时间 (s)
%}

function [x,aproxs,opCnt,execT]=fixedPoint(g,x0,eps,maxIter)
tic;

if isa(g,"function_handle")
    x=x0;aproxs=zeros(maxIter,1);opCnt=0;cnt=0;

    while cnt<maxIter
        x1=feval(g,x);

        if abs(x1-x)<eps
            break;
        end

        x=x1;cnt=cnt+1;aproxs(cnt)=x;
    end
else
    error("ERROR: fixedPoint: invalid g")
end

aproxs=aproxs(1:cnt);

if cnt==maxIter
    warning("Warning: fixedPoint: maxIter reached")
end

execT=toc;
end
