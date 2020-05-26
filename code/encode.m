function [E,B]=encode(Q,n,NZ,IDX,AS,DC)
P=log2(n*n);  %P bits
L1=length(NZ);%L1 length of NZ & IDX vector
if isempty(IDX)&&isempty(NZ) % this condition is apply when there is only DC value in a block
    B=P+Q;
    dc=decimalToBinaryVector(DC,Q);
    e=decimalToBinaryVector(L1,P);
    E=[dc e]; %E encoded vector obtained
else
 if max(IDX)==0||max(IDX)==1
     q1=1;
 else
     k=log2(max(IDX));
     if floor(k)==k
     q1=ceil(k)+1;
     else
     q1=ceil(k);
     end
 end
B=2*P+Q+2+(Q*L1)+(q1*L1);%total byte for one block 
L=decimalToBinaryVector(L1,P);
q=decimalToBinaryVector(q1,P);
dc=decimalToBinaryVector(DC,Q);
nz=horizontal(decimalToBinaryVector(NZ,Q));
idx=horizontal(decimalToBinaryVector(IDX,q1));
E=[dc L AS q nz idx];%E = global header
end
end