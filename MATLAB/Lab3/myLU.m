%{
直接三角分解法

功能: 求可逆方阵 A 的 Doolittle 分解, 并解方程组 Ax = b (要求 A 必须为方阵, 且阶数等于 b 的维数)
输入:
    A: 系数矩阵
    b: 常数向量
输出:
    x: Ux = y 的解 (即 Ax = b 的解)
    y: Ly = b 的解
    L: 下三角矩阵
    U: 上三角矩阵
    opCnt: 总的乘除法次数
    execT: 总的运行时间
%}

function [x,y,L,U,opCnt,execT]=myLU(A,b)
tic;

[rows,cols]=size(A);n=length(b);x=zeros(n,1);y=zeros(n,1);L=eye(n,n);U=zeros(n,n);
op_LU=0;op_y=0;op_x=0;

if rows==cols && cols==n && n>0
    U(1,:)=A(1,:);
    L(2:n,1)=A(2:n,1)/U(1,1);
    op_LU=op_LU+n-1;

    disp("Info: myLU: Init: ");
    disp("L: ");
    disp(L);
    disp("U: ")
    disp(U);
    disp(repmat('-',1,50));

    for k=2:n
        ops=0;
        disp("Info: myLU: Starting U's row and L's col: "+num2str(k));

        U(k,k:n)=A(k,k:n)-L(k,1:k-1)*U(1:k-1,k:n);
        ops=ops+(k-1)*(n-k+1);
        L((k+1):n,k)=(A((k+1):n,k)-L((k+1):n,1:(k-1))*U(1:(k-1),k))/U(k,k);
        ops=ops+(k-1)*(n-k)+(n-k);

        op_LU=op_LU+ops;

        disp("after this step: ");
        disp("L: ");
        disp(L);
        disp("U: ");
        disp(U);
        disp("operation count: "+num2str(ops));
        disp(repmat('-',1,50));
    end

    disp("Info: myLU: Finish factorization: ");
    disp("L: ")
    disp(L);
    disp("U: ");
    disp(U);
    disp("factorizaion total operation count: "+num2str(op_LU));
    disp(repmat('-',1,50));

    y(1)=b(1);

    for k=2:n
        y(k)=b(k)-L(k,1:(k-1))*y(1:k-1);
        op_y=op_y+(k-1);
    end

    disp("Info: myLU: Finish y: ")
    disp(y);
    disp("y total operation count: "+num2str(op_y));
    disp(repmat('-',1,50));

    x(n)=y(n)/U(n,n);
    op_x=op_x+1;

    for k=(n-1):-1:1
        x(k)=(y(k)-U(k,(k+1):n)*x((k+1):n))/U(k,k);
        op_x=op_x+(n-k)+1;
    end

    disp("Info: myLU: Finish x: ")
    disp(x);
    disp("x total operation count: "+num2str(op_x));
    disp(repmat('-',1,50));

    opCnt=op_LU+op_y+op_x;
else
    error("ERROR: myLU: invaild input");
end

execT=toc;
end
