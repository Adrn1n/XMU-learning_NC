%{
列主元高斯消去法

功能: 列主元素高斯消去法解方程组 Ax = b (要求 A 必须为方阵, 且阶数等于 b 的维数)
输入:
    A: 系数方阵
    b: 常数向量
输出:
    x: 方程组的解
    opCnt: 总的乘除法次数
    exexT: 总的运行时间
%}

function[x,opCnt,execT]=myGauss(A,b)
tic;

[rows,cols]=size(A);n=length(b);x=zeros(n,1);
op_elim=0;op_bksub=0;

if rows==cols && cols==n && n>0
    A=[A,b];

    for k=1:(n-1)
        disp("Info: myGauss: Starting elimination: "+num2str(k));
        disp("before selecting: ");
        disp(A);

        % [ar,r]=max(abs(A(k:n,k)));
        [~,r]=max(abs(A(k:n,k)));
        r=r+k-1;

        if r>k
            t=A(k,:);A(k,:)=A(r,:);A(r,:)=t;
        end

        disp("after selecting: ");
        disp(A);

        A((k+1):n,(k+1):(n+1))=A((k+1):n,(k+1):(n+1))-(A((k+1):n,k)/A(k,k))*A(k,(k+1):(n+1));
        ops=(n-k)+(n-k)*(n-k);
        A((k+1):n,k)=zeros(n-k,1); % //

        op_elim=op_elim+ops;

        disp("after this elimination: ");
        disp(A);
        disp("operation count: "+num2str(ops));
        disp(repmat('-',1,50));
    end

    disp("Info: myGauss: Elimination total operation count: "+num2str(op_elim));
    disp(repmat('-',1,50));

    x(n)=A(n,n+1)/A(n,n);
    op_bksub=op_bksub+1;

    for k=n-1:-1:1
        x(k,:)=(A(k,n+1)-A(k,(k+1):n)*x((k+1):n))/A(k,k);
        op_bksub=op_bksub+(n-k)+1;
    end

    disp("Info: myGauss: Backsub operation count: "+num2str(op_bksub));
    disp(repmat('-',1,50));

    opCnt=op_elim+op_bksub;
else
    error("ERROR: myGauss: invalid input");
end

execT=toc;
end
