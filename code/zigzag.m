function x=zigzag(m)
%input m 2D matrix
%output gives vector after doing zig zag scan in a matrix
[r,s]=size(m);
x=zeros(1,r*s);
c=1;
for i=1:r
        for j=1:i
            if mod(i,2)==1
            x(c)=m(i+1-j,j);
            else
            x(c)=m(j,i+1-j);
            end
            c=c+1;
        end
end
for i=1:r-1
    for j=1:(r-i)
        if mod(i,2)==1
            x(c)=m(r+1-j,i+j);
        else 
            x(c)=m(i+j,r+1-j);
        end
        c=c+1;
    end
end
end   