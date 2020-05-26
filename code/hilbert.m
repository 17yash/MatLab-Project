function Y=hilbert(X)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Y = hilbert(X)
% HILBERT (function)
%	This function generates a square matrix of size
%       2^(ceil(log_2(X))) containing the indices of the
%	Hilbert space filling curve.  
%
% INPUT ARGUMENTS:
%	X    -> As a scalar, indicates the size of the
%	   	resulting Hilbert curve.
%
%		If X is a Hilbert curve matrix, the output
%		is a Hilbert curve one iteration after X.
%
% OUTPUT ARGUMENT:
%	Y    -> Matrix holding Hilbert curve.
%
% EXAMPLE:
%	Y = hilbert(32);
%	imagesc(Y);
%	axis image;
%	hold on;
%	[R,S] = hlbrtcrv(32,32);
%	plot(R,S,'r');
%
% Daniel Leo Lau
% lau@ece.udel.edu
%
% June 16, 1998
% Copyright 1998 Daniel Leo Lau
%
% Last modified on June 16, 1998
% Tested using Matlab 5.1.0.421
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (size(X,1)==1 && size(X,2)==1)
      x=ceil(log10(X)/log10(2));
      Y=[0 3
         1 2];
      for l=1:x-1
            Y=hilbert(Y);
      end
      return;
end
[M, N]=size(X);
if (M~=2 && N~=2)
      Y=[hilbert(X(1:M/2  ,1:N/2)) hilbert(X(1:M/2  ,N/2+1:N))
	 hilbert(X(M/2+1:M,1:N/2)) hilbert(X(M/2+1:M,N/2+1:N))];
else
      offset=min(min(X));
      X=X-offset;
      A=[0 3
         1 2];
      B=[0  1  14 15
         3  2  13 12
         4  7  8  11
         5  6  9  10];
      C=rot90(A);
      D=rot90(B);
      if     (all(all(X==A)))
	     Y=B;
      elseif (all(all(X==fliplr(A))))
             Y=fliplr(B);
      elseif (all(all(X==flipud(A))))
             Y=flipud(B);
      elseif (all(all(X==fliplr(flipud(A)))))
             Y=fliplr(flipud(B));
      elseif (all(all(X==C)))
	     Y=D;
      elseif (all(all(X==fliplr(C))))
             Y=fliplr(D);
      elseif (all(all(X==flipud(C))))
             Y=flipud(D);
      elseif (all(all(X==fliplr(flipud(C)))))
             Y=fliplr(flipud(D));
      end
      Y=Y+offset*4;
end
return
