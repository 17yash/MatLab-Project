function y=toZigzag(x)
% transform a matrix to the zigzag format

%x=reshape(1:16,[4 4])';

[row,col]=size(x);

if row~=col
disp('toZigzag() fails!! Must be a square matrix!!');
return;
end

y=zeros(row*col,1);
count=1;
for s=1:row
if mod(s,2)==0
for m=s:-1:1
y(count)=x(m,s+1-m);
count=count+1;
end
else
for m=1:s
y(count)=x(m,s+1-m);
count=count+1;
end
end
end

if mod(row,2)==0
flip=1;
else
flip=0;
end

for s=row+1:2*row-1
if mod(flip,2)==0
for m=row:-1:s+1-row
y(count)=x(m,s+1-m);
count=count+1;
end
else
for m=row:-1:s+1-row
y(count)=x(s+1-m,m);
count=count+1;
end
end
flip=flip+1;
end