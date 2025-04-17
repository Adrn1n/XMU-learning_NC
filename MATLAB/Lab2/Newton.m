%{
牛顿法求方程根

功能: 使用牛顿法, 求方程 f(x) = 0 的根
输入:
    f: 函数句柄, 表示方程 f(x) (@(x) f(x))
    df_dx: 函数句柄, 表示函数的导数 f'(x) (@(x) f'(x))
    x0: 初始点
    eps: 期望精度
    maxIter: 最大迭代次数
输出:
    x: 近似解
    aproxs: 每次迭代的近似值
    opCnt: 非函数乘除法运算次数
    execT: 执行时间 (s)
%}

function [x,aproxs,opCnt,execT]=Newton(f,df_dx,x0,eps,maxIter)
tic;

if isa(f,"function_handle") && isa(df_dx,"function_handle")
    x=x0;aproxs=zeros(maxIter,1);opCnt=0;cnt=0;

    while cnt<maxIter
        x1=x-feval(f,x)/feval(df_dx,x);

        if abs(x1-x)<eps
            break;
        end

        x=x1;opCnt=opCnt+1;cnt=cnt+1;aproxs(cnt)=x;
    end
else
    error("ERROR: Newton: invalid f or df_dx")
end

aproxs=aproxs(1:cnt);

if cnt==maxIter
    warning("Warning: Newton: maxIter reached")
end

execT=toc;
end
