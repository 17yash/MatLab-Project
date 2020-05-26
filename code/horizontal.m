function x=horizontal(M)
%input m 2D matrix
%output gives vector after doing horizontal scan in a matrix
[m,n]=size(M);
x=zeros(1,m*n);
c=1;
for i=1:m
    for j=1:n
        x(c)=M(i,j);
        c=c+1;
    end
end
end