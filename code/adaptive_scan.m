function [NZ,IDX,AS,DC]=adaptive_scan(m)
%takes input 2D matrix
%output gives NZ ,IDX , AS vectors & DC value of one block
DC=m(1,1);
ZS=tozigzag(m);  %gives vector after doing zig zag scan
HS=horizontal(m);%gives vector after doing horizontal scan
VS=vertical(m);  %gives vector after doing vertical scan
BS=hlbrtcrv(m);  %gives vector after doing hilbert scan
  [a1,b1,c1]=vectors(ZS');
  [a2,b2,c2]=vectors(HS);
  [a3,b3,c3]=vectors(VS);
  [a4,b4,c4]=vectors(BS);
  c=min([c1 c2 c3 c4]);
  if c==c1 
      NZ=a1;IDX=b1;AS=[0 0];
  elseif c==c2
           NZ=a2;IDX=b2;AS=[0 1];
  elseif c==c3
               NZ=a3;IDX=b3;AS=[1 0];
  elseif c==c4
               NZ=a4;IDX=b4;AS=[1 1];
  end
end
function [a,b,c]=vectors(v)% takes vector V and give NZ ,IDX & max(IDX)as output
a=[];b=[];s=0;
N=length(v);
for i=2:N
    if v(i)==0
        s=s+1;
    else
        a=[a v(i)];
        b=[b s];
        s=0;
    end
end
if isempty(b)
    c=0;
else
    c=max(b);
end
end
