function b=bpp(qnz,n,Q)
S=0;
for c = 1:3
    for j = 1:n:size(qnz,1)-(n-1)%n denotes block size
        for k = 1:n:size(qnz,2)
            n_qnz = qnz(j:j+(n-1),k:k+(n-1),c);
                [NZ,IDX,AS,dc]=adaptive_scan(n_qnz); %doing for types of scan in each block 
                [E,B]=encode(Q,n,NZ,IDX,AS,dc);      %gives encoded vector & no. of bits used
                if S==0
                fileID=fopen('binaryimage.bin','w'); %storing encoded vector in a binary file
                fwrite(fileID,E,'ubit1');
                fclose(fileID);
                S=S+B;
                else
                fileID=fopen('binaryimage.bin','a');
                fwrite(fileID,E,'ubit1');
                fclose(fileID);
                S=S+B;
                end
                    
        end
    end
end
%S=S+Q*(512*512*3)/(n*n);
%b=S;
b=S/(512*512); %gives bits per pixel of an image
end