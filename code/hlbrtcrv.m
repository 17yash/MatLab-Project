function x=hlbrtcrv(X)
%input m 2D matrix
%output gives vector after doing hilbert scan in a matrix
[M,N]=size(X);
x=zeros(1,M*N);
Y=hilbert(max([M N]));
Y=Y(1:M,1:N);
Y=Y(1:M*N)';
[s, I]=sort(Y);
	[R,S]=meshgrid(1:N,1:M);
	R=R(I);
	S=S(I);

R=R';
S=S';
for i=1:M*N
    x(i)=X(S(i),R(i));
end
    
return;